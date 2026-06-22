#!/bin/bash
# =============================================================================
# Ren'Py 8.3 HarmonyOS Cross-Compilation Script (Python 3.9 target)
# Adapted from build_harmony.sh for Python 3.9.25
#
# Uses:
#   - MSYS2 Python (host) to run setup.py / cython
#   - HarmonyOS NDK clang for cross-compilation
#   - Pre-built SDL2/FFmpeg from Python-3.12.12/harmony_deps (platform-independent)
#   - Python 3.9 built libs from workspace_temp/build_py39_x86_64
# =============================================================================

set -e

ARCH="${1:-x86_64}"
echo "============================================================"
echo "  Ren'Py 8.3 HarmonyOS Build (Python 3.9) - $ARCH"
echo "============================================================"

# =============================================================================
# Paths
# =============================================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Project root
ROOT="$(cd ../.. && pwd)"

# Python 3.9 source + build output (arch-specific)
PY39_SRC="$ROOT/Python-3.9.25"
if [ "$ARCH" = "aarch64" ]; then
    PY39_BUILD="$ROOT/workspace_temp/build_py39_aarch64"
else
    PY39_BUILD="$ROOT/workspace_temp/build_py39_x86_64"
fi

# Prebuilt deps (SDL2, FFmpeg, OpenSSL, etc.) - same as Python 3.12
HARMONY_DEPS="$ROOT/Python-3.12.12/harmony_deps/$ARCH"
FFMPEG_ROOT="$ROOT/third_party_ffmpeg"
FFMPEG_INSTALL="$FFMPEG_ROOT/install-harmony-$ARCH"

OHOS_SDK_ROOT="/ohos-sdk"
OHOS_NDK="$OHOS_SDK_ROOT/llvm"
OHOS_SYSROOT="$OHOS_SDK_ROOT/sysroot"

# =============================================================================
# Validate
# =============================================================================
echo ""
echo "[1/5] Validating environment..."

errs=0
for d in "$PY39_SRC/Include" "$PY39_BUILD" \
         "$HARMONY_DEPS/lib" "$HARMONY_DEPS/include" \
         "$FFMPEG_INSTALL/lib" "$FFMPEG_INSTALL/include" \
         "$OHOS_NDK/bin"; do
    if [ ! -d "$d" ]; then
        echo "  ERROR: Missing directory: $d"
        errs=$((errs+1))
    fi
done
[ $errs -gt 0 ] && exit 1

echo "  OK  Python 3.9 source:  $PY39_SRC"
echo "  OK  Python 3.9 build:   $PY39_BUILD"
echo "  OK  harmony_deps:       $HARMONY_DEPS"
echo "  OK  FFmpeg:             $FFMPEG_INSTALL"
echo "  OK  NDK:                $OHOS_NDK"

# =============================================================================
# Architecture settings
# =============================================================================
if [ "$ARCH" = "aarch64" ]; then
    TARGET_TRIPLE="aarch64-unknown-linux-ohos"
    HOST_PLATFORM="linux-aarch64"
    MARCH_FLAG="-march=armv8.2-a"
elif [ "$ARCH" = "x86_64" ]; then
    TARGET_TRIPLE="x86_64-unknown-linux-ohos"
    HOST_PLATFORM="linux-x86_64"
    MARCH_FLAG=""
else
    echo "ERROR: Unsupported arch: $ARCH"
    exit 1
fi

# =============================================================================
# Environment Sanitization
# =============================================================================
echo ""
echo "[2/5] Sanitizing environment..."

unset C_INCLUDE_PATH CPLUS_INCLUDE_PATH CPATH LIBRARY_PATH
unset MINGW_PREFIX MINGW_CHOST MINGW_PACKAGE_PREFIX
CLEAN_PATH="/mingw64/bin:/usr/bin:/bin"
export PATH="$CLEAN_PATH"

# =============================================================================
# Build Environment
# =============================================================================
echo ""
echo "[3/5] Setting up pkg-config (prevents MinGW path leakage)..."

