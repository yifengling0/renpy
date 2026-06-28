"""
Full module loading test for Ren'Py on HarmonyOS.
Tests each .so module individually to identify which ones load 
and which ones fail (and why).
"""
import sys
import os
import importlib

BASE = '/data/local/tmp/renpy_test'
sys.path.insert(0, BASE)
sys.path.insert(0, os.path.join(BASE, 'lib'))

# ============================================================
# Layer 1: Python stdlib C extensions
# ============================================================
print("=" * 60)
print("LAYER 1: Python stdlib C extensions")
print("=" * 60)
stdlib_modules = [
    'struct', 'ctypes', 'pickle', 'math', 'zlib', 
    'hashlib', 'json', 'socket', 'select', 'array',
    'binascii', 'unicodedata', '_decimal',
]
stdlib_ok = 0
stdlib_fail = 0
for mod in stdlib_modules:
    try:
        importlib.import_module(mod)
        stdlib_ok += 1
    except Exception as e:
        print(f"  FAIL: {mod}: {e}")
        stdlib_fail += 1
print(f"  Result: {stdlib_ok}/{len(stdlib_modules)} OK, {stdlib_fail} FAIL")

# ============================================================
# Layer 2: Non-SDL2 Ren'Py modules (should load without SDL2)
# ============================================================
print()
print("=" * 60)
print("LAYER 2: Non-SDL2 Ren'Py C extensions")
print("=" * 60)
non_sdl_modules = [
    'renpy.astsupport',
    'renpy.cslots',
    'renpy.encryption',
    'renpy.lexersupport',
    'renpy.pydict',
    'renpy.tfd',
    'renpy.style',
    'renpy.styledata.styleclass',
    'renpy.styledata.stylesets',
    'renpy.styledata.style_functions',
    'renpy.styledata.style_hover_functions',
    'renpy.styledata.style_idle_functions',
    'renpy.styledata.style_insensitive_functions',
    'renpy.styledata.style_activate_functions',
    'renpy.styledata.style_selected_functions',
    'renpy.styledata.style_selected_hover_functions',
    'renpy.styledata.style_selected_idle_functions',
    'renpy.styledata.style_selected_insensitive_functions',
    'renpy.styledata.style_selected_activate_functions',
    'renpy.text.textsupport',
    'renpy.text.texwrap',
    'renpy.text.bidi',
    'renpy.display.matrix',
    'renpy.display.quaternion',
]
non_sdl_ok = 0
non_sdl_fail = 0
for mod in non_sdl_modules:
    try:
        importlib.import_module(mod)
        non_sdl_ok += 1
        print(f"  OK:   {mod}")
    except Exception as e:
        err = str(e).split('\n')[0][:80]
        print(f"  FAIL: {mod}: {err}")
        non_sdl_fail += 1
print(f"  Result: {non_sdl_ok}/{len(non_sdl_modules)} OK, {non_sdl_fail} FAIL")

# ============================================================
# Layer 3: Font/text modules (need freetype/harfbuzz)
# ============================================================
print()
print("=" * 60)
print("LAYER 3: Font/text modules (freetype/harfbuzz)")
print("=" * 60)
font_modules = [
    'renpy.text.ftfont',
    'renpy.text.hbfont',
]
font_ok = 0
font_fail = 0
for mod in font_modules:
    try:
        importlib.import_module(mod)
        font_ok += 1
        print(f"  OK:   {mod}")
    except Exception as e:
        err = str(e).split('\n')[0][:80]
        print(f"  FAIL: {mod}: {err}")
        font_fail += 1
print(f"  Result: {font_ok}/{len(font_modules)} OK, {font_fail} FAIL")

