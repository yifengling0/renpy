#!/bin/bash
# Simple test to verify HarmonyOS cross-compilation works

set -e

echo "Testing HarmonyOS Cross-Compilation Environment"
echo "================================================"

# SDK paths
OHOS_SDK="/c/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native"
OHOS_NDK="$OHOS_SDK/llvm"
OHOS_SYSROOT="$OHOS_SDK/sysroot"

# Test C file
cat > test_harmony.c << 'EOF'
#include <stdio.h>

int main() {
    printf("Hello from HarmonyOS!\n");
    return 0;
}
EOF

echo ""
echo "Compiling test program for aarch64-linux-ohos..."

# Use clang directly with Windows path
"$OHOS_NDK/bin/clang.exe" \
    --target=aarch64-unknown-linux-ohos \
    --sysroot="$OHOS_SYSROOT" \
    -o test_harmony_aarch64 \
    test_harmony.c

if [ -f test_harmony_aarch64 ]; then
    file test_harmony_aarch64
    echo "✓ Cross-compilation successful!"
else
    echo "✗ Cross-compilation failed!"
    exit 1
fi

echo ""
echo "Creating simple shared library..."

# Test shared library
cat > test_lib.c << 'EOF'
int add(int a, int b) {
    return a + b;
}
EOF

"$OHOS_NDK/bin/clang.exe" \
    --target=aarch64-unknown-linux-ohos \
    --sysroot="$OHOS_SYSROOT" \
    -shared -fPIC \
    -o libtest_aarch64.so \
    test_lib.c

if [ -f libtest_aarch64.so ]; then
    file libtest_aarch64.so
    echo "✓ Shared library creation successful!"
    echo ""
    echo "HarmonyOS cross-compilation environment is working correctly!"
else
    echo "✗ Shared library creation failed!"
    exit 1
fi
