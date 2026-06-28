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

ROOT="$(cd ../.. && pwd)"

# Python 3.9 source and per-arch build output
PY39_SRC="$ROOT/Python-3.9.25"
if [ "$ARCH" = "aarch64" ]; then
    PY39_BUILD="$ROOT/workspace_temp/build_py39_aarch64"
else
    PY39_BUILD="$ROOT/workspace_temp/build_py39_x86_64"
fi

# Platform deps (SDL2, freetype, harfbuzz, etc.) — Python-version-independent, reuse from 3.12 tree
HARMONY_DEPS="$ROOT/Python-3.12.12/harmony_deps/$ARCH"
FFMPEG_ROOT="$ROOT/third_party_ffmpeg"
FFMPEG_INSTALL="$FFMPEG_ROOT/install-harmony-$ARCH"
SDL_SOURCE_INCLUDE="$ROOT/SDL2/SDL/include"
DEFAULT_CUBISM_UNIX="/mnt/e/Git/CubismSdkForNative-5-r.5"
DEFAULT_CUBISM_WIN="E:\\Git\\CubismSdkForNative-5-r.5"
PY39_HOST_ROOT="$ROOT/workspace_temp/python39_host"
VENV_ROOT="$ROOT/.venv"

OHOS_SDK_ROOT="/mnt/c/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native"

# Fallback: /ohos-sdk symlink (used by build_python39_arm64.sh)
if [ ! -d "$OHOS_SDK_ROOT" ] && [ -d "/ohos-sdk" ]; then
    OHOS_SDK_ROOT="/ohos-sdk"
fi
OHOS_NDK="$OHOS_SDK_ROOT/llvm"
OHOS_SYSROOT="$OHOS_SDK_ROOT/sysroot"

CYGPATH_BIN="$(command -v cygpath 2>/dev/null || true)"

