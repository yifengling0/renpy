#!/bin/bash
# =============================================================================
# Ren'Py 7.4 HarmonyOS Cross-Compilation Script (Python 2.7)
# Builds Ren'Py C extension modules (.so) for HarmonyOS aarch64
#
# Uses:
#   - MSYS2 MINGW64 bash
#   - HarmonyOS NDK clang for cross-compilation
#   - Python 2.7.18 headers and libpython2.7.so
# =============================================================================

set -e

if ! command -v cygpath >/dev/null 2>&1; then
    echo "ERROR: build_harmony_27.sh must run under MSYS2 bash, not WSL/system bash."
    echo "Use: C:\\msys64\\usr\\bin\\bash.exe -lc 'cd /cygdrive/f/MyProject/vintage-pomelo/renpy74 && ./build_harmony_27.sh ${1:-aarch64}'"
    exit 1
fi

ARCH="${1:-aarch64}"
echo "============================================================"
echo "  Ren'Py 7.4 HarmonyOS Build - $ARCH (Python 2.7)"
echo "============================================================"

# =============================================================================
# Paths
# =============================================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Python 2.7 source and build
PY27_SRC="$ROOT/Python-2.7.18"
PY27_BUILD="$PY27_SRC/build-harmony-$ARCH"
PY27_INSTALL="$PY27_SRC/install-harmony-$ARCH"

# Platform deps - all .so files are in HAP libs directory
SDL_SOURCE_INCLUDE="$ROOT/SDL2/SDL/include"
HAP_LIBS="$ROOT/vintage-pomelo/VintagePomelo/entry/libs/arm64-v8a"
# Headers only (for compilation, not linking)
DEPS_INCLUDE="$ROOT/Python-3.12.12/harmony_deps/$ARCH/include"

# FFmpeg
FFMPEG_INSTALL="$ROOT/third_party_ffmpeg/install-harmony-$ARCH"

# Use wrapper approach like Python 3.12 build - avoids MSYS2 path issues
SDK_ROOT="C:/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native"
OHOS_SDK_ROOT="$SDK_ROOT"
HOST_PYTHON="/cygdrive/f/MyProject/workspace_temp/build_cache/python27_extracted/python.exe"
HOST_PY_ROOT="/cygdrive/f/MyProject/workspace_temp/build_cache/python27_extracted"
HOST_DEPS_ROOT="$ROOT/workspace_temp/build_cache/renpy27_host_deps"
HOST_DEPS_INCLUDE_ROOT="$HOST_DEPS_ROOT/include/python2.7"
PYGAME_SDL2_ROOT="$ROOT/workspace_temp/pygame_sdl2"

TARGET_TRIPLE="aarch64-linux-ohos"

# =============================================================================
# Validate
# =============================================================================
echo ""
echo "[1/6] Validating environment..."

if [ ! -f "$PY27_BUILD/libpython2.7.so.1.0" ]; then
    echo "ERROR: libpython2.7.so.1.0 not found at $PY27_BUILD"
    echo "Run Python-2.7.18/build_harmony_aarch64_msys2.sh first"
    exit 1
fi

# Validate SDK
CLANG1="/cygdrive/c/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native/llvm/bin/clang"
CLANG2="/mnt/c/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native/llvm/bin/clang"
CLANG3="/c/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native/llvm/bin/clang"
CLANG4="C:/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native/llvm/bin/clang.exe"
SDK_CLANG=""
if [ -f "$CLANG1" ]; then
    SDK_CLANG="$CLANG1"
elif [ -f "$CLANG2" ]; then
    SDK_CLANG="$CLANG2"
elif [ -f "$CLANG3" ]; then
    SDK_CLANG="$CLANG3"
elif [ -f "$CLANG4" ]; then
    SDK_CLANG="$CLANG4"
else
    echo "ERROR: OHOS clang not found."
    echo "  Tried: $CLANG1"
    echo "  Tried: $CLANG2"
    echo "  Tried: $CLANG3"
    echo "  Tried: $CLANG4"
    exit 1
fi
echo "  SDK clang: $SDK_CLANG"

