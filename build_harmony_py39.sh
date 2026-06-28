#!/bin/bash
# =============================================================================
# Ren'Py HarmonyOS Cross-Compilation Script (Python 3.9 target)
# Derived from build_harmony.sh — uses renpy/ tree source (Cython 3.x compat)
# but links against Python 3.9.25 headers and libraries.
#
# Uses:
#   - .venv Cython 3.2.5 (host) for .pyx → .c generation
#   - HarmonyOS NDK clang for cross-compilation
#   - Pre-built deps from Python-3.12.12/harmony_deps (platform-independent)
#   - Python 3.9 built libs from workspace_temp/build_py39_$ARCH
# =============================================================================

set -e

ARCH="${1:-aarch64}"
echo "============================================================"
echo "  Ren'Py HarmonyOS Build (Python 3.9) - $ARCH"
echo "============================================================"

# =============================================================================
# Paths
# =============================================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

ROOT="$(cd ../.. && pwd)"

# Python 3.9 source and per-arch build output
PY39_SRC="$ROOT/Python-3.9.25"
if [ "$ARCH" = "aarch64" ]; then
    PY39_BUILD="$ROOT/workspace_temp/build_py39_aarch64"
else
    PY39_BUILD="$ROOT/workspace_temp/build_py39_x86_64"
fi

# Platform deps (SDL2, freetype, etc.) — Python-version-independent
HARMONY_DEPS="$ROOT/Python-3.12.12/harmony_deps/$ARCH"
FFMPEG_ROOT="$ROOT/third_party_ffmpeg"
FFMPEG_INSTALL="$FFMPEG_ROOT/install-harmony-$ARCH"
SDL_SOURCE_INCLUDE="$ROOT/SDL2/SDL/include"
DEFAULT_CUBISM="/e/Git/CubismSdkForNative-5-r.5"

OHOS_SDK_ROOT="/cygdrive/c/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native"
OHOS_NDK="$OHOS_SDK_ROOT/llvm"
OHOS_SYSROOT="$OHOS_SDK_ROOT/sysroot"

resolve_cubism_root() {
    local root="$1"
    if [ -z "$root" ]; then return 1; fi
    if [ -d "$root" ]; then printf '%s\n' "$root"; return 0; fi
    if command -v cygpath >/dev/null 2>&1; then
        local normalized
        normalized=$(cygpath -u "$root" 2>/dev/null || true)
        if [ -n "$normalized" ] && [ -d "$normalized" ]; then
            printf '%s\n' "$normalized"; return 0
        fi
    fi
    return 1
}

# =============================================================================
# Validate
# =============================================================================
echo ""
echo "[1/7] Validating environment (Python 3.9 target)..."

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
if [ -d "$SDL_SOURCE_INCLUDE" ]; then
    echo "  OK  SDL headers:        $SDL_SOURCE_INCLUDE"
else
    echo "  WARN SDL source headers not found: $SDL_SOURCE_INCLUDE"
fi

CUBISM_ROOT=""
if resolved_cubism_root=$(resolve_cubism_root "${CUBISM:-}"); then
    CUBISM_ROOT="$resolved_cubism_root"
elif resolved_cubism_root=$(resolve_cubism_root "$DEFAULT_CUBISM"); then
    CUBISM_ROOT="$resolved_cubism_root"
fi

if [ -n "$CUBISM_ROOT" ] && [ -d "$CUBISM_ROOT/Core/include" ]; then
    export CUBISM="$CUBISM_ROOT"
    echo "  OK  Cubism SDK:      $CUBISM"
else
    unset CUBISM
    echo "  INFO Cubism SDK not found; Live2D module build disabled"
fi

# =============================================================================
# Architecture-specific settings
# =============================================================================
if [ "$ARCH" = "aarch64" ]; then
    TARGET_TRIPLE="aarch64-unknown-linux-ohos"
    HOST_PLATFORM="linux-aarch64"
elif [ "$ARCH" = "x86_64" ]; then
    TARGET_TRIPLE="x86_64-unknown-linux-ohos"
    HOST_PLATFORM="linux-x86_64"
else
    echo "ERROR: Unsupported arch: $ARCH (use aarch64 or x86_64)"
    exit 1
fi

