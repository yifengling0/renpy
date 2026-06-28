#!/bin/bash
# Disable MSYS2 path conversion
export MSYS_NO_PATHCONV=1
# =============================================================================
# Ren'Py HarmonyOS Cross-Compilation Script (Python 3.9 target)
# Uses renpy83/ CLEAN source (Cython 0.29.x compatible)
# =============================================================================

set -e

ARCH="${1:-aarch64}"
echo "============================================================"
echo "  Ren'Py HarmonyOS Build (Python 3.9) - $ARCH [renpy83]"
echo "============================================================"

# Point to renpy83 clean source
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

ROOT="$(cd ../.. && pwd)"

PY39_SRC="$ROOT/Python-3.9.25"
if [ "$ARCH" = "aarch64" ]; then
    PY39_BUILD="$ROOT/workspace_temp/build_py39_aarch64"
else
    PY39_BUILD="$ROOT/workspace_temp/build_py39_x86_64"
fi

HARMONY_DEPS="$ROOT/Python-3.12.12/harmony_deps/$ARCH"
FFMPEG_ROOT="$ROOT/third_party_ffmpeg"
FFMPEG_INSTALL="$FFMPEG_ROOT/install-harmony-$ARCH"
SDL_SOURCE_INCLUDE="$ROOT/SDL2/SDL/include"

OHOS_SDK_ROOT="/cygdrive/c/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native"
OHOS_NDK="$OHOS_SDK_ROOT/llvm"
OHOS_SYSROOT="$OHOS_SDK_ROOT/sysroot"

# Validate
echo ""
echo "[1/6] Validating environment..."
errs=0
for d in "$PY39_SRC/Include" "$PY39_BUILD" "$HARMONY_DEPS/lib" "$HARMONY_DEPS/include" "$OHOS_NDK/bin"; do
    if [ ! -d "$d" ]; then echo "  ERROR: Missing: $d"; errs=$((errs+1)); fi
done
[ $errs -gt 0 ] && exit 1
echo "  OK"

# Architecture
if [ "$ARCH" = "aarch64" ]; then
    TARGET_TRIPLE="aarch64-unknown-linux-ohos"
    MARCH_FLAG="-march=armv8.2-a"
else
    TARGET_TRIPLE="x86_64-unknown-linux-ohos"
    MARCH_FLAG=""
fi

# Environment
echo "[2/6] Setting up environment..."
export PATH="/usr/bin:/bin:/mingw64/bin"

WIN_OHOS_NDK=$(cygpath -m "$OHOS_NDK")
WIN_OHOS_SYSROOT=$(cygpath -m "$OHOS_SYSROOT")
WIN_PY39_INCLUDE=$(cygpath -m "$PY39_SRC/Include")
WIN_PY39_BUILD=$(cygpath -m "$PY39_BUILD")
WIN_HARMONY_DEPS=$(cygpath -m "$HARMONY_DEPS")
WIN_FFMPEG_INSTALL=$(cygpath -m "$FFMPEG_INSTALL")
WIN_SCRIPT_DIR=$(cygpath -m "$SCRIPT_DIR")

export OHOS_CLANG="$WIN_OHOS_NDK/bin/clang.exe"
export OHOS_CLANGXX="$WIN_OHOS_NDK/bin/clang++.exe"
export OHOS_TARGET="$TARGET_TRIPLE"
export OHOS_SYSROOT="$WIN_OHOS_SYSROOT"

WRAPPER="$WIN_SCRIPT_DIR/../renpy/harmony_compiler_wrapper.py"
WIN_PYTHON=$(cygpath -m /cygdrive/f/MyProject/.venv/Scripts/python.exe)
WRAPPER_UNIX=$(cygpath -u "$WIN_SCRIPT_DIR/../renpy/harmony_compiler_wrapper.py")

echo "  Testing cross-compiler..."
echo 'int test_fn(void) { return 42; }' > /tmp/test_harmony.c
python "$WRAPPER_UNIX" cc -c "$(cygpath -m /tmp/test_harmony.c)" -o "$(cygpath -m /tmp/test_harmony.o)" 2>&1 || { echo "  ERROR: Cross-compiler test failed!"; exit 1; }
rm -f /tmp/test_harmony.c /tmp/test_harmony.o
echo "  OK"

# Compiler settings
echo "[3/6] Build environment..."

# Set up pkg-config for dependencies
PC_DIR="$HARMONY_DEPS/lib/pkgconfig"
mkdir -p "$PC_DIR"

cat > "$PC_DIR/sdl2.pc" << PCEOF
prefix=$HARMONY_DEPS
libdir=\${prefix}/lib
includedir=\${prefix}/include
Name: sdl2
Description: SDL2
Version: 2.32.10
Libs: -L\${libdir} -lSDL2
Cflags: -I\${includedir}/SDL2
PCEOF

