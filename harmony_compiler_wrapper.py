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


def posix_to_win(path):
    """Convert /d/foo or /mnt/d/foo to Windows path D:/foo."""
    if path.startswith('/mnt/') and len(path) > 6 and path[5].isalpha() and path[6] == '/':
        return f"{path[5].upper()}:/{path[7:]}"

    return re.sub(r'^/([a-zA-Z])/', lambda m: m.group(1).upper() + ':/', path)


def convert_arg(arg):
    """Convert MSYS2-style paths in a compiler/linker argument to Windows paths."""
    # -I/d/path, -L/d/path, -isystem /d/path
    for prefix in ('-I', '-L', '-isystem'):
        if arg.startswith(prefix):
            rest = arg[len(prefix):]
            if rest.startswith('/mnt/') or (rest.startswith('/') and len(rest) > 2 and rest[2] == '/'):
                return prefix + posix_to_win(rest)
            return arg

    # --sysroot=/d/path
    if arg.startswith('--sysroot=/'):
        return '--sysroot=' + posix_to_win(arg[len('--sysroot='):])

    # -o /d/path/out.o  (as single token -o/d/...)
    if arg.startswith('-o/'):
        return '-o' + posix_to_win(arg[2:])

    # Bare source/object file paths: /d/MyProject/file.c
    if (arg.startswith('/mnt/') or (arg.startswith('/') and len(arg) > 2 and arg[2] == '/')) and not arg.startswith('//'):
        return posix_to_win(arg)

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
        '-fPIC',
    ]

    # Only add --gcc-toolchain and -fuse-ld for compile mode
    if mode in ('cc', 'cxx'):
        fixed_flags.extend(['--gcc-toolchain=/dev/null', '-fuse-ld=lld'])

    # For linker mode, add -shared
    if mode in ('ldcc', 'ldcxx'):
        fixed_flags.append('-shared')

    # Convert all argument paths from MSYS2 to Windows format.
    # Also drop host Python auto-link flags (e.g. -lpython3.14) injected by
    # setuptools on MSYS2, keeping the target runtime library only.
    _ldlibrary = os.environ.get('HARMONY_PYTHON_LDLIBRARY', 'libpython3.12.so')
    _target_lib = _ldlibrary
    if _target_lib.startswith('lib'):
        _target_lib = _target_lib[3:]
    _target_lib = '.'.join(_target_lib.split('.')[:2])  # python3.9, python3.12
    _target_link = '-l' + _target_lib

    converted_args = []
    for a in args:
        if a.startswith('-lpython3.') and a != _target_link:
            continue
        converted_args.append(convert_arg(a))

    # Build final command
    cmd = [compiler] + fixed_flags + converted_args

    # Execute — capture stderr so MSYS2 subprocess boundary doesn't lose it
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    out, _ = p.communicate()
    if out:
        sys.stdout.buffer.write(out)
        sys.stdout.flush()
    sys.exit(p.returncode)


if __name__ == '__main__':
    main()
