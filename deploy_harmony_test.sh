#!/bin/bash
# =============================================================================
# Package Ren'Py HarmonyOS test into a staging dir, then push via hdc
# All hdc file send calls use Windows paths (cygpath -w) to avoid MSYS2 issues
# =============================================================================
set -e

ARCH="${1:-x86_64}"
HDC_PATH='/c/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/toolchains/hdc.exe'
DEVICE_BASE="/data/local/tmp/renpy_test"

hdc_cmd() {
    "$(cygpath -u "$HDC_PATH")" "$@"
}
hdc_send() {
    local src="$(cygpath -w "$1")"
    local dst="$2"
    "$(cygpath -u "$HDC_PATH")" file send "$src" "$dst"
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_DIR="$(cd "$SCRIPT_DIR/../../Python-3.12.12" && pwd)"
FFMPEG_DIR="$(cd "$SCRIPT_DIR/../../third_party_ffmpeg" && pwd)"

RENPY_BUILD="$SCRIPT_DIR/build/harmony-$ARCH/lib"
HARMONY_DEPS="$PYTHON_DIR/harmony_deps/$ARCH"
PYTHON_INSTALL="$PYTHON_DIR/install-harmony-$ARCH"
FFMPEG_INSTALL="$FFMPEG_DIR/install-harmony-$ARCH"
STAGING="/tmp/renpy_staging_$$"

echo "=============================================="
echo "  Deploying Ren'Py to HarmonyOS ($ARCH)"
echo "=============================================="

for d in "$RENPY_BUILD" "$HARMONY_DEPS" "$PYTHON_INSTALL" "$FFMPEG_INSTALL"; do
    [ ! -d "$d" ] && echo "ERROR: $d not found" && exit 1
done

echo ""
echo "[1/6] Checking device..."
hdc_cmd list targets | head -1

echo ""
echo "[2/6] Creating staging directory..."
rm -rf "$STAGING"
mkdir -p "$STAGING/lib/python3.12"

# --- Collect all files into staging ---
echo ""
echo "[3/6] Collecting shared libraries..."

cp "$PYTHON_INSTALL/lib/libpython3.12.so.1.0" "$STAGING/lib/"
cd "$STAGING/lib" && ln -sf libpython3.12.so.1.0 libpython3.12.so

for lib in libSDL2.so libSDL2_image-2.0.so libSDL2_mixer-2.0.so libSDL2_ttf-2.0.so \
           libz.so libpng16.so libpng.so libfreetype.so libharfbuzz.so libfribidi.so \
           libjpeg.so libjpeg.so.62 libjpeg.so.62.3.0 \
           libc++_shared.so libffi.so libffi.so.8 libffi.so.8.1.1 \
           libavif.so libogg.so libopus.so libopusfile.so libtiff.so libwebp.so; do
    [ -f "$HARMONY_DEPS/lib/$lib" ] && cp "$HARMONY_DEPS/lib/$lib" "$STAGING/lib/" && echo "  $lib"
done

for lib in libavcodec.so libavformat.so libavutil.so libswresample.so libswscale.so libavfilter.so; do
    REAL=$(readlink -f "$FFMPEG_INSTALL/lib/$lib" 2>/dev/null)
    [ -f "$REAL" ] && cp "$REAL" "$STAGING/lib/$lib" && echo "  $lib (ffmpeg)"
done

echo ""
echo "[4/6] Collecting Python & Ren'Py..."

# Python executable
cp "$PYTHON_INSTALL/bin/python3.12" "$STAGING/python3.12"
chmod +x "$STAGING/python3.12"

# Python stdlib (rsync if available, else cp)
echo "  stdlib..."
if command -v rsync &>/dev/null; then
    rsync -a --exclude='__pycache__' --exclude='test' --exclude='tests' \
        --exclude='idlelib' --exclude='tkinter' --exclude='turtledemo' \
        --exclude='ensurepip' --exclude='lib2to3' --exclude='*.pyc' \
        --exclude='distutils' --exclude='unittest' \
        "$PYTHON_INSTALL/lib/python3.12/" "$STAGING/lib/python3.12/"
else
    cp -r "$PYTHON_INSTALL/lib/python3.12/"* "$STAGING/lib/python3.12/" 2>/dev/null || true
fi

# Ren'Py compiled .so modules
echo "  Ren'Py .so modules..."
cp -r "$RENPY_BUILD"/* "$STAGING/lib/"

# Ren'Py Python source
echo "  Ren'Py Python source..."
cd "$SCRIPT_DIR"
find renpy -name '*.py' | while IFS= read -r f; do
    dir="$STAGING/$(dirname "$f")"
    mkdir -p "$dir"
    cp "$f" "$dir/"
done

# Merge compiled .so into renpy tree for import resolution
cp -rf "$STAGING/lib/renpy/"* "$STAGING/renpy/" 2>/dev/null || true
cp -f "$STAGING/lib/_renpy.cpython-312.so" "$STAGING/" 2>/dev/null || true

# Test script
cp "$SCRIPT_DIR/test_harmony_device.py" "$STAGING/"

# Demo game
[ -d "$SCRIPT_DIR/the_question" ] && cp -r "$SCRIPT_DIR/the_question" "$STAGING/" && echo "  the_question game"

echo ""
echo "[5/6] Pushing to device..."

# Create tar archive
TARNAME="renpy_deploy.tar.gz"
cd "$STAGING/.."
tar czf "$TARNAME" -C "$STAGING" .
echo "  Archive size: $(du -sh "$TARNAME" | cut -f1)"

# Clean device and push
hdc_cmd shell "rm -rf $DEVICE_BASE && mkdir -p $DEVICE_BASE"
hdc_send "$STAGING/../$TARNAME" "$DEVICE_BASE/$TARNAME"
hdc_cmd shell "cd $DEVICE_BASE && tar xzf $TARNAME && rm $TARNAME && chmod +x python3.12"

echo ""
echo "[6/6] Verifying..."
hdc_cmd shell "echo '--- Top level ---' && ls $DEVICE_BASE/ && echo '' && \
echo '--- Shared libs ---' && ls $DEVICE_BASE/lib/*.so 2>/dev/null | wc -l && \
echo '--- C ext modules ---' && find $DEVICE_BASE -name '*.cpython-312.so' 2>/dev/null | wc -l && \
echo '--- Renpy .py ---' && find $DEVICE_BASE/renpy -name '*.py' 2>/dev/null | wc -l"

rm -rf "$STAGING" "$STAGING/../$TARNAME"

echo ""
echo "=============================================="
echo "  Deployment complete!"
echo "=============================================="
echo ""
echo "Run test:"
echo "  hdc shell \"cd $DEVICE_BASE && LD_LIBRARY_PATH=$DEVICE_BASE/lib PYTHONHOME=$DEVICE_BASE/lib ./python3.12 test_harmony_device.py\""
echo ""
