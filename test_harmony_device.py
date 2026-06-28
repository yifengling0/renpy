#!/usr/bin/env python3
"""
Ren'Py HarmonyOS Engine Test Script
====================================
Runs on HarmonyOS device/emulator to verify the engine works correctly.
Tests are structured in layers:
  1. C extension module loading (.cpython-312.so)
  2. Python module imports (renpy package)
  3. Core engine functionality (types, data structures, etc.)
"""

import sys
import os
import traceback

# ============================================================================
# Setup paths
# ============================================================================
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
# Add renpy source root and compiled .so modules to path
sys.path.insert(0, BASE_DIR)
# The .so modules are placed alongside the renpy/ Python package
SO_DIR = os.path.join(BASE_DIR, "lib")
sys.path.insert(0, SO_DIR)

print("=" * 60)
print("  Ren'Py HarmonyOS Engine Test")
print("=" * 60)
print(f"  Python: {sys.version}")
print(f"  Platform: {sys.platform}")
print(f"  Base dir: {BASE_DIR}")
print(f"  SO dir: {SO_DIR}")
print(f"  sys.path: {sys.path[:5]}")
print()

passed = 0
failed = 0
errors = []

def test(name, func):
    global passed, failed
    try:
        result = func()
        if result is not False:
            passed += 1
            print(f"  [PASS] {name}")
            return True
        else:
            failed += 1
            errors.append(name)
            print(f"  [FAIL] {name}")
            return False
    except Exception as e:
        failed += 1
        errors.append(f"{name}: {e}")
        print(f"  [FAIL] {name}: {e}")
        traceback.print_exc()
        return False

# ============================================================================
# Layer 1: C Extension Module Loading
# ============================================================================
print("-" * 60)
print("  Layer 1: C Extension Module Loading")
print("-" * 60)

# Core module
test("import _renpy", lambda: __import__('_renpy'))

# Pygame SDL2 wrapper modules
pygame_modules = [
    'renpy.pygame.error',
    'renpy.pygame.color',
    'renpy.pygame.rect',
    'renpy.pygame.rwobject',
    'renpy.pygame.surface',
    'renpy.pygame.display',
    'renpy.pygame.event',
    'renpy.pygame.key',
    'renpy.pygame.mouse',
    'renpy.pygame.image',
    'renpy.pygame.transform',
    'renpy.pygame.draw',
    'renpy.pygame.gfxdraw',
    'renpy.pygame.joystick',
    'renpy.pygame.controller',
    'renpy.pygame.power',
    'renpy.pygame.pygame_time',
    'renpy.pygame.scrap',
    'renpy.pygame.locals',
]
for mod in pygame_modules:
    test(f"import {mod}", lambda m=mod: __import__(m, fromlist=['']))

# Display/rendering modules
display_modules = [
    'renpy.display.matrix',
    'renpy.display.quaternion',
    'renpy.display.render',
    'renpy.display.accelerator',
]
for mod in display_modules:
    test(f"import {mod}", lambda m=mod: __import__(m, fromlist=['']))

# GL2 renderer modules
gl2_modules = [
    'renpy.gl2.gl2mesh',
    'renpy.gl2.gl2mesh2',
    'renpy.gl2.gl2mesh3',
    'renpy.gl2.gl2model',
    'renpy.gl2.gl2polygon',
    'renpy.gl2.gl2shader',
    'renpy.gl2.gl2texture',
    'renpy.gl2.gl2uniform',
    'renpy.gl2.gl2draw',
]
for mod in gl2_modules:
    test(f"import {mod}", lambda m=mod: __import__(m, fromlist=['']))

# Text rendering modules
text_modules = [
    'renpy.text.textsupport',
    'renpy.text.texwrap',
    'renpy.text.bidi',
    'renpy.text.ftfont',
    'renpy.text.hbfont',
]
for mod in text_modules:
    test(f"import {mod}", lambda m=mod: __import__(m, fromlist=['']))

# Audio module
test("import renpy.audio.renpysound", lambda: __import__('renpy.audio.renpysound', fromlist=['']))
test("import renpy.audio.filter", lambda: __import__('renpy.audio.filter', fromlist=['']))

# Other modules
other_modules = [
    'renpy.style',
    'renpy.cslots',
    'renpy.pydict',
    'renpy.astsupport',
    'renpy.lexersupport',
    'renpy.encryption',
    'renpy.tfd',
    'renpy.uguu.gl',
    'renpy.uguu.uguu',
]
for mod in other_modules:
    test(f"import {mod}", lambda m=mod: __import__(m, fromlist=['']))

