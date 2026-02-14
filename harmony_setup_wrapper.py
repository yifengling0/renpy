#!/usr/bin/env python
"""
Cross-compilation wrapper for Ren'Py HarmonyOS build.
Patches sysconfig to override MSYS2/MinGW host-specific settings
so that cross-compiled extensions get correct ELF .so output.
"""
import os
import sys
import sysconfig

# Patch sysconfig config vars BEFORE any setuptools import
# This ensures all downstream code sees HarmonyOS-compatible values
config_vars = sysconfig.get_config_vars()

# Override EXT_SUFFIX: .cp312-mingw_x86_64_msvcrt_gnu.pyd → .cpython-312.so
config_vars['EXT_SUFFIX'] = '.cpython-312.so'
config_vars['SOABI'] = 'cpython-312'
config_vars['SHLIB_SUFFIX'] = '.so'

# Override CCSHARED: empty on MinGW, but we need -fPIC for shared objects on Linux/OHOS
config_vars['CCSHARED'] = '-fPIC'

# Override CFLAGS: remove MinGW/x86 flags like -march=nocona, -D__USE_MINGW_ANSI_STDIO=1
# These would conflict with the aarch64/x86_64-ohos cross-compiler
config_vars['CFLAGS'] = '-fno-strict-overflow -DNDEBUG -O2'
config_vars['BASECFLAGS'] = ''
config_vars['OPT'] = '-DNDEBUG -O2'

# Override LDSHARED: will be further overridden by $LDSHARED env var
# but set a sane default in case env is not set
config_vars['LDSHARED'] = os.environ.get('LDSHARED', 'clang -shared')

# Also patch distutils.sysconfig if setuptools bundles a copy
try:
    from distutils import sysconfig as _dsysconfig
    _dvars = _dsysconfig.get_config_vars()
    for k in ['EXT_SUFFIX', 'SOABI', 'SHLIB_SUFFIX', 'CCSHARED', 'CFLAGS',
              'BASECFLAGS', 'OPT', 'LDSHARED']:
        _dvars[k] = config_vars[k]
except Exception:
    pass

# Also try setuptools._distutils
try:
    from setuptools._distutils import sysconfig as _sdsysconfig
    _sdvars = _sdsysconfig.get_config_vars()
    for k in ['EXT_SUFFIX', 'SOABI', 'SHLIB_SUFFIX', 'CCSHARED', 'CFLAGS',
              'BASECFLAGS', 'OPT', 'LDSHARED']:
        _sdvars[k] = config_vars[k]
except Exception:
    pass

print(f"[harmony_setup] EXT_SUFFIX patched to: {config_vars['EXT_SUFFIX']}")
print(f"[harmony_setup] CFLAGS patched to: {config_vars['CFLAGS']}")
print(f"[harmony_setup] CC from env: {os.environ.get('CC', 'not set')}")
print(f"[harmony_setup] LDSHARED from env: {os.environ.get('LDSHARED', 'not set')}")

# Now execute the original setup.py
sys.argv[0] = 'setup.py'
exec(compile(open('setup.py').read(), 'setup.py', 'exec'))
