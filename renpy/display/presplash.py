# Copyright 2004-2026 Tom Rothamel <pytom@bishoujo.us>
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Pre-splash code. The goal of this code is to try to get a pre-splash
# screen up as soon as possible, to let the user know something is
# going on.

from __future__ import division, absolute_import, with_statement, print_function, unicode_literals
from renpy.compat import PY2, basestring, bchr, bord, chr, open, pystr, range, round, str, tobytes, unicode  # *


import os
import sys
import time

import renpy
import renpy.pygame as pygame

if renpy.emscripten:
    import emscripten

# The window.
window = None

# The progress bar (if exists).
progress_bar = None

# Offset for centering presplash on fullscreen (HarmonyOS).
_presplash_offset = (0, 0)

# The start time.
start_time = time.time()


class ProgressBar(object):
    def __init__(self, foreground, background):
        super(ProgressBar, self).__init__()
        self.foreground = pygame.image.load(foreground)
        self.background = pygame.image.load(background)
        self.width, self.height = self.background.get_size()

    def convert_alpha(self, surface=None):
        self.foreground = self.foreground.convert_alpha(surface)
        self.background = self.background.convert_alpha(surface)

    def get_size(self):
        return (self.width, self.height)

    def get_at(self, pos):
        return self.background.get_at(pos)

    def draw(self, target, done, offset=(0, 0)):
        width = self.width * min(done, 1)
        foreground = self.foreground.subsurface(0, 0, width, self.height)
        target.blit(self.background, offset)
        target.blit(foreground, offset)


def find_file(base_name, root):
    allowed_exts = [".png", ".jpg", ".webp", ".avif"]
    for ext in allowed_exts:
        fn = os.path.join(root, base_name + ext)
        if os.path.exists(fn):
            return fn
    return None