to_win_path() {
    local path="$1"

    if [ -n "$CYGPATH_BIN" ]; then
        "$CYGPATH_BIN" -m "$path"
        return
    fi

    case "$path" in
        /mnt/[a-zA-Z]/*)
            local drive="${path#/mnt/}"
            drive="${drive%%/*}"
            local rest="${path#"/mnt/$drive/"}"
            printf '%s:/%s\n' "${drive^^}" "$rest"
            ;;
        *)
            printf '%s\n' "$path"
            ;;
    esac
}

to_unix_path() {
    local path="$1"

    if [ -n "$CYGPATH_BIN" ]; then
        "$CYGPATH_BIN" -u "$path"
        return
    fi

    case "$path" in
        [A-Za-z]:/*|[A-Za-z]:\\*)
            local drive="${path%%:*}"
            local rest="${path#?:}"
            rest="${rest//\\//}"
            rest="${rest#/}"
            printf '/mnt/%s/%s\n' "${drive,,}" "$rest"
            ;;
        *)
            printf '%s\n' "$path"
            ;;
    esac
}

resolve_cubism_root() {
    local root="$1"

    if [ -z "$root" ]; then
        return 1
    fi

    if [ -d "$root" ]; then
        printf '%s\n' "$root"
        return 0
    fi

    if [ -n "$CYGPATH_BIN" ] || [[ "$root" == [A-Za-z]:* ]]; then
        local normalized
        normalized=$(to_unix_path "$root" 2>/dev/null || true)
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
elif resolved_cubism_root=$(resolve_cubism_root "$DEFAULT_CUBISM_UNIX"); then
    CUBISM_ROOT="$resolved_cubism_root"
elif resolved_cubism_root=$(resolve_cubism_root "$DEFAULT_CUBISM_WIN"); then
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
    CLEAN_PATH="/mingw64/bin:$CLEAN_PATH"
fi
PATH="$CLEAN_PATH"

PYTHON_EXE=""
for candidate in \
    "/mingw64/bin/python" \
    "/usr/bin/python3" \
    "/usr/bin/python" \
    "$PY39_HOST_ROOT/python.exe" \
    "$VENV_ROOT/Scripts/python.exe"
do
    if [ -x "$candidate" ]; then
        PYTHON_EXE="$candidate"
        break
    fi
done

if [ -z "$PYTHON_EXE" ] && command -v python >/dev/null 2>&1; then
    PYTHON_EXE="$(command -v python)"
fi

if [ -z "$PYTHON_EXE" ] && command -v python3 >/dev/null 2>&1; then
    PYTHON_EXE="$(command -v python3)"
fi

if [ -z "$PYTHON_EXE" ]; then
    echo "  ERROR: Host Python not found (checked python39_host, .venv, mingw64, system python)"
    exit 1
fi

# Convert to Windows path for setuptools/CC
export PYTHON_WIN=$(to_win_path "$PYTHON_EXE")
if [ -f "$PYTHON_EXE" ]; then
    python() { "$PYTHON_EXE" "$@"; }
    export -f python
    echo "  Using Python: $PYTHON_EXE"
else
    echo "  ERROR: Host Python path is not a file: $PYTHON_EXE"
    exit 1
fi

echo "  PATH cleaned: $PATH"

HOST_PY_MM="$("$PYTHON_EXE" -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"
HOST_PY_INCLUDE_ROOT="$PY39_HOST_ROOT/Include/python$HOST_PY_MM"

if [ ! -f "$HOST_PY_INCLUDE_ROOT/pygame_sdl2/pygame_sdl2.rwobject_api.h" ]; then
    for fallback_include in \
        "$PY39_HOST_ROOT/Include/python3.12" \
        "$PY39_HOST_ROOT/Include/python3.9"
    do
        if [ -d "$fallback_include/pygame_sdl2" ]; then
            mkdir -p "$HOST_PY_INCLUDE_ROOT/pygame_sdl2"
            cp -f "$fallback_include/pygame_sdl2/"* "$HOST_PY_INCLUDE_ROOT/pygame_sdl2/"
            break
        fi
    done
fi

if [ ! -f "$HOST_PY_INCLUDE_ROOT/pygame_sdl2/pygame_sdl2.h" ]; then
    echo "  ERROR: pygame_sdl2.h not found under $PY39_HOST_ROOT/Include/python*/pygame_sdl2/"
    exit 1
fi

echo "  Host Python ABI hint: $HOST_PY_MM"
echo "  Host include shim:    $HOST_PY_INCLUDE_ROOT"

if [[ "$PYTHON_EXE" == *.exe ]]; then
    PYTHON_LAUNCH="$PYTHON_WIN"
    WRAPPER_PY="$(to_win_path "$SCRIPT_DIR/harmony_compiler_wrapper.py")"
else
    PYTHON_LAUNCH="$PYTHON_EXE"
    WRAPPER_PY="$SCRIPT_DIR/harmony_compiler_wrapper.py"
    VENV_SITE_PACKAGES="$VENV_ROOT/Lib/site-packages"
    if [ -d "$VENV_SITE_PACKAGES" ]; then
        export PYTHONPATH="$VENV_SITE_PACKAGES${PYTHONPATH:+:$PYTHONPATH}"
    fi
fi

echo "  Python launcher:      $PYTHON_LAUNCH"
echo "  Python wrapper path:  $WRAPPER_PY"

# =============================================================================
# Compiler Wrappers (Python-based, executable by Windows Python subprocess)
# =============================================================================
echo ""
echo "[3/7] Setting up cross-compiler..."

# Use native cygpath when available, otherwise fall back to /mnt/* conversion.
_cygpath_win() { to_win_path "$1"; }
# Get Windows-format paths
WIN_OHOS_NDK=$(_cygpath_win "$OHOS_NDK")
WIN_OHOS_SYSROOT=$(_cygpath_win "$OHOS_SYSROOT")
WIN_PY39_INCLUDE=$(_cygpath_win "$PY39_SRC/Include")
WIN_PY39_BUILD=$(_cygpath_win "$PY39_BUILD")
WIN_HARMONY_DEPS=$(_cygpath_win "$HARMONY_DEPS")
WIN_FFMPEG_INSTALL=$(_cygpath_win "$FFMPEG_INSTALL")
WIN_SDL_SOURCE_INCLUDE=$(_cygpath_win "$SDL_SOURCE_INCLUDE")
WIN_SCRIPT_DIR=$(_cygpath_win "$SCRIPT_DIR")
WIN_PY39_HOST=$(_cygpath_win "$PY39_HOST_ROOT")
WIN_HOST_PY_INCLUDE=$(_cygpath_win "$HOST_PY_INCLUDE_ROOT")

# Set compiler paths for the Python wrapper.
# Native Windows Python needs Windows paths, while POSIX-hosted Python needs
# executable/compiler paths that exist in the POSIX filesystem.
if [[ "$PYTHON_EXE" == *.exe ]]; then
    export OHOS_CLANG="$(_cygpath_win "$OHOS_NDK/bin/clang.exe")"
    export OHOS_CLANGXX="$(_cygpath_win "$OHOS_NDK/bin/clang++.exe")"
    export OHOS_SYSROOT="$WIN_OHOS_SYSROOT"
else
    export OHOS_CLANG="$OHOS_NDK/bin/clang.exe"
    export OHOS_CLANGXX="$OHOS_NDK/bin/clang++.exe"
    export OHOS_SYSROOT="$WIN_OHOS_SYSROOT"
fi
export OHOS_TARGET="$TARGET_TRIPLE"

echo "  OHOS_CLANG:   $OHOS_CLANG"
echo "  OHOS_CLANGXX: $OHOS_CLANGXX"
echo "  OHOS_TARGET:  $OHOS_TARGET"
echo "  OHOS_SYSROOT: $OHOS_SYSROOT"
echo "  Wrapper:      $WRAPPER_PY"

# Quick sanity check - compile a test file
echo "  Testing cross-compiler..."
TEST_SRC="$SCRIPT_DIR/.tmp_test_harmony.c"
TEST_OBJ="$SCRIPT_DIR/.tmp_test_harmony.o"
echo 'int test_fn(void) { return 42; }' > "$TEST_SRC"
$PYTHON_EXE "$WRAPPER_PY" cc -c "$(to_win_path "$TEST_SRC")" -o "$(to_win_path "$TEST_OBJ")" 2>&1 || {
    echo "  ERROR: Cross-compiler test failed!"
    exit 1
}
file "$TEST_OBJ" | grep -qi "aarch64\|x86-64" && echo "  OK  Cross-compiler produces $ARCH code"
rm -f "$TEST_SRC" "$TEST_OBJ"

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
export CC="$PYTHON_LAUNCH $WRAPPER_PY cc"
export CXX="$PYTHON_LAUNCH $WRAPPER_PY cxx"
export LDSHARED="$PYTHON_LAUNCH $WRAPPER_PY ldcc"
export LDCXXSHARED="$WIN_CLANGXX --target=$TARGET_TRIPLE --sysroot=$WIN_SYSROOT -D__MUSL__ -shared"

export AR="$(_cygpath_win "$OHOS_NDK/bin/llvm-ar.exe")"
export RANLIB="$(_cygpath_win "$OHOS_NDK/bin/llvm-ranlib.exe")"
export STRIP="$(_cygpath_win "$OHOS_NDK/bin/llvm-strip.exe")"

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
export CFLAGS="-I$WIN_PY39_INCLUDE -I$WIN_PY39_BUILD -I$WIN_HOST_PY_INCLUDE $SDL_INCLUDE_FLAGS -I$WIN_FFMPEG_INSTALL/include -O2 $MARCH_FLAG"
export CXXFLAGS="$CFLAGS"

# Library paths and link flags (Windows format) — target Python 3.9
export LDFLAGS="-L$WIN_PY39_BUILD -L$WIN_HARMONY_DEPS/lib -L$WIN_FFMPEG_INSTALL/lib -lpython3.9"

# Pass target Python runtime paths to harmony_setup_wrapper.py so distutils
# won't inject host Python (MSYS2) include/lib options.
export HARMONY_PYTHON_INCLUDE="$WIN_PY39_INCLUDE"
export HARMONY_PYTHON_LIBDIR="$WIN_PY39_BUILD"
export HARMONY_PYTHON_LDLIBRARY="libpython3.9.so.1.0"

# Tell distutils/setuptools this is a cross-compilation for Linux
export _PYTHON_HOST_PLATFORM="$HOST_PLATFORM"

# Tell setuplib.py's include()/library() where to find deps.
# Use filesystem-native paths so pure-Python os.path.exists checks succeed.
if [[ "$PYTHON_EXE" == *.exe ]]; then
    export RENPY_DEPS_INSTALL="$WIN_PY39_HOST::$WIN_HARMONY_DEPS::$WIN_FFMPEG_INSTALL"
else
    export RENPY_DEPS_INSTALL="$PY39_HOST_ROOT::$HARMONY_DEPS::$FFMPEG_INSTALL"
fi

# RENPY_CYTHON_INCLUDES: extra -I flags for Cython's C preprocessor
# (needed so GCC can find SDL2/SDL.h etc. in OHOS deps paths)
export RENPY_CYTHON_INCLUDES="$WIN_HARMONY_DEPS/include::$WIN_HARMONY_DEPS/include/SDL2::$WIN_FFMPEG_INSTALL/include"

# Skip packages and modules without HarmonyOS libraries
export RENPY_SKIP_PACKAGES=""
# Skip only tfd (Windows-specific tinyfiledialogs)
export RENPY_SKIP_MODULES="renpy.tfd _renpytfd"

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
echo "[6/7] Generating Cython C files (module build system)..."

# Python 3.9 host + Cython 0.29.37 — the correct toolchain for Ren'Py 8.3.7
if [ -x "$PY39_HOST_ROOT/Scripts/cython.exe" ]; then
    RENPY_CYTHON_ROOT="$PY39_HOST_ROOT/Scripts/cython.exe"
elif [ -x "$VENV_ROOT/Scripts/cython.exe" ]; then
    RENPY_CYTHON_ROOT="$VENV_ROOT/Scripts/cython.exe"
else
    echo "  ERROR: Cython not found in python39_host or .venv"
    exit 1
fi

if [[ "$PYTHON_EXE" == *.exe ]]; then
    export RENPY_CYTHON="$(_cygpath_win "$RENPY_CYTHON_ROOT")"
else
    export RENPY_CYTHON="$RENPY_CYTHON_ROOT"
fi
echo "  Cython: $RENPY_CYTHON"

# module/setup.py always calls generate_all_cython() before build_ext.
# Pre-run to generate .c files and fail fast on errors.
$PYTHON_EXE module/setup.py generate 2>&1 | tail -5 || true

# Verify generated files in module/gen3/
GEN_COUNT=$(ls module/gen3/*.c 2>/dev/null | wc -l)
echo "  C files in module/gen3/: $GEN_COUNT"
[ "$GEN_COUNT" -lt 10 ] && { echo "  ERROR: Too few C files"; exit 1; }

# =============================================================================
# Build Extensions
# =============================================================================
echo ""
echo "[7/7] Building Ren'Py extensions for HarmonyOS $ARCH..."
echo ""

BUILD_DIR="$SCRIPT_DIR/build/harmony-py39-$ARCH"

# Note: harmony_setup_module.py does os.chdir(module/), so relative paths
# resolve from module/. Use absolute path to avoid confusion.
$PYTHON_EXE harmony_setup_module.py build_ext \
    --build-lib="$BUILD_DIR/lib" \
    --build-temp="$BUILD_DIR/temp" \
    --compiler=unix \
    --force \
    2>&1 | tee "$SCRIPT_DIR/build_harmony_py39_${ARCH}.log"

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