# Create .pc files pointing to OHOS harmony_deps (NOT MinGW)
PC_DIR="$HARMONY_DEPS/lib/pkgconfig"
mkdir -p "$PC_DIR"

cat > "$PC_DIR/sdl2.pc" << PCEOF
prefix=$HARMONY_DEPS
libdir=\${prefix}/lib
includedir=\${prefix}/include
Name: sdl2
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

# Point pkg-config ONLY to our custom .pc files (no system fallback)
export PKG_CONFIG_LIBDIR="$PC_DIR:$FFMPEG_INSTALL/lib/pkgconfig"
unset PKG_CONFIG_PATH

echo "  PKG_CONFIG_LIBDIR=$PKG_CONFIG_LIBDIR"
for pkg in sdl2 SDL2_image libpng freetype2 harfbuzz fribidi libavcodec libavformat; do
    if pkg-config --exists "$pkg" 2>/dev/null; then
        echo "    OK  $pkg"
    else
        echo "    WARN  $pkg not found (may be optional)"
    fi
done

# =============================================================================
# Build Environment
# =============================================================================
echo ""
echo "[4/5] Setting build environment..."

# Windows-format paths
WIN_OHOS_NDK=$(cygpath -m "$OHOS_NDK")
WIN_OHOS_SYSROOT=$(cygpath -m "$OHOS_SYSROOT")
WIN_PY39_INCLUDE=$(cygpath -m "$PY39_SRC/Include")
WIN_PY39_BUILD=$(cygpath -m "$PY39_BUILD")
WIN_HARMONY_DEPS=$(cygpath -m "$HARMONY_DEPS")
WIN_FFMPEG_INSTALL=$(cygpath -m "$FFMPEG_INSTALL")
WIN_SCRIPT_DIR=$(cygpath -m "$SCRIPT_DIR")

# CC/CXX: use clang.exe directly with explicit --sysroot
# Use Windows paths (cygpath -m) because distutils subprocess runs on Windows
SYSROOT="$OHOS_SDK_ROOT/sysroot"
WIN_CLANG=$(cygpath -m "$OHOS_NDK/bin/clang.exe")
WIN_CLANGXX=$(cygpath -m "$OHOS_NDK/bin/clang++.exe")
WIN_SYSROOT=$(cygpath -m "$SYSROOT")

echo "  Testing cross-compiler..."
echo 'int test_fn(void) { return 42; }' > /tmp/test_harmony.c
"$WIN_CLANG" --target=$TARGET_TRIPLE --sysroot="$WIN_SYSROOT" -D__MUSL__ -c /tmp/test_harmony.c -o /tmp/test_harmony.o 2>&1 || {
    echo "  ERROR: Cross-compiler test failed!"
    exit 1
}
echo "  OK  Cross-compiler works"

# NOTE: CC value is split by spaces when distutils calls subprocess
export CC="$WIN_CLANG --target=$TARGET_TRIPLE --sysroot=$WIN_SYSROOT -D__MUSL__"
export CXX="$WIN_CLANGXX --target=$TARGET_TRIPLE --sysroot=$WIN_SYSROOT -D__MUSL__"
export LDSHARED="$WIN_CLANG --target=$TARGET_TRIPLE --sysroot=$WIN_SYSROOT -D__MUSL__ -shared"
export LDCXXSHARED="$WIN_CLANGXX --target=$TARGET_TRIPLE --sysroot=$WIN_SYSROOT -D__MUSL__ -shared"

export AR="$OHOS_NDK/bin/llvm-ar"
export RANLIB="$OHOS_NDK/bin/llvm-ranlib"
export STRIP="$OHOS_NDK/bin/llvm-strip"

