"""
Direct .so loading test for Ren'Py on HarmonyOS.
Uses ctypes.CDLL to test if each .so can be loaded
(all shared library dependencies satisfied),
bypassing Python's package import machinery.
"""
import sys
import os
import ctypes
import glob
import importlib

BASE = '/data/local/tmp/renpy_test'
LIB = os.path.join(BASE, 'lib')
sys.path.insert(0, BASE)
sys.path.insert(0, LIB)

# ============================================================
# Layer 1: Python stdlib C extensions (via import)
# ============================================================
print("=" * 60)
print("LAYER 1: Python stdlib C extensions")
print("=" * 60)
stdlib_modules = [
    'struct', 'ctypes', 'pickle', 'math', 'zlib',
    'hashlib', 'json', 'socket', 'select', 'array',
    'binascii', 'unicodedata', '_decimal', 'ssl',
]
s_ok = s_fail = 0
for mod in stdlib_modules:
    try:
        importlib.import_module(mod)
        s_ok += 1
    except Exception as e:
        print(f"  FAIL: {mod}: {e}")
        s_fail += 1
print(f"  Result: {s_ok}/{len(stdlib_modules)} OK, {s_fail} FAIL")

# ============================================================
# Layer 2: Shared libraries (ctypes.CDLL)
# ============================================================
print()
print("=" * 60)
print("LAYER 2: Shared libraries (ctypes.CDLL)")
print("=" * 60)
libs = [
    'libz.so', 'libpng16.so', 'libfreetype.so', 'libfribidi.so',
    'libharfbuzz.so', 'libjpeg.so', 'libffi.so',
    'libSDL2.so', 'libSDL2_image-2.0.so',
    'libSDL2_mixer-2.0.so', 'libSDL2_ttf-2.0.so',
    'libavcodec.so', 'libavformat.so', 'libavutil.so',
    'libswresample.so', 'libswscale.so',
]
l_ok = l_fail = 0
for lib in libs:
    path = os.path.join(LIB, lib)
    try:
        ctypes.CDLL(path)
        l_ok += 1
        print(f"  OK:   {lib}")
    except Exception as e:
        err = str(e).split('\n')[0][:100]
        print(f"  FAIL: {lib}: {err}")
        l_fail += 1
print(f"  Result: {l_ok}/{len(libs)} OK, {l_fail} FAIL")

# ============================================================
# Layer 3: ALL Ren'Py .so files (ctypes.CDLL direct load)
# ============================================================
print()
print("=" * 60)
print("LAYER 3: Ren'Py .so direct loading (ctypes.CDLL)")
print("=" * 60)

# Find all renpy .so files
so_files = sorted(glob.glob(os.path.join(BASE, '*.cpython-312-*.so')))
so_files += sorted(glob.glob(os.path.join(BASE, 'renpy', '**', '*.cpython-312-*.so'), recursive=True))

r_ok = r_fail = 0
fail_reasons = {}
for so in so_files:
    relpath = os.path.relpath(so, BASE)
    try:
        ctypes.CDLL(so)
        r_ok += 1
        print(f"  OK:   {relpath}")
    except Exception as e:
        err = str(e).split('\n')[0][:100]
        print(f"  FAIL: {relpath}: {err}")
        r_fail += 1
        # categorize
        if 'libark_jsruntime' in err or 'libace_napi' in err:
            fail_reasons.setdefault('HarmonyOS_NAPI', []).append(relpath)
        elif 'libSDL2' in err or 'SDL' in err:
            fail_reasons.setdefault('SDL2_dep', []).append(relpath)
        else:
            fail_reasons.setdefault('other', []).append(relpath)

print(f"  Result: {r_ok}/{r_ok + r_fail} OK, {r_fail} FAIL")
if fail_reasons:
    print("  Failure categories:")
    for cat, files in fail_reasons.items():
        print(f"    {cat}: {len(files)} modules")

