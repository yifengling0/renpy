#!/usr/bin/env python
"""
HarmonyOS cross-compiler wrapper for Ren'Py build.

This script acts as a compiler/linker substitute that:
1. Converts MSYS2-style paths (/d/MyProject/...) to Windows paths (D:/MyProject/...)
2. Calls HarmonyOS NDK's clang/clang++ with cross-compilation flags
3. Can be invoked by Python's distutils/setuptools subprocess

Usage:
    python wrapper.py cc     [args...]    # C compiler
    python wrapper.py cxx    [args...]    # C++ compiler
    python wrapper.py ldcc   [args...]    # Shared linker (C)
    python wrapper.py ldcxx  [args...]    # Shared linker (C++)

Configuration is read from environment variables:
    OHOS_CLANG     - path to clang.exe
    OHOS_CLANGXX   - path to clang++.exe
    OHOS_TARGET    - target triple (e.g. aarch64-unknown-linux-ohos)
    OHOS_SYSROOT   - sysroot path
"""

import sys
import os
import re
import subprocess


def msys2_to_win(path):
    """Convert MSYS2-style path /d/foo to Windows path D:/foo"""
    return re.sub(r'^/([a-zA-Z])/', lambda m: m.group(1).upper() + ':/', path)


def convert_arg(arg):
    """Convert MSYS2-style paths in a compiler/linker argument to Windows paths."""
    # -I/d/path, -L/d/path, -isystem /d/path
    for prefix in ('-I', '-L', '-isystem'):
        if arg.startswith(prefix):
            rest = arg[len(prefix):]
            if rest.startswith('/') and len(rest) > 2 and rest[2] == '/':
                return prefix + msys2_to_win(rest)
            return arg

    # --sysroot=/d/path
    if arg.startswith('--sysroot=/'):
        return '--sysroot=' + msys2_to_win(arg[len('--sysroot='):])

    # -o /d/path/out.o  (as single token -o/d/...)
    if arg.startswith('-o/'):
        return '-o' + msys2_to_win(arg[2:])

    # Bare source/object file paths: /d/MyProject/file.c
    if arg.startswith('/') and len(arg) > 2 and arg[2] == '/' and not arg.startswith('//'):
        return msys2_to_win(arg)

    return arg


def main():
    if len(sys.argv) < 2:
        print("Usage: python wrapper.py <cc|cxx|ldcc|ldcxx> [args...]", file=sys.stderr)
        sys.exit(1)

    mode = sys.argv[1]
    args = sys.argv[2:]

    clang = os.environ.get('OHOS_CLANG', '')
    clangxx = os.environ.get('OHOS_CLANGXX', '')
    target = os.environ.get('OHOS_TARGET', 'aarch64-unknown-linux-ohos')
    sysroot = os.environ.get('OHOS_SYSROOT', '')

    # Pick the compiler executable
    if mode in ('cc', 'ldcc'):
        compiler = clang
    elif mode in ('cxx', 'ldcxx'):
        compiler = clangxx
    else:
        print(f"Unknown mode: {mode}", file=sys.stderr)
        sys.exit(1)

    if not compiler or not os.path.exists(compiler):
        print(f"Compiler not found: {compiler}", file=sys.stderr)
        sys.exit(1)

    # Fixed cross-compilation flags
    fixed_flags = [
        f'--target={target}',
        f'--sysroot={sysroot}',
        '--gcc-toolchain=/dev/null',
        '-fuse-ld=lld',
        '-fPIC',
    ]

    # For linker mode, add -shared
    if mode in ('ldcc', 'ldcxx'):
        fixed_flags.append('-shared')

    # Convert all argument paths from MSYS2 to Windows format
    converted_args = [convert_arg(a) for a in args]

    # Build final command
    cmd = [compiler] + fixed_flags + converted_args

    # Execute
    result = subprocess.call(cmd)
    sys.exit(result)


if __name__ == '__main__':
    main()
