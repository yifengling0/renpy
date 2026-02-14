#!/bin/bash
set -e
STAGING=/tmp/renpy_staging
PY=/d/MyProject/MyApplication/Python-3.12.12
FF=/d/MyProject/MyApplication/third_party_ffmpeg
RP=/d/MyProject/MyApplication/vintage-pomelo/renpy
ARCH=x86_64

rm -rf "$STAGING"
mkdir -p "$STAGING/lib/python3.12" "$STAGING/renpy"

echo "=== Collecting libraries ==="
cp "$PY/install-harmony-$ARCH/lib/libpython3.12.so.1.0" "$STAGING/lib/"
cd "$STAGING/lib" && ln -sf libpython3.12.so.1.0 libpython3.12.so && cd /tmp

for f in libSDL2.so libSDL2_image-2.0.so libSDL2_mixer-2.0.so libSDL2_ttf-2.0.so \
         libz.so libpng16.so libpng.so libfreetype.so libharfbuzz.so libfribidi.so \
         libjpeg.so libjpeg.so.62 libjpeg.so.62.3.0 \
         libc++_shared.so libffi.so libffi.so.8 libffi.so.8.1.1 \
         libavif.so libogg.so libopus.so libopusfile.so libtiff.so libwebp.so; do
    [ -f "$PY/harmony_deps/$ARCH/lib/$f" ] && cp "$PY/harmony_deps/$ARCH/lib/$f" "$STAGING/lib/"
done

for f in libavcodec.so libavformat.so libavutil.so libswresample.so libswscale.so libavfilter.so; do
    REAL=$(readlink -f "$FF/install-harmony-$ARCH/lib/$f" 2>/dev/null)
    [ -f "$REAL" ] && cp "$REAL" "$STAGING/lib/$f"
done

echo "=== Collecting Python ==="
cp "$PY/install-harmony-$ARCH/bin/python3.12" "$STAGING/python3.12"
chmod +x "$STAGING/python3.12"

rsync -a --exclude='__pycache__' --exclude='test' --exclude='tests' \
    --exclude='idlelib' --exclude='tkinter' --exclude='turtledemo' \
    --exclude='ensurepip' --exclude='lib2to3' --exclude='*.pyc' \
    --exclude='distutils' --exclude='unittest' \
    "$PY/install-harmony-$ARCH/lib/python3.12/" "$STAGING/lib/python3.12/"

echo "=== Collecting Ren'Py ==="
cp -r "$RP/build/harmony-$ARCH/lib/"* "$STAGING/lib/"

cd "$RP"
find renpy -name '*.py' | while IFS= read -r f; do
    d="$STAGING/$(dirname "$f")"
    mkdir -p "$d"
    cp "$f" "$d/"
done

cp -rf "$STAGING/lib/renpy/"* "$STAGING/renpy/" 2>/dev/null || true
cp -f "$STAGING/lib/_renpy.cpython-312.so" "$STAGING/" 2>/dev/null || true
cp "$RP/test_harmony_device.py" "$STAGING/"
[ -d "$RP/the_question" ] && cp -r "$RP/the_question" "$STAGING/"

echo "=== Creating archive ==="
cd /tmp
rm -f renpy_deploy.tar.gz
tar czf renpy_deploy.tar.gz -C "$STAGING" .
ls -lh /tmp/renpy_deploy.tar.gz
echo "Libs: $(ls "$STAGING/lib/"*.so 2>/dev/null | wc -l)"
echo "C modules: $(find "$STAGING" -name '*.cpython-312.so' | wc -l)"
echo "Renpy .py: $(find "$STAGING/renpy" -name '*.py' | wc -l)"
echo "=== Done ==="