HOST_PYTHON="/cygdrive/f/MyProject/workspace_temp/build_cache/python27_extracted/python.exe"
if [ ! -f "$HOST_PYTHON" ]; then
    echo "ERROR: Host Python 2.7 not found at $HOST_PYTHON"
    exit 1
fi

echo "  Python 2.7 build: $PY27_BUILD"
echo "  Host Python:      $HOST_PYTHON"
echo "  OHOS SDK:         $OHOS_SDK_ROOT"

PYGAME_SDL2_BUILD_SCRIPT="$PYGAME_SDL2_ROOT/build_harmony_27.sh"
PYGAME_SDL2_BUILD_OUT="$PYGAME_SDL2_ROOT/build-harmony-$ARCH"
if [ ! -f "$PYGAME_SDL2_BUILD_SCRIPT" ]; then
    echo "ERROR: pygame_sdl2 build script not found at $PYGAME_SDL2_BUILD_SCRIPT"
    exit 1
fi

if [ "${FORCE_PYGAME_SDL2_REBUILD:-0}" = "1" ] || \
   [ ! -f "$PYGAME_SDL2_ROOT/gen/pygame_sdl2.display_api.h" ] || \
   [ ! -f "$PYGAME_SDL2_BUILD_OUT/lib.pygame_sdl2.error.cpython-27-aarch64-linux-ohos.so" ]; then
    echo "  Building pygame_sdl2 py27/OHOS runtime modules..."
    bash "$PYGAME_SDL2_BUILD_SCRIPT" "$ARCH"
else
    echo "  Reusing pygame_sdl2 build: $PYGAME_SDL2_BUILD_OUT"
fi

if [ ! -f "$PYGAME_SDL2_ROOT/src/pygame_sdl2/pygame_sdl2.h" ]; then
    echo "ERROR: pygame_sdl2.h not found at $PYGAME_SDL2_ROOT/src/pygame_sdl2"
    exit 1
fi

PYGAME_SDL2_GEN_DIR="$PYGAME_SDL2_ROOT/gen"
if [ ! -f "$PYGAME_SDL2_GEN_DIR/pygame_sdl2.display_api.h" ]; then
    PYGAME_SDL2_GEN_DIR="$PYGAME_SDL2_ROOT/gen3"
fi

mkdir -p "$HOST_DEPS_INCLUDE_ROOT/pygame_sdl2"
cp -f "$PYGAME_SDL2_ROOT/src/pygame_sdl2/pygame_sdl2.h" "$HOST_DEPS_INCLUDE_ROOT/pygame_sdl2/"
for api_header in "$PYGAME_SDL2_GEN_DIR"/pygame_sdl2.*_api.h; do
    if [ -f "$api_header" ]; then
        cp -f "$api_header" "$HOST_DEPS_INCLUDE_ROOT/pygame_sdl2/"
    fi
done

if [ ! -f "$HOST_DEPS_INCLUDE_ROOT/pygame_sdl2/pygame_sdl2.display_api.h" ]; then
    echo "ERROR: pygame_sdl2 API headers not staged under $HOST_DEPS_INCLUDE_ROOT/pygame_sdl2"
    exit 1
fi

echo "  pygame_sdl2 API source: $PYGAME_SDL2_GEN_DIR"
echo "  Host include shim: $HOST_DEPS_INCLUDE_ROOT"

# =============================================================================
# Path conversion helpers (MINGW64 → Windows paths)
# =============================================================================
_cygpath_win() {
    if command -v cygpath >/dev/null 2>&1; then
        cygpath -m "$1"
    else
        echo "$1"
    fi
}

# =============================================================================
# Toolchain (wrapper approach - handles Windows paths with spaces)
# =============================================================================
echo ""
echo "[2/6] Setting up cross-compilation toolchain..."

# Create wrapper scripts for MSYS2 paths with spaces
WRAP_DIR="$SCRIPT_DIR/build_wrappers"
rm -rf "$WRAP_DIR"
mkdir -p "$WRAP_DIR"

cat > "$WRAP_DIR/ohos-cc.bat" << 'EOF'
@echo off
"C:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\native\llvm\bin\clang.exe" --target=aarch64-linux-ohos --sysroot="C:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\native\sysroot" %*
EOF