def start(basedir, gamedir):
    """
    Called to display the presplash when necessary.
    """

    if "RENPY_LESS_UPDATES" in os.environ:
        return

    # Skip presplash on Android/iOS (handled by native layer)
    if renpy.android or renpy.ios:
        return

    if renpy.harmonyos:
        print(f'[Presplash] gamedir = {gamedir}')
        print(f'[Presplash] gamedir exists = {os.path.isdir(gamedir)}')
        if os.path.isdir(gamedir):
            try:
                files = os.listdir(gamedir)
                splash_files = [f for f in files if 'presplash' in f.lower()]
                print(f'[Presplash] presplash files in gamedir: {splash_files}')
            except Exception as e:
                print(f'[Presplash] listdir error: {e}')

    foreground_fn = find_file("presplash_foreground", root=gamedir)
    background_fn = find_file("presplash_background", root=gamedir)

    if not foreground_fn or not background_fn:
        presplash_fn = find_file("presplash", root=gamedir)

        if not presplash_fn:
            if renpy.harmonyos:
                print(f'[Presplash] No presplash image found in {gamedir}, skipping')
            return

    if renpy.harmonyos:
        print(f'[Presplash] foreground={foreground_fn}, background={background_fn}')
        if not foreground_fn or not background_fn:
            print(f'[Presplash] presplash={presplash_fn}')

    if renpy.windows:
        import ctypes

        ctypes.windll.user32.SetProcessDPIAware()  # type: ignore

    try:
        pygame.display.init()
    except Exception as e:
        if renpy.harmonyos:
            print(f'[Presplash] pygame.display.init() failed: {e}')
        return

    global progress_bar

    if foreground_fn and background_fn:
        presplash = ProgressBar(foreground_fn, background_fn)  # type: ignore
        progress_bar = presplash
    else:
        presplash = pygame.image.load(presplash_fn)

    global window
    global _presplash_offset

    sw, sh = presplash.get_size()

    if renpy.harmonyos:
        # HarmonyOS: use FULLSCREEN to get the XComponent-managed window surface.
        # Without FULLSCREEN, set_mode((0,0)) creates a 1x1 window because
        # g_ohosSurfaceWidth/Height hasn't been set yet by OnSurfaceCreatedCB.
        # FULLSCREEN makes SDL use the display mode resolution (g_ohosDeviceWidth/Height)
        # which is always valid (set from display.getDefaultDisplaySync()).
        try:
            surface = pygame.display.set_mode((0, 0), pygame.FULLSCREEN)
            window = pygame.display.get_window()

            ww, wh = surface.get_size()
            print(f'[Presplash] window size={ww}x{wh}, image size={sw}x{sh}')
            _presplash_offset = ((ww - sw) // 2, (wh - sh) // 2)

            surface.fill((0, 0, 0))

            if foreground_fn and background_fn:
                presplash.convert_alpha(surface)
                presplash.draw(surface, 0, _presplash_offset)
            else:
                presplash = presplash.convert_alpha(surface)
                surface.blit(presplash, _presplash_offset)

            pygame.display.flip()
            print('[Presplash] HarmonyOS presplash displayed successfully')
        except Exception as e:
            print(f'[Presplash] HarmonyOS display error: {e}')
            import traceback
            traceback.print_exc()
            window = None
            return
    else:
        # Desktop: create a separate borderless presplash window.
        bounds = pygame.display.get_display_bounds(0)

        x = bounds[0] + bounds[2] // 2 - sw // 2
        y = bounds[1] + bounds[3] // 2 - sh // 2

        if presplash.get_at((0, 0))[3] == 0:
            shape = presplash
        else:
            shape = None

        if isinstance(shape, ProgressBar):
            shape = shape.background

        window = pygame.display.Window(
            sys.argv[0], (sw, sh), flags=pygame.WINDOW_BORDERLESS, pos=(x, y), shape=shape
        )

        if foreground_fn and background_fn:
            presplash.convert_alpha(window.get_surface())
            presplash.draw(window.get_surface(), 0)
        else:
            presplash = presplash.convert_alpha(window.get_surface())
            window.get_surface().blit(presplash, (0, 0))

        window.update()


# The last time the progress bar was updated.
last_pump_time = 0

# The number of times the progress was pumped.
pump_count = 0
pump_clock = 21
pump_total = 0


def pump_window():
    global last_pump_time
    global pump_count, pump_total

    pump_count += 1

    if renpy.emscripten:
        emscripten.sleep(0)

    if window is None:
        return

    if last_pump_time + 1 / 24 > time.time():
        return

    last_pump_time = time.time()

    for ev in pygame.event.get():
        if ev.type == pygame.QUIT:
            raise renpy.game.QuitException(relaunch=False, status=0)

    if not progress_bar:
        return

    if not pump_total:
        if not renpy.game.script:
            return

        pump_total = (len(renpy.game.script.common_script_files) + len(renpy.game.script.script_files)) + pump_clock

    surface = window.get_surface()

    # On HarmonyOS (fullscreen), use pygame.display surface and flip()
    if renpy.harmonyos:
        surface = pygame.display.get_surface()
        if surface is None:
            return

        sw, sh = progress_bar.get_size()
        ww, wh = surface.get_size()
        dx = max(0, (ww - sw) // 2)
        dy = max(0, (wh - sh) // 2)

        surface.fill((0, 0, 0))
        temp = pygame.Surface((sw, sh), pygame.SRCALPHA)
        progress_bar.draw(temp, pump_count / pump_total)
        surface.blit(temp, (dx, dy))
        pygame.display.flip()
        return

    # On HarmonyOS (fullscreen), re-fill background before drawing progress bar
    if _presplash_offset != (0, 0):
        surface.fill((0, 0, 0, 255))

    progress_bar.draw(surface, pump_count / pump_total, _presplash_offset)
    window.update()


# Becomes true when the presplash is done.
done = False


def end():
    """
    Called just before we initialize the display to hide the presplash.
    """

    global window
    global done

    done = True

    if renpy.emscripten:
        emscripten.run_script(r"""presplashEnd();""")

    if window is None:
        return

    if renpy.harmonyos:
        # HarmonyOS: don't destroy window or quit display.
        # The same SDL window (XComponent) will be reused by gl2draw.
        window = None
    else:
        window.destroy()
        window = None

    # Remove references to presplash images
    global progress_bar
    progress_bar = None

    if not renpy.harmonyos:
        pygame.display.quit()


def sleep():
    """
    Pump window to the end of config.minimum_presplash_time.
    """

    if not (window or renpy.mobile):
        return

    end_time = start_time + renpy.config.minimum_presplash_time

    while end_time - time.time() > 0:
        pump_window()


progress_kind = None


def progress(kind, done, total):
    """
    Reports progress to emscripten.

    `kind`
        The kind of progress being reported. This is printed each time
        it changes.

    `done`
        The number of units of progress that are complete.

    `total`
        The total number of units of progress.
    """

    global progress_kind

    if not renpy.emscripten:
        return

    if done == total:
        return

    if progress_kind != kind:
        print()
        print(kind)
        progress_kind = kind
        sys.stdout.flush()

    emscripten.run_script(r"""progress(%d, %d);""" % (done, total))

    emscripten.sleep(0)
