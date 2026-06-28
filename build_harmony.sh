#!/bin/bash
# =============================================================================
# Ren'Py HarmonyOS Cross-Compilation Script
# Builds Ren'Py Python extension modules (.so) for HarmonyOS aarch64/x86_64
#
# Uses:
#   - MSYS2 Python (host) to run setup.py / cython
#   - HarmonyOS NDK clang for cross-compilation
#   - Pre-built libraries from Python-3.12.12/harmony_deps, install-harmony-*,
#     and third_party_ffmpeg/install-harmony-*
# =============================================================================

set -e

ARCH="${1:-aarch64}"
echo "============================================================"
echo "  Ren'Py HarmonyOS Build - $ARCH"
echo "============================================================"

# =============================================================================
# Paths
# =============================================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

PYTHON_ROOT="$(cd ../../Python-3.12.12 && pwd)"
HARMONY_DEPS="$PYTHON_ROOT/harmony_deps/$ARCH"
PYTHON_INSTALL="$PYTHON_ROOT/install-harmony-$ARCH"
FFMPEG_ROOT="$(cd ../../third_party_ffmpeg && pwd)"
FFMPEG_INSTALL="$FFMPEG_ROOT/install-harmony-$ARCH"
SDL_SOURCE_INCLUDE="$(cd ../../SDL2/SDL/include && pwd)"
DEFAULT_CUBISM="/e/Git/CubismSdkForNative-5-r.5"

OHOS_SDK_ROOT="/c/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native"
OHOS_NDK="$OHOS_SDK_ROOT/llvm"
OHOS_SYSROOT="$OHOS_SDK_ROOT/sysroot"

resolve_cubism_root() {
    local root="$1"

    if [ -z "$root" ]; then
        return 1
    fi

    if [ -d "$root" ]; then
        printf '%s\n' "$root"
        return 0
    fi

    if command -v cygpath >/dev/null 2>&1; then
        local normalized
        normalized=$(cygpath -u "$root" 2>/dev/null || true)
        if [ -n "$normalized" ] && [ -d "$normalized" ]; then
            printf '%s\n' "$normalized"
            return 0
        fi
    fi

    return 1
}

# =============================================================================
# Validate
# =============================================================================
echo ""
echo "[1/7] Validating environment..."

errs=0
for d in "$PYTHON_INSTALL/include/python3.12" "$PYTHON_INSTALL/lib" \
         "$HARMONY_DEPS/lib" "$HARMONY_DEPS/include" \
         "$FFMPEG_INSTALL/lib" "$FFMPEG_INSTALL/include" \
         "$OHOS_NDK/bin"; do
    if [ ! -d "$d" ]; then
        echo "  ERROR: Missing directory: $d"
        errs=$((errs+1))
    fi
done
[ $errs -gt 0 ] && exit 1

echo "  OK  Python headers:  $PYTHON_INSTALL/include/python3.12"
echo "  OK  Python lib:      $PYTHON_INSTALL/lib/libpython3.12.so"
echo "  OK  harmony_deps:    $HARMONY_DEPS"
echo "  OK  FFmpeg:          $FFMPEG_INSTALL"
echo "  OK  NDK:             $OHOS_NDK"
if [ -d "$SDL_SOURCE_INCLUDE" ]; then
    echo "  OK  SDL headers:     $SDL_SOURCE_INCLUDE"
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

# Prevent MinGW header/library pollution
unset C_INCLUDE_PATH CPLUS_INCLUDE_PATH CPATH LIBRARY_PATH
unset MINGW_PREFIX MINGW_CHOST MINGW_PACKAGE_PREFIX

# Strip MinGW paths from PATH, keep only essentials
CLEAN_PATH="/usr/bin:/bin"
if [ -d "/mingw64/bin" ]; then
    # Keep mingw64/bin for python, cython, pkg-config etc.
    CLEAN_PATH="/mingw64/bin:$CLEAN_PATH"
fi
export PATH="$CLEAN_PATH"

echo "  PATH cleaned: $PATH"

# =============================================================================
# Compiler Wrappers (Python-based, executable by Windows Python subprocess)
# =============================================================================
echo ""
echo "[3/7] Setting up cross-compiler..."

# Get Windows-format paths using cygpath
WIN_OHOS_NDK=$(cygpath -m "$OHOS_NDK")
WIN_OHOS_SYSROOT=$(cygpath -m "$OHOS_SYSROOT")
WIN_PYTHON_INSTALL=$(cygpath -m "$PYTHON_INSTALL")
WIN_HARMONY_DEPS=$(cygpath -m "$HARMONY_DEPS")
WIN_FFMPEG_INSTALL=$(cygpath -m "$FFMPEG_INSTALL")
WIN_SDL_SOURCE_INCLUDE=$(cygpath -m "$SDL_SOURCE_INCLUDE")
WIN_SCRIPT_DIR=$(cygpath -m "$SCRIPT_DIR")

# Set compiler paths for the Python wrapper
export OHOS_CLANG="$WIN_OHOS_NDK/bin/clang.exe"
export OHOS_CLANGXX="$WIN_OHOS_NDK/bin/clang++.exe"
export OHOS_TARGET="$TARGET_TRIPLE"
export OHOS_SYSROOT="$WIN_OHOS_SYSROOT"