cat > "$WRAP_DIR/ohos-cxx.bat" << 'EOF'
@echo off
"C:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\native\llvm\bin\clang++.exe" --target=aarch64-linux-ohos --sysroot="C:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\native\sysroot" %*
EOF

cat > "$WRAP_DIR/ohos-ar.bat" << 'EOF'
@echo off
"C:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\native\llvm\bin\llvm-ar.exe" %*
EOF

# Use .bat wrappers (distutils on Windows uses batch)
CC="$WRAP_DIR/ohos-cc.bat"
CXX="$WRAP_DIR/ohos-cxx.bat"
AR="$WRAP_DIR/ohos-ar.bat"
LDSHARED="$CC -shared"

CFLAGS_BASE="-D__OHOS__=1 -fPIC -O2 -march=armv8.2-a"
CFLAGS_BASE="$CFLAGS_BASE -I$PY27_SRC/Include -I$PY27_BUILD"
CFLAGS_BASE="$CFLAGS_BASE -I$SDL_SOURCE_INCLUDE"
CFLAGS_BASE="$CFLAGS_BASE -I$DEPS_INCLUDE -I$DEPS_INCLUDE/SDL2 -I$DEPS_INCLUDE/freetype2"
LDFLAGS_BASE="-L$PY27_BUILD -lpython2.7 -L$HAP_LIBS"
if [ -d "$FFMPEG_INSTALL" ]; then
    CFLAGS_BASE="$CFLAGS_BASE -I$FFMPEG_INSTALL/include"
    LDFLAGS_BASE="$LDFLAGS_BASE -L$FFMPEG_INSTALL/lib"
fi

# Windows paths for setuplib (Python 2.7 on Windows can't understand MSYS2 /cygdrive paths)
HAP_LIBS_WIN=$(cygpath -w "$HAP_LIBS" 2>/dev/null || echo "$HAP_LIBS")
FFMPEG_WIN=$(cygpath -w "$FFMPEG_INSTALL" 2>/dev/null || echo "$FFMPEG_INSTALL")
DEPS_INC_WIN=$(cygpath -w "$DEPS_INCLUDE" 2>/dev/null || echo "$DEPS_INCLUDE")
SDL_INC_WIN=$(cygpath -w "$SDL_SOURCE_INCLUDE" 2>/dev/null || echo "$SDL_SOURCE_INCLUDE")
PY27_BUILD_WIN=$(cygpath -w "$PY27_BUILD" 2>/dev/null || echo "$PY27_BUILD")
PY27_SRC_WIN=$(cygpath -w "$PY27_SRC" 2>/dev/null || echo "$PY27_SRC")

# =============================================================================
# Cython installation check
# =============================================================================
echo ""
echo "[3/6] Checking Cython..."

# Install Cython for host Python 2.7 if needed
CYTHON_OK=0
if "$HOST_PYTHON" -c "import Cython" 2>/dev/null; then
    CYTHON_VER=$("$HOST_PYTHON" -c "import Cython; print(Cython.__version__)")
    echo "  Cython $CYTHON_VER found"
    CYTHON_OK=1
fi

if [ "$CYTHON_OK" = "0" ]; then
    echo "  Installing Cython 0.29.37 for host Python 2.7..."
    "$HOST_PYTHON" -m pip install Cython==0.29.37 2>&1 | tail -3
fi

# =============================================================================
# Build Ren'Py modules
# =============================================================================
echo ""
echo "[4/6] Building Ren'Py 7.4 C extension modules..."

# Clean previous build output (but NOT gen/*.c - Cython needs PYTHONPATH for regeneration)
rm -rf "$SCRIPT_DIR/module/build"
cd "$SCRIPT_DIR/module"

# Convert paths to Windows format with FORWARD slashes (clang accepts both)
_winpath() { cygpath -w "$1" 2>/dev/null | sed 's/\\/\//g'; }