# =============================================================================
# Environment Sanitization
# =============================================================================
echo ""
echo "[2/7] Sanitizing environment..."
unset C_INCLUDE_PATH CPLUS_INCLUDE_PATH CPATH LIBRARY_PATH
unset MINGW_PREFIX MINGW_CHOST MINGW_PACKAGE_PREFIX
CLEAN_PATH="/usr/bin:/bin"
if [ -d "/mingw64/bin" ]; then
    CLEAN_PATH="/mingw64/bin:$CLEAN_PATH"
fi
export PATH="$CLEAN_PATH"
echo "  PATH cleaned: $PATH"

# =============================================================================
# Compiler Wrappers
# =============================================================================
echo ""
echo "[3/7] Setting up cross-compiler..."

WIN_OHOS_NDK=$(cygpath -m "$OHOS_NDK")
WIN_OHOS_SYSROOT=$(cygpath -m "$OHOS_SYSROOT")
WIN_PY39_INCLUDE=$(cygpath -m "$PY39_SRC/Include")
WIN_PY39_BUILD=$(cygpath -m "$PY39_BUILD")
WIN_HARMONY_DEPS=$(cygpath -m "$HARMONY_DEPS")
WIN_FFMPEG_INSTALL=$(cygpath -m "$FFMPEG_INSTALL")
WIN_SDL_SOURCE_INCLUDE=$(cygpath -m "$SDL_SOURCE_INCLUDE")
WIN_SCRIPT_DIR=$(cygpath -m "$SCRIPT_DIR")

export OHOS_CLANG="$WIN_OHOS_NDK/bin/clang.exe"
export OHOS_CLANGXX="$WIN_OHOS_NDK/bin/clang++.exe"
export OHOS_TARGET="$TARGET_TRIPLE"
export OHOS_SYSROOT="$WIN_OHOS_SYSROOT"

WIN_WRAPPER="$WIN_SCRIPT_DIR/harmony_compiler_wrapper.py"
WRAPPER_UNIX=$(cygpath -u "$WIN_WRAPPER")

echo "  OHOS_CLANG:   $OHOS_CLANG"
echo "  OHOS_TARGET:  $OHOS_TARGET"
echo "  OHOS_SYSROOT: $OHOS_SYSROOT"

echo "  Testing cross-compiler..."
echo 'int test_fn(void) { return 42; }' > /tmp/test_harmony.c
python "$WRAPPER_UNIX" cc -c "$(cygpath -m /tmp/test_harmony.c)" -o "$(cygpath -m /tmp/test_harmony.o)" 2>&1 || {
    echo "  ERROR: Cross-compiler test failed!"
    exit 1
}
file /tmp/test_harmony.o | grep -qi "aarch64\|x86-64" && echo "  OK  Cross-compiler produces $ARCH code"
rm -f /tmp/test_harmony.c /tmp/test_harmony.o

# =============================================================================
# pkg-config
# =============================================================================
echo ""
echo "[4/7] Setting up pkg-config..."

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

export PKG_CONFIG_LIBDIR="$PC_DIR:$FFMPEG_INSTALL/lib/pkgconfig"
unset PKG_CONFIG_PATH
unset PKG_CONFIG_SYSROOT_DIR

for pkg in sdl2 SDL2_image libpng freetype2 harfbuzz fribidi libavcodec libavformat; do
    if pkg-config --exists "$pkg" 2>/dev/null; then
        ver=$(pkg-config --modversion "$pkg" 2>/dev/null || echo "?")
        echo "    OK  $pkg $ver"
    else
        echo "    WARN  $pkg not found via pkg-config"
    fi
done

# =============================================================================
# Build Environment
# =============================================================================
echo ""
echo "[5/7] Setting build environment (Python 3.9 target)..."

export CC="python $WRAPPER_UNIX cc"
export CXX="python $WRAPPER_UNIX cxx"
export LDSHARED="python $WRAPPER_UNIX ldcc"
export LDCXXSHARED="$WIN_CLANGXX --target=$TARGET_TRIPLE --sysroot=$WIN_SYSROOT -D__MUSL__ -shared"

export AR="$(cygpath -m "$OHOS_NDK/bin/llvm-ar.exe")"
export RANLIB="$(cygpath -m "$OHOS_NDK/bin/llvm-ranlib.exe")"
export STRIP="$(cygpath -m "$OHOS_NDK/bin/llvm-strip.exe")"