cat > "$PC_DIR/SDL2_image.pc" << PCEOF
prefix=$HARMONY_DEPS
libdir=\${prefix}/lib
includedir=\${prefix}/include
Name: SDL2_image
Version: 2.0
Requires: sdl2
Libs: -L\${libdir} -lSDL2_image-2.0
Cflags: -I\${includedir}
PCEOF

cat > "$PC_DIR/SDL2_mixer.pc" << PCEOF
prefix=$HARMONY_DEPS
libdir=\${prefix}/lib
includedir=\${prefix}/include
Name: SDL2_mixer
Version: 2.0
Requires: sdl2
Libs: -L\${libdir} -lSDL2_mixer-2.0
Cflags: -I\${includedir}
PCEOF

cat > "$PC_DIR/SDL2_ttf.pc" << PCEOF
prefix=$HARMONY_DEPS
libdir=\${prefix}/lib
includedir=\${prefix}/include
Name: SDL2_ttf
Version: 2.0
Requires: sdl2 freetype2
Libs: -L\${libdir} -lSDL2_ttf-2.0
Cflags: -I\${includedir}
PCEOF

export PKG_CONFIG_LIBDIR="$PC_DIR:$FFMPEG_INSTALL/lib/pkgconfig"
unset PKG_CONFIG_PATH
unset PKG_CONFIG_SYSROOT_DIR
export RENPY_DEPS_INSTALL="$WIN_HARMONY_DEPS::$WIN_FFMPEG_INSTALL"

SDL_INCLUDE_FLAGS="-I$WIN_HARMONY_DEPS/include -I$WIN_HARMONY_DEPS/include/SDL2 -I$WIN_HARMONY_DEPS/include/freetype2 -I$WIN_HARMONY_DEPS/include/harfbuzz"
[ -d "$SDL_SOURCE_INCLUDE" ] && SDL_INCLUDE_FLAGS="-I$(cygpath -m "$SDL_SOURCE_INCLUDE") $SDL_INCLUDE_FLAGS"

export CFLAGS="-I$WIN_PY39_INCLUDE -I$WIN_PY39_BUILD $SDL_INCLUDE_FLAGS -I$WIN_FFMPEG_INSTALL/include -O2 $MARCH_FLAG"
export LDFLAGS="-L$WIN_PY39_BUILD -L$WIN_HARMONY_DEPS/lib -L$WIN_FFMPEG_INSTALL/lib -lpython3.9"
export CC="$WIN_PYTHON $WRAPPER cc"
export CXX="$WIN_PYTHON $WRAPPER cxx"
export LDSHARED="$WIN_PYTHON $WRAPPER ldcc"
export _PYTHON_HOST_PLATFORM="linux-aarch64"
export RENPY_CYTHON="$WIN_SCRIPT_DIR/../../.venv/Scripts/cython.exe"
export AR="$(cygpath -m "$OHOS_NDK/bin/llvm-ar.exe")"
export RANLIB="$(cygpath -m "$OHOS_NDK/bin/llvm-ranlib.exe")"
export STRIP="$(cygpath -m "$OHOS_NDK/bin/llvm-strip.exe")"

echo "  CC=$CC"
echo "  RENPY_CYTHON=$RENPY_CYTHON"
echo "  LDFLAGS=$LDFLAGS"

# Set target Python paths for harmony_setup_wrapper
export HARMONY_PYTHON_INCLUDE="$WIN_PY39_INCLUDE"
export HARMONY_PYTHON_LIBDIR="$WIN_PY39_BUILD"
export HARMONY_PYTHON_LDLIBRARY="libpython3.9.so"

# Build - use harmony_setup_wrapper to patch sysconfig once, then run setup.py
echo "[4/6] Building extensions..."
BUILD_DIR="build/harmony-py39-$ARCH"
rm -rf "$BUILD_DIR"

# harmony_setup_wrapper.py handles: sysconfig patching (AR/CC/LDSHARED/etc), 
# build_ext patching, and EXT_SUFFIX for correct .so naming.
# It reads HARMONY_PYTHON_INCLUDE/LIBDIR/LDLIBRARY env vars for target config.
/cygdrive/f/MyProject/.venv/Scripts/python.exe harmony_setup_wrapper.py build_ext \
    --build-lib="$BUILD_DIR/lib" \
    --build-temp="$BUILD_DIR/temp" \
    --compiler=unix \
    --force \
    2>&1 | tee "build_harmony_py39_${ARCH}.log"

# Results
echo ""
echo "============================================================"
echo "  Build Results"
echo "============================================================"
SO_COUNT=$(find "$BUILD_DIR/lib" -name "*.so" -type f 2>/dev/null | wc -l)
echo "  .so modules: $SO_COUNT"
find "$BUILD_DIR/lib" -name "*.so" -type f 2>/dev/null | sort | while read f; do
    size=$(stat -c%s "$f" 2>/dev/null || echo "?")
    name=$(echo "$f" | sed "s|$BUILD_DIR/lib/||")
    echo "    $name ($size bytes)"
done
echo "============================================================"