# Include + lib paths for Python 3.9
export CFLAGS="-I$WIN_PY39_INCLUDE -I$WIN_PY39_BUILD -I$WIN_HARMONY_DEPS/include -I$WIN_HARMONY_DEPS/include/SDL2 -I$WIN_FFMPEG_INSTALL/include -O2 $MARCH_FLAG"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-L$WIN_PY39_BUILD -L$WIN_HARMONY_DEPS/lib -L$WIN_FFMPEG_INSTALL/lib -lpython3.9"

# Cross-compilation target
export _PYTHON_HOST_PLATFORM="$HOST_PLATFORM"

# Tell harmony_setup_wrapper.py about Python 3.9 paths
export HARMONY_PYTHON_INCLUDE="$WIN_PY39_INCLUDE"
export HARMONY_PYTHON_BUILD="$WIN_PY39_BUILD"
export HARMONY_PYTHON_LIBDIR="$WIN_PY39_BUILD"
export HARMONY_PYTHON_LDLIBRARY="libpython3.9.so.1.0"

# Skip modules without HarmonyOS libs
export RENPY_SKIP_PACKAGES="assimp"
export RENPY_SKIP_MODULES="renpy.gl2.assimp renpy.tfd"

echo "  CC=$CC"
echo "  _PYTHON_HOST_PLATFORM=$HOST_PLATFORM"
echo "  CFLAGS=$CFLAGS"

# =============================================================================
# Generate Cython C files
# =============================================================================
echo ""
echo "[5/5] Generating Cython C files (Python 3.9 compatible)..."

# Use venv's cython.exe (Cython 3.2.5)
export RENPY_CYTHON="$(cygpath -m /f/MyProject/.venv/Scripts/cython.exe)"
echo "  Cython: $RENPY_CYTHON"

python setup.py generate 2>&1 | tail -5

GEN_COUNT=$(ls tmp/gen3/*.c 2>/dev/null | wc -l)
echo "  Generated C files: $GEN_COUNT"
[ "$GEN_COUNT" -lt 10 ] && { echo "  ERROR: Too few C files"; exit 1; }

GEN_COUNT=$(ls tmp/gen3/*.c 2>/dev/null | wc -l)
echo "  Generated C files: $GEN_COUNT"
[ "$GEN_COUNT" -lt 10 ] && { echo "  ERROR: Too few C files"; exit 1; }

# =============================================================================
# Build Extensions
# =============================================================================
echo ""
echo "[6/6] Building Ren'Py 8.3 extensions for HarmonyOS $ARCH (Python 3.9)..."
echo ""

BUILD_DIR="build/harmony39-$ARCH"
# NOTE: no rm -rf for safety. Clean manually if needed via 'make clean'.
mkdir -p "$BUILD_DIR"

python harmony_setup_wrapper.py build_ext \
    --build-lib="$BUILD_DIR/lib" \
    --build-temp="$BUILD_DIR/temp" \
    --compiler=unix \
    --force \
    2>&1 | tee "build_harmony39_${ARCH}.log"

# =============================================================================
# Results
# =============================================================================
echo ""
echo "============================================================"
echo "  Build Results - $ARCH (Python 3.9)"
echo "============================================================"

SO_COUNT=$(find "$BUILD_DIR/lib" -name "*.so" -type f 2>/dev/null | wc -l)
echo "  .so modules found: $SO_COUNT"

if [ "$SO_COUNT" -gt 0 ]; then
    find "$BUILD_DIR/lib" -name "*.so" -type f 2>/dev/null | sort | while read f; do
        size=$(stat -c%s "$f" 2>/dev/null || echo "?")
        name=$(echo "$f" | sed "s|$BUILD_DIR/lib/||")
        echo "    $name ($size bytes)"
    done
    echo ""
    echo "  SUCCESS: $SO_COUNT Ren'Py 8.3 modules built!"
    echo "  Output: $SCRIPT_DIR/$BUILD_DIR/lib/"
else
    echo "  FAIL: No .so files produced!"
    grep -i "error:" "build_harmony39_${ARCH}.log" 2>/dev/null | tail -10
    exit 1
fi

echo "  Build log: build_harmony39_${ARCH}.log"
echo "============================================================"