# ============================================================
# Layer 4: SDL2-dependent modules
# ============================================================
print()
print("=" * 60)
print("LAYER 4: SDL2-dependent modules")
print("=" * 60)
sdl_modules = [
    '_renpy',
    'renpy.pygame.error',
    'renpy.pygame.rect',
    'renpy.pygame.color',
    'renpy.pygame.surface',
    'renpy.pygame.event',
    'renpy.pygame.key',
    'renpy.pygame.locals',
    'renpy.pygame.display',
    'renpy.pygame.draw',
    'renpy.pygame.gfxdraw',
    'renpy.pygame.image',
    'renpy.pygame.joystick',
    'renpy.pygame.controller',
    'renpy.pygame.mouse',
    'renpy.pygame.power',
    'renpy.pygame.pygame_time',
    'renpy.pygame.rwobject',
    'renpy.pygame.scrap',
    'renpy.pygame.transform',
    'renpy.display.render',
    'renpy.display.accelerator',
    'renpy.audio.filter',
    'renpy.audio.renpysound',
    'renpy.uguu.gl',
    'renpy.uguu.uguu',
    'renpy.gl2.gl2draw',
    'renpy.gl2.gl2mesh',
    'renpy.gl2.gl2mesh2',
    'renpy.gl2.gl2mesh3',
    'renpy.gl2.gl2model',
    'renpy.gl2.gl2polygon',
    'renpy.gl2.gl2shader',
    'renpy.gl2.gl2texture',
    'renpy.gl2.gl2uniform',
]
sdl_ok = 0
sdl_fail = 0
for mod in sdl_modules:
    try:
        importlib.import_module(mod)
        sdl_ok += 1
        print(f"  OK:   {mod}")
    except Exception as e:
        err = str(e).split('\n')[0][:80]
        print(f"  FAIL: {mod}: {err}")
        sdl_fail += 1
print(f"  Result: {sdl_ok}/{len(sdl_modules)} OK, {sdl_fail} FAIL")

# ============================================================
# Layer 5: Shared library loading with ctypes
# ============================================================
print()
print("=" * 60)
print("LAYER 5: Shared library loading (ctypes)")
print("=" * 60)
import ctypes
libs_to_test = [
    'libpython3.12.so.1.0',
    'libz.so',
    'libpng16.so',
    'libfreetype.so',
    'libfribidi.so',
    'libharfbuzz.so',
    'libjpeg.so',
    'libffi.so',
    'libSDL2.so',
    'libSDL2_image-2.0.so',
    'libSDL2_mixer-2.0.so',
    'libSDL2_ttf-2.0.so',
]
lib_ok = 0
lib_fail = 0
for lib in libs_to_test:
    path = os.path.join(BASE, 'lib', lib)
    try:
        ctypes.CDLL(path)
        lib_ok += 1
        print(f"  OK:   {lib}")
    except Exception as e:
        err = str(e).split('\n')[0][:80]
        print(f"  FAIL: {lib}: {err}")
        lib_fail += 1
print(f"  Result: {lib_ok}/{len(libs_to_test)} OK, {lib_fail} FAIL")

# ============================================================
# Layer 6: Functional tests for loaded modules
# ============================================================
print()
print("=" * 60)
print("LAYER 6: Functional tests")
print("=" * 60)
func_ok = 0
func_fail = 0

# Test matrix operations
try:
    from renpy.display.matrix import Matrix
    m = Matrix([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1])
    print(f"  OK:   Matrix identity created: {type(m)}")
    func_ok += 1
except Exception as e:
    print(f"  FAIL: Matrix: {e}")
    func_fail += 1

# Test quaternion
try:
    from renpy.display.quaternion import Quaternion
    q = Quaternion([0, 0, 0, 1])
    print(f"  OK:   Quaternion created: {type(q)}")
    func_ok += 1
except Exception as e:
    print(f"  FAIL: Quaternion: {e}")
    func_fail += 1

# Test textsupport
try:
    from renpy.text.textsupport import Glyph
    print(f"  OK:   Glyph class accessible: {Glyph}")
    func_ok += 1
except Exception as e:
    print(f"  FAIL: Glyph: {e}")
    func_fail += 1

# Test Rect if pygame loaded
try:
    from renpy.pygame.rect import Rect
    r = Rect(0, 0, 100, 100)
    print(f"  OK:   Rect created: {r}")
    func_ok += 1
except Exception as e:
    print(f"  FAIL: Rect: {e}")
    func_fail += 1

# Test Color if pygame loaded
try:
    from renpy.pygame.color import Color
    c = Color(255, 0, 0, 255)
    print(f"  OK:   Color created: {c}")
    func_ok += 1
except Exception as e:
    print(f"  FAIL: Color: {e}")
    func_fail += 1

print(f"  Result: {func_ok}/{func_ok + func_fail} OK, {func_fail} FAIL")

# ============================================================
# Summary
# ============================================================
print()
print("=" * 60)
total_ok = stdlib_ok + non_sdl_ok + font_ok + sdl_ok + lib_ok + func_ok
total_fail = stdlib_fail + non_sdl_fail + font_fail + sdl_fail + lib_fail + func_fail
print(f"TOTAL: {total_ok}/{total_ok + total_fail} OK, {total_fail} FAIL")
print("=" * 60)