# Style data modules
styledata_modules = [
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
]
for mod in styledata_modules:
    test(f"import {mod}", lambda m=mod: __import__(m, fromlist=['']))

print()

# ============================================================================
# Layer 2: Core Functional Tests
# ============================================================================
print("-" * 60)
print("  Layer 2: Core Functional Tests")
print("-" * 60)

def test_renpy_version():
    """Test _renpy module has version info."""
    import _renpy
    # Check the module loaded successfully
    assert hasattr(_renpy, '__file__'), "_renpy missing __file__"
    return True

def test_pygame_rect():
    """Test Rect creation and operations."""
    from renpy.pygame.rect import Rect
    r = Rect(10, 20, 100, 200)
    assert r.x == 10
    assert r.y == 20
    assert r.width == 100
    assert r.height == 200
    assert r.right == 110
    assert r.bottom == 220
    assert r.center == (60, 120)
    # Test contains
    assert r.collidepoint(50, 50)
    assert not r.collidepoint(0, 0)
    return True

def test_pygame_color():
    """Test Color creation."""
    from renpy.pygame.color import Color
    c = Color(255, 128, 64, 255)
    assert c.r == 255
    assert c.g == 128
    assert c.b == 64
    assert c.a == 255
    return True

def test_display_matrix():
    """Test Matrix creation."""
    from renpy.display.matrix import Matrix
    m = Matrix([1, 0, 0, 0,
                0, 1, 0, 0,
                0, 0, 1, 0,
                0, 0, 0, 1])
    return True

def test_text_support():
    """Test text support structures."""
    from renpy.text import textsupport
    return True

def test_style_system():
    """Test style system initialization."""
    from renpy.styledata import styleclass
    return True

def test_encryption():
    """Test encryption module."""
    from renpy import encryption
    return True

def test_cslots():
    """Test cslots module."""
    from renpy import cslots
    return True

def test_audio_filter():
    """Test audio filter module."""
    from renpy.audio import filter as audio_filter
    return True

test("_renpy module attributes", test_renpy_version)
test("Rect creation & operations", test_pygame_rect)
test("Color creation", test_pygame_color)
test("Matrix creation", test_display_matrix)
test("Text support structures", test_text_support)
test("Style system", test_style_system)
test("Encryption module", test_encryption)
test("CSlots module", test_cslots)
test("Audio filter module", test_audio_filter)

print()

# ============================================================================
# Layer 3: Library Dependency Check
# ============================================================================
print("-" * 60)
print("  Layer 3: Shared Library Dependencies")
print("-" * 60)

import ctypes

def check_lib(name, path=None):
    """Check if a shared library can be loaded."""
    try:
        if path:
            lib = ctypes.CDLL(path)
        else:
            lib = ctypes.CDLL(name)
        return True
    except OSError as e:
        return False

lib_dir = os.path.join(BASE_DIR, "lib")
libs_to_check = [
    ("libSDL2.so", "SDL2"),
    ("libSDL2_image-2.0.so", "SDL2_image"),
    ("libSDL2_mixer-2.0.so", "SDL2_mixer"),
    ("libSDL2_ttf-2.0.so", "SDL2_ttf"),
    ("libpython3.12.so", "Python 3.12"),
    ("libz.so", "zlib"),
    ("libpng16.so", "libpng"),
    ("libfreetype.so", "FreeType"),
    ("libharfbuzz.so", "HarfBuzz"),
    ("libfribidi.so", "FriBidi"),
    ("libjpeg.so", "libjpeg"),
    ("libavcodec.so", "FFmpeg avcodec"),
    ("libavformat.so", "FFmpeg avformat"),
    ("libavutil.so", "FFmpeg avutil"),
    ("libswresample.so", "FFmpeg swresample"),
    ("libswscale.so", "FFmpeg swscale"),
]

for libfile, libname in libs_to_check:
    full_path = os.path.join(lib_dir, libfile)
    test(f"Load {libname} ({libfile})", lambda p=full_path, n=libfile: check_lib(n) or check_lib(p))

print()

# ============================================================================
# Summary
# ============================================================================
print("=" * 60)
total = passed + failed
print(f"  Results: {passed}/{total} passed, {failed} failed")
print("=" * 60)

if errors:
    print()
    print("  Failed tests:")
    for e in errors:
        print(f"    - {e}")

print()
if failed == 0:
    print("  *** ALL TESTS PASSED - Ren'Py engine is ready! ***")
else:
    print(f"  *** {failed} tests failed - check errors above ***")

sys.exit(0 if failed == 0 else 1)