WIN_WRAPPER="$WIN_SCRIPT_DIR/harmony_compiler_wrapper.py"

echo "  OHOS_CLANG:   $OHOS_CLANG"
echo "  OHOS_CLANGXX: $OHOS_CLANGXX"
echo "  OHOS_TARGET:  $OHOS_TARGET"
echo "  OHOS_SYSROOT: $OHOS_SYSROOT"
echo "  Wrapper:      $WIN_WRAPPER"

# Quick sanity check - compile a test file
echo "  Testing cross-compiler..."
echo 'int test_fn(void) { return 42; }' > /tmp/test_harmony.c
python "$WIN_WRAPPER" cc -c "$(cygpath -m /tmp/test_harmony.c)" -o "$(cygpath -m /tmp/test_harmony.o)" 2>&1 || {
    echo "  ERROR: Cross-compiler test failed!"
    exit 1
}
file /tmp/test_harmony.o | grep -qi "aarch64\|x86-64" && echo "  OK  Cross-compiler produces $ARCH code"
rm -f /tmp/test_harmony.c /tmp/test_harmony.o

# =============================================================================
# Create missing .pc files
# =============================================================================
echo ""
echo "[4/7] Setting up pkg-config..."

PC_DIR="$HARMONY_DEPS/lib/pkgconfig"
mkdir -p "$PC_DIR"

# SDL2
cat > "$PC_DIR/sdl2.pc" << PCEOF
prefix=$HARMONY_DEPS
libdir=\${prefix}/lib
includedir=\${prefix}/include

Name: sdl2
Description: Simple DirectMedia Layer 2
Version: 2.32.10
Libs: -L\${libdir} -lSDL2
Cflags: -I\${includedir}/SDL2
PCEOF
echo "  Created sdl2.pc"

# SDL2_image
cat > "$PC_DIR/SDL2_image.pc" << PCEOF
prefix=$HARMONY_DEPS
libdir=\${prefix}/lib
includedir=\${prefix}/include

Name: SDL2_image
Description: SDL2 image loading library
Version: 2.0
Requires: sdl2
Libs: -L\${libdir} -lSDL2_image-2.0
Cflags: -I\${includedir}
PCEOF
echo "  Created SDL2_image.pc"

# SDL2_mixer
cat > "$PC_DIR/SDL2_mixer.pc" << PCEOF
prefix=$HARMONY_DEPS
libdir=\${prefix}/lib
includedir=\${prefix}/include

Name: SDL2_mixer
Description: SDL2 mixer library
Version: 2.0
Requires: sdl2
Libs: -L\${libdir} -lSDL2_mixer-2.0
Cflags: -I\${includedir}
PCEOF
echo "  Created SDL2_mixer.pc"

# SDL2_ttf
cat > "$PC_DIR/SDL2_ttf.pc" << PCEOF
prefix=$HARMONY_DEPS
libdir=\${prefix}/lib
includedir=\${prefix}/include

Name: SDL2_ttf
Description: SDL2 TrueType font library
Version: 2.0
Requires: sdl2 freetype2
Libs: -L\${libdir} -lSDL2_ttf-2.0
Cflags: -I\${includedir}
PCEOF
echo "  Created SDL2_ttf.pc"

# Set PKG_CONFIG_LIBDIR (overrides PKG_CONFIG_PATH completely)
export PKG_CONFIG_LIBDIR="$PC_DIR:$FFMPEG_INSTALL/lib/pkgconfig"
unset PKG_CONFIG_PATH
unset PKG_CONFIG_SYSROOT_DIR

echo "  PKG_CONFIG_LIBDIR=$PKG_CONFIG_LIBDIR"

# Verify key packages are findable
echo "  Verifying pkg-config packages..."
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
echo "[5/7] Setting build environment..."

# CC/CXX use the Python wrapper - distutils will split on spaces
# "python path/to/wrapper.py cc" → subprocess.call(["python", "wrapper.py", "cc", ...args])
export CC="python $WIN_WRAPPER cc"
export CXX="python $WIN_WRAPPER cxx"
export LDSHARED="python $WIN_WRAPPER ldcc"
export LDCXXSHARED="$WIN_CLANGXX --target=$TARGET_TRIPLE --sysroot=$WIN_SYSROOT -D__MUSL__ -shared"

export AR="$(cygpath -m "$OHOS_NDK/bin/llvm-ar.exe")"
export RANLIB="$(cygpath -m "$OHOS_NDK/bin/llvm-ranlib.exe")"
export STRIP="$(cygpath -m "$OHOS_NDK/bin/llvm-strip.exe")"

# Include paths (Windows format for clang.exe)
# -march=armv8.2-a: 仅 aarch64 加微架构优化（x86_64 不加）
if [ "$ARCH" = "aarch64" ]; then
    MARCH_FLAG="-march=armv8.2-a"
else
    MARCH_FLAG=""