PY27_SRC_WIN=$(_winpath "$PY27_SRC")
PY27_BUILD_WIN=$(_winpath "$PY27_BUILD")
SDL_INC_WIN=$(_winpath "$SDL_SOURCE_INCLUDE")
DEPS_INC_WIN=$(_winpath "$DEPS_INCLUDE")
FFMPEG_INC_WIN=$(_winpath "$FFMPEG_INSTALL/include")
FFMPEG_LIB_WIN=$(_winpath "$FFMPEG_INSTALL/lib")
HAP_LIBS_WIN=$(_winpath "$HAP_LIBS")
HOST_DEPS_ROOT_WIN=$(_winpath "$HOST_DEPS_ROOT")

# Compiler flags
CFLAGS="-D__OHOS__=1 -fPIC -O2 -march=armv8.2-a"
# Suppress FFmpeg API deprecation warnings (Ren'Py 7.4 predates modern FFmpeg)
CFLAGS="$CFLAGS -Wno-deprecated-declarations -Wno-error"
# FFmpeg 5.1+ removed channel_layout; provide fallback
CFLAGS="$CFLAGS -Dchannel_layout=ch_layout.nb_channels"
CFLAGS="$CFLAGS -I$PY27_SRC_WIN/Include -I$PY27_BUILD_WIN"
CFLAGS="$CFLAGS -I$SDL_INC_WIN"
CFLAGS="$CFLAGS -I$DEPS_INC_WIN -I$DEPS_INC_WIN/SDL2 -I$DEPS_INC_WIN/freetype2"
CFLAGS="$CFLAGS -I$HAP_LIBS_WIN/python2.7"
MODULE_DIR_WIN=$(_winpath "$SCRIPT_DIR/module")
CFLAGS="$CFLAGS -I$MODULE_DIR_WIN"
CFLAGS="$CFLAGS -I$FFMPEG_INC_WIN"
LDFLAGS="-L$PY27_BUILD_WIN -lpython2.7 -L$HAP_LIBS_WIN -L$FFMPEG_LIB_WIN"

# setuplib (NO FFmpeg - API mismatch with Ren'Py 7.4)
export RENPY_DEPS_INSTALL="$HOST_DEPS_ROOT_WIN::$HAP_LIBS_WIN"

export CC="$CC"
export CXX="$CXX"
export LDSHARED="$CC -shared"
export LD="$CC"
export AR="$AR"
export COMSPEC="C:\\Windows\\System32\\cmd.exe"
export CFLAGS="$CFLAGS"
export LDFLAGS="$LDFLAGS"
export RENPY_CC="$CC"
export RENPY_LD="$LDSHARED"

export RENPY_CYTHON="/cygdrive/f/MyProject/workspace_temp/build_cache/python27_extracted/Scripts/cython.exe"
export PATH="/cygdrive/f/MyProject/workspace_temp/build_cache/python27_extracted/Scripts:$PATH"
# Add Ren'Py source to PYTHONPATH so Cython imports work
export PYTHONPATH="$SCRIPT_DIR:$PYTHONPATH"

# Force distutils to use our cross-compiler, not MSVC
export LDSHARED="$CC -shared"
# Fix: Python 2.7 distutils needs explicit OPT/BASECFLAGS to avoid None
export OPT=""
export BASECFLAGS=""

echo "  CFLAGS:  $CFLAGS"
echo "  LDFLAGS: $LDFLAGS"
echo "  DEPS:    $RENPY_DEPS_INSTALL"

# Run setup.py with host Python
MODULE_DIR_WIN=$(cygpath -w "$SCRIPT_DIR/module" 2>/dev/null)
SCRIPT_DIR_WIN=$(cygpath -w "$SCRIPT_DIR" 2>/dev/null)

"$HOST_PYTHON" -c "
import os, sys
os.chdir(r'$MODULE_DIR_WIN')
sys.path.insert(0, '.')
sys.path.insert(0, r'$SCRIPT_DIR_WIN')

# Fix 1: Force unix compiler (uses CC env var directly, no validation)
import distutils.ccompiler
_orig_new_compiler = distutils.ccompiler.new_compiler
def _force_unix(plat=None, compiler=None, verbose=0, dry_run=0, force=0):
    return _orig_new_compiler(plat=plat, compiler='unix', verbose=verbose, dry_run=dry_run, force=force)
distutils.ccompiler.new_compiler = _force_unix