if [ "$ARCH" = "aarch64" ]; then MARCH_FLAG="-march=armv8.2-a"; else MARCH_FLAG=""; fi
SDL_INCLUDE_FLAGS="-I$WIN_HARMONY_DEPS/include -I$WIN_HARMONY_DEPS/include/SDL2"
if [ -d "$SDL_SOURCE_INCLUDE" ]; then
    SDL_INCLUDE_FLAGS="-I$WIN_SDL_SOURCE_INCLUDE $SDL_INCLUDE_FLAGS"
fi

# Target Python 3.9 headers and libs
export CFLAGS="-I$WIN_PY39_INCLUDE -I$WIN_PY39_BUILD $SDL_INCLUDE_FLAGS -I$WIN_FFMPEG_INSTALL/include -O2 $MARCH_FLAG"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-L$WIN_PY39_BUILD -L$WIN_HARMONY_DEPS/lib -L$WIN_FFMPEG_INSTALL/lib -lpython3.9"

export HARMONY_PYTHON_INCLUDE="$WIN_PY39_INCLUDE"
export HARMONY_PYTHON_LIBDIR="$WIN_PY39_BUILD"
export HARMONY_PYTHON_LDLIBRARY="libpython3.9.so.1.0"
export _PYTHON_HOST_PLATFORM="$HOST_PLATFORM"

export RENPY_DEPS_INSTALL="$HARMONY_DEPS::$FFMPEG_INSTALL"
export RENPY_SKIP_PACKAGES=""
export RENPY_SKIP_MODULES="renpy.tfd"

echo "  CC=$CC"
echo "  _PYTHON_HOST_PLATFORM=$HOST_PLATFORM"
echo "  CFLAGS=$CFLAGS"
echo "  LDFLAGS=$LDFLAGS"

# =============================================================================
# Generate Cython C files
# =============================================================================
echo ""
echo "[6/7] Cython C files..."

# Preserve pre-generated C files in tmp/gen3/ — do NOT regenerate.
# Touch .c files to ensure they're newer than .pyx sources (prevent auto-regen).
find tmp/gen3 -name '*.c' -o -name '*.cc' | while read f; do touch "$f"; done 2>/dev/null || true

GEN_COUNT=$(ls tmp/gen3/*.c tmp/gen3/*.cc 2>/dev/null | wc -l)
echo "  C files available: $GEN_COUNT"
[ "$GEN_COUNT" -lt 10 ] && { echo "  ERROR: Too few pre-generated C files in tmp/gen3/"; exit 1; }
echo "  Using pre-generated C files (skipping Cython regeneration)"

# =============================================================================
# Build Extensions
# =============================================================================
echo ""
echo "[7/7] Building Ren'Py extensions for HarmonyOS $ARCH (Python 3.9)..."
echo ""

BUILD_DIR="build/harmony-py39-$ARCH"
rm -rf "$BUILD_DIR"

python harmony_setup_wrapper.py build_ext \
    --build-lib="$BUILD_DIR/lib" \
    --build-temp="$BUILD_DIR/temp" \
    --compiler=unix \
    --force \
    2>&1 | tee "build_harmony_py39_${ARCH}.log"

BUILD_EXIT=${PIPESTATUS[0]}

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
        size=$(stat -c%s "$f" 2>/dev/null || stat -f%z "$f" 2>/dev/null || echo "?")
        name=$(echo "$f" | sed "s|$BUILD_DIR/lib/||")
        echo "    $name ($size bytes)"
    done
    SAMPLE=$(find "$BUILD_DIR/lib" -name "*.so" -type f 2>/dev/null | head -1)
    if [ -n "$SAMPLE" ]; then
        echo ""
        echo "  Architecture verification:"
        file "$SAMPLE"
    fi
    echo ""
    echo "  SUCCESS: $SO_COUNT Ren'Py modules built for Python 3.9!"
    echo "  Output: $SCRIPT_DIR/$BUILD_DIR/lib/"
else
    echo "  FAIL: No .so files produced!"
    grep -i "error:" "build_harmony_py39_${ARCH}.log" 2>/dev/null | tail -10
    exit 1
fi

echo "  Build log: build_harmony_py39_${ARCH}.log"
echo "============================================================"