fi
SDL_INCLUDE_FLAGS="-I$WIN_HARMONY_DEPS/include -I$WIN_HARMONY_DEPS/include/SDL2"
if [ -d "$SDL_SOURCE_INCLUDE" ]; then
    SDL_INCLUDE_FLAGS="-I$WIN_SDL_SOURCE_INCLUDE $SDL_INCLUDE_FLAGS"
fi
export CFLAGS="-I$WIN_PYTHON_INSTALL/include/python3.12 $SDL_INCLUDE_FLAGS -I$WIN_FFMPEG_INSTALL/include -O2 $MARCH_FLAG"
export CXXFLAGS="$CFLAGS"

# Library paths and link flags (Windows format)
export LDFLAGS="-L$WIN_PYTHON_INSTALL/lib -L$WIN_HARMONY_DEPS/lib -L$WIN_FFMPEG_INSTALL/lib -lpython3.12"

# Pass target Python runtime paths to harmony_setup_wrapper.py so distutils
# won't inject host Python (MSYS2) include/lib options.
export HARMONY_PYTHON_INCLUDE="$WIN_PYTHON_INSTALL/include/python3.12"
export HARMONY_PYTHON_LIBDIR="$WIN_PYTHON_INSTALL/lib"
export HARMONY_PYTHON_LDLIBRARY="libpython3.12.so"

# Tell distutils/setuptools this is a cross-compilation for Linux
export _PYTHON_HOST_PLATFORM="$HOST_PLATFORM"

# Skip packages and modules without HarmonyOS libraries
# Note: OpenSSL is now available (built in Python-3.12.12/harmony_deps)
export RENPY_SKIP_PACKAGES=""
export RENPY_SKIP_MODULES="renpy.tfd"

echo "  CC=$CC"
echo "  LDSHARED=$LDSHARED"
echo "  _PYTHON_HOST_PLATFORM=$HOST_PLATFORM"
echo "  CFLAGS=$CFLAGS"
echo "  LDFLAGS=$LDFLAGS"
echo "  RENPY_SKIP_PACKAGES=$RENPY_SKIP_PACKAGES"

# =============================================================================
# Generate Cython C files
# =============================================================================
echo ""
echo "[6/7] Generating Cython C files..."

# Temporarily restore normal env for cython generation (host operation)
if command -v cython &>/dev/null; then
    echo "  Using cython: $(which cython)"
    # Generate step doesn't compile, just runs cython to produce .c files
    python setup.py generate 2>&1 | tail -5
    echo "  Cython generation done"
else
    echo "  WARNING: cython not found, assuming C files already generated"
fi

# Verify generated files exist
GEN_COUNT=$(ls tmp/gen3/*.c 2>/dev/null | wc -l)
echo "  Generated C files in tmp/gen3/: $GEN_COUNT"
if [ "$GEN_COUNT" -lt 10 ]; then
    echo "  ERROR: Too few generated C files, cython generation may have failed"
    exit 1
fi

# =============================================================================
# Build Extensions
# =============================================================================
echo ""
echo "[7/7] Building Ren'Py extensions for HarmonyOS $ARCH..."
echo ""

BUILD_DIR="build/harmony-$ARCH"
rm -rf "$BUILD_DIR"

python harmony_setup_wrapper.py build_ext \
    --build-lib="$BUILD_DIR/lib" \
    --build-temp="$BUILD_DIR/temp" \
    --compiler=unix \
    --force \
    2>&1 | tee "build_harmony_${ARCH}.log"

BUILD_EXIT=${PIPESTATUS[0]}

# =============================================================================
# Results
# =============================================================================
echo ""
echo "============================================================"
echo "  Build Results - $ARCH"
echo "============================================================"

SO_COUNT=$(find "$BUILD_DIR/lib" -name "*.so" -type f 2>/dev/null | wc -l)
echo "  .so modules found: $SO_COUNT"

if [ "$SO_COUNT" -gt 0 ]; then
    echo ""
    echo "  Built modules:"
    find "$BUILD_DIR/lib" -name "*.so" -type f 2>/dev/null | sort | while read f; do
        size=$(stat -c%s "$f" 2>/dev/null || stat -f%z "$f" 2>/dev/null || echo "?")
        name=$(echo "$f" | sed "s|$BUILD_DIR/lib/||")
        echo "    $name ($size bytes)"
    done

    # Verify architecture
    echo ""
    echo "  Architecture verification:"
    SAMPLE=$(find "$BUILD_DIR/lib" -name "*.so" -type f 2>/dev/null | head -1)
    if [ -n "$SAMPLE" ]; then
        file "$SAMPLE"
    fi

    echo ""
    echo "  SUCCESS: $SO_COUNT HarmonyOS $ARCH modules built!"
    echo "  Output: $SCRIPT_DIR/$BUILD_DIR/lib/"
else
    echo ""
    echo "  WARNING: No .so files produced!"
    echo "  Check build_harmony_${ARCH}.log for errors"
    echo ""
    # Show last errors from log
    echo "  Last errors:"
    grep -i "error:" "build_harmony_${ARCH}.log" 2>/dev/null | tail -10
    exit 1
fi

echo ""
echo "  Build log: build_harmony_${ARCH}.log"
echo "============================================================"