# Fix 4: Override sysconfig to use TARGET Python includes, not host
import distutils.sysconfig
PY27_INCLUDE_WIN = r'$PY27_SRC_WIN\Include'
PY27_BUILD_WIN = r'$PY27_BUILD_WIN'
_orig_get_python_inc = distutils.sysconfig.get_python_inc
def _target_python_inc(plat_specific=0, prefix=None):
    return PY27_INCLUDE_WIN  # target OHOS Python, not host Windows Python
distutils.sysconfig.get_python_inc = _target_python_inc
# Also ensure get_config_var returns correct values
_orig_get_config_var = distutils.sysconfig.get_config_var
def _fixed_get_config_var(name):
    if name == 'INCLUDEPY':
        return PY27_INCLUDE_WIN
    if name == 'CONFINCLUDEPY':
        return PY27_BUILD_WIN
    if name == 'LIBPL':
        return r'$PY27_BUILD_WIN'  # for -L paths
    if name == 'LIBDIR':
        return r'$PY27_BUILD_WIN'
    if name == 'BINDIR':
        return r'$PY27_BUILD_WIN'
    return _orig_get_config_var(name)
distutils.sysconfig.get_config_var = _fixed_get_config_var

# Fix 3: Handle None CFLAGS
import distutils.sysconfig
_orig = distutils.sysconfig.customize_compiler
def _safe_customize(compiler):
    from distutils.sysconfig import _config_vars
    if _config_vars is not None:
        for k in ['CFLAGS', 'BASECFLAGS', 'OPT', 'AR', 'ARFLAGS', 'LDSHARED', 'CCSHARED']:
            if _config_vars.get(k) is None:
                _config_vars[k] = ''
    return _orig(compiler)
distutils.sysconfig.customize_compiler = _safe_customize

for k in ['LDFLAGS', 'CPPFLAGS']:
    os.environ.setdefault(k, '')

sys.argv = ['setup.py', 'build']
execfile('setup.py')
" 2>&1 | tail -50

# =============================================================================
# Collect and rename .so files
# =============================================================================
echo ""
echo "[5/6] Collecting .so files..."

FIND_BIN="/usr/bin/find"
if [ ! -x "$FIND_BIN" ]; then
    FIND_BIN="$(command -v find)"
fi

OUTPUT_DIR="$SCRIPT_DIR/build-harmony-$ARCH"
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Find .pyd files in the build directory (Windows Python produces .pyd)
# Try both MSYS2 mount points
for BASE in "$SCRIPT_DIR/module/build" "/cygdrive/f/MyProject/vintage-pomelo/renpy74/module/build"; do
    BUILD_LIB_DIR="$BASE/lib.win-amd64-2.7"
    if [ -d "$BUILD_LIB_DIR" ]; then break; fi
done

echo "  Build dir: $BUILD_LIB_DIR"

count=0
# Find built extension modules recursively (subdirs: renpy/, renpy/display/, etc.)
"$FIND_BIN" "$BUILD_LIB_DIR" -type f \( -name "*.pyd" -o -name "*.so" \) | while IFS= read -r f; do
    rel="${f#$BUILD_LIB_DIR/}"
    rel="${rel%.pyd}"
    rel="${rel%.so}"
    modname="${rel//\//.}"
    newname="lib.${modname}.cpython-27-aarch64-linux-ohos.so"
    cp "$f" "$OUTPUT_DIR/$newname"
    echo "  $modname -> $newname"
done
# Count actual .so files (while loop runs in subshell, counter doesn't propagate)
_final_count=$("$FIND_BIN" "$OUTPUT_DIR" -maxdepth 1 -type f -name "*.so" | wc -l)
echo "  Total: $_final_count .so files"

# =============================================================================
# Summary
# =============================================================================
echo ""
echo "[6/6] Done!"
echo "============================================================"
echo "Output: $OUTPUT_DIR"
echo ""
echo "Next steps:"
echo "  1. Copy *.so to VintagePomelo/entry/libs/arm64-v8a/"
echo "  2. Copy libpython2.7.so.1.0 from $PY27_BUILD"
echo "  3. Rebuild HAP"
echo "============================================================"
