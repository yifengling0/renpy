#!/bin/bash
# Wrapper script for HarmonyOS clang++ that handles paths with spaces

OHOS_CLANGXX="/c/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/native/llvm/bin/clang++.exe"

# Execute clang++ with all arguments
exec "$OHOS_CLANGXX" "$@"