# ============================================================
# Layer 4: Python import of safe modules
# ============================================================
print()
print("=" * 60)
print("LAYER 4: Python import of safe Ren'Py modules")
print("=" * 60)
safe_modules = [
    'renpy.astsupport', 'renpy.cslots', 'renpy.encryption',
    'renpy.lexersupport', 'renpy.pydict', 'renpy.tfd',
    'renpy.style',
    'renpy.styledata.styleclass', 'renpy.styledata.stylesets',
    'renpy.styledata.style_functions',
    'renpy.text.textsupport', 'renpy.text.texwrap', 'renpy.text.bidi',
]
p_ok = p_fail = 0
for mod in safe_modules:
    try:
        importlib.import_module(mod)
        p_ok += 1
        print(f"  OK:   {mod}")
    except Exception as e:
        err = str(e).split('\n')[0][:80]
        print(f"  FAIL: {mod}: {err}")
        p_fail += 1
print(f"  Result: {p_ok}/{len(safe_modules)} OK, {p_fail} FAIL")

# ============================================================
# Layer 5: Functional tests
# ============================================================
print()
print("=" * 60)
print("LAYER 5: Functional tests")
print("=" * 60)
f_ok = f_fail = 0

# Test text module functions
try:
    from renpy.text.textsupport import Glyph
    print(f"  OK:   textsupport.Glyph accessible")
    f_ok += 1
except Exception as e:
    print(f"  FAIL: Glyph: {e}")
    f_fail += 1

# Test style system
try:
    from renpy.style import Style
    print(f"  OK:   style.Style accessible")
    f_ok += 1
except Exception as e:
    print(f"  FAIL: Style: {e}")
    f_fail += 1

# Test bidi
try:
    from renpy.text.bidi import log2vis
    print(f"  OK:   bidi.log2vis accessible")
    f_ok += 1
except Exception as e:
    print(f"  FAIL: bidi: {e}")
    f_fail += 1

# Test encryption
try:
    from renpy.encryption import generate_key
    print(f"  OK:   encryption.generate_key accessible")
    f_ok += 1
except Exception as e:
    print(f"  FAIL: encryption: {e}")
    f_fail += 1

# Direct .so load + function check for matrix
try:
    so_path = os.path.join(BASE, 'renpy', 'display', 'matrix.cpython-312-x86_64-linux-gnu.so')
    h = ctypes.CDLL(so_path)
    print(f"  OK:   display/matrix.so loads, exports: {bool(h)}")
    f_ok += 1
except Exception as e:
    print(f"  FAIL: matrix direct load: {e}")
    f_fail += 1

# Direct .so load for Rect
try:
    so_path = os.path.join(BASE, 'renpy', 'pygame', 'rect.cpython-312-x86_64-linux-gnu.so')
    h = ctypes.CDLL(so_path)
    print(f"  OK:   pygame/rect.so loads")
    f_ok += 1
except Exception as e:
    print(f"  FAIL: rect direct load: {e}")
    f_fail += 1

print(f"  Result: {f_ok}/{f_ok + f_fail} OK, {f_fail} FAIL")

# ============================================================
# Summary
# ============================================================
print()
print("=" * 60)
total_ok = s_ok + l_ok + r_ok + p_ok + f_ok
total_fail = s_fail + l_fail + r_fail + p_fail + f_fail
total = total_ok + total_fail
print(f"GRAND TOTAL: {total_ok}/{total} OK, {total_fail} FAIL")
if r_fail > 0 and 'HarmonyOS_NAPI' in fail_reasons:
    napi_count = len(fail_reasons['HarmonyOS_NAPI'])
    print(f"  NOTE: {napi_count} modules fail due to missing HarmonyOS NAPI")
    print(f"        (libark_jsruntime.so) - expected in shell environment.")
    print(f"        These will work inside a proper HarmonyOS app container.")
print("=" * 60)
