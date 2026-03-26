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

# Target Python paths are provided by build_harmony.sh to avoid host Python
# (MSYS2 3.14) include/lib flags leaking into cross-link steps.
target_include = os.environ.get('HARMONY_PYTHON_INCLUDE', '')
target_libdir = os.environ.get('HARMONY_PYTHON_LIBDIR', '')
target_ldlibrary = os.environ.get('HARMONY_PYTHON_LDLIBRARY', 'libpython3.12.so')

# Override EXT_SUFFIX: .cp312-mingw_x86_64_msvcrt_gnu.pyd → .cpython-312.so
config_vars['EXT_SUFFIX'] = '.cpython-312.so'
config_vars['SOABI'] = 'cpython-312'
config_vars['SHLIB_SUFFIX'] = '.so'

# Override CCSHARED: empty on MinGW, but we need -fPIC for shared objects on Linux/OHOS
config_vars['CCSHARED'] = '-fPIC'

# Override CFLAGS: remove MinGW/x86 flags like -march=nocona, -D__USE_MINGW_ANSI_STDIO=1
# These would conflict with the aarch64/x86_64-ohos cross-compiler
# Inherit -march from the calling environment (build_harmony.sh sets it per-arch)
_march = ''
_env_cflags = os.environ.get('CFLAGS', '')
import re as _re
_m = _re.search(r'-march=\S+', _env_cflags)
if _m:
    _march = ' ' + _m.group(0)
config_vars['CFLAGS'] = f'-fno-strict-overflow -DNDEBUG -O2{_march}'
config_vars['BASECFLAGS'] = ''
config_vars['OPT'] = f'-DNDEBUG -O2{_march}'

# Override LDSHARED: will be further overridden by $LDSHARED env var
# but set a sane default in case env is not set
config_vars['LDSHARED'] = os.environ.get('LDSHARED', 'clang -shared')

# Force target include/lib directories for extension build and link.
if target_include:
    config_vars['INCLUDEPY'] = target_include
    config_vars['CONFINCLUDEPY'] = target_include
    config_vars['INCLUDEDIR'] = target_include

if target_libdir:
    config_vars['LIBDIR'] = target_libdir
    config_vars['LIBPL'] = target_libdir

config_vars['LDLIBRARY'] = target_ldlibrary
config_vars['LIBRARY'] = target_ldlibrary
config_vars['BLDLIBRARY'] = ''
config_vars['PY3LIBRARY'] = target_ldlibrary

# Drop host interpreter link fragments that can inject -lpython3.14.
config_vars['LIBS'] = ''
config_vars['SYSLIBS'] = ''
config_vars['SHLIBS'] = ''
config_vars['LINKFORSHARED'] = ''
config_vars['MODLIBS'] = ''

# Also patch distutils.sysconfig if setuptools bundles a copy
try:
    from distutils import sysconfig as _dsysconfig
    _dvars = _dsysconfig.get_config_vars()
    for k in ['EXT_SUFFIX', 'SOABI', 'SHLIB_SUFFIX', 'CCSHARED', 'CFLAGS',
              'BASECFLAGS', 'OPT', 'LDSHARED', 'INCLUDEPY', 'CONFINCLUDEPY',
              'INCLUDEDIR', 'LIBDIR', 'LIBPL', 'LDLIBRARY', 'LIBRARY',
              'BLDLIBRARY', 'PY3LIBRARY', 'LIBS', 'SYSLIBS', 'SHLIBS',
              'LINKFORSHARED', 'MODLIBS']:
        _dvars[k] = config_vars[k]
except Exception:
    pass

# Also try setuptools._distutils
try:
    from setuptools._distutils import sysconfig as _sdsysconfig
    _sdvars = _sdsysconfig.get_config_vars()
    for k in ['EXT_SUFFIX', 'SOABI', 'SHLIB_SUFFIX', 'CCSHARED', 'CFLAGS',
              'BASECFLAGS', 'OPT', 'LDSHARED', 'INCLUDEPY', 'CONFINCLUDEPY',
              'INCLUDEDIR', 'LIBDIR', 'LIBPL', 'LDLIBRARY', 'LIBRARY',
              'BLDLIBRARY', 'PY3LIBRARY', 'LIBS', 'SYSLIBS', 'SHLIBS',
              'LINKFORSHARED', 'MODLIBS']:
        _sdvars[k] = config_vars[k]
except Exception:
    pass

print(f"[harmony_setup] EXT_SUFFIX patched to: {config_vars['EXT_SUFFIX']}")
print(f"[harmony_setup] CFLAGS patched to: {config_vars['CFLAGS']}")
print(f"[harmony_setup] INCLUDEPY: {config_vars.get('INCLUDEPY', '')}")
print(f"[harmony_setup] LIBDIR: {config_vars.get('LIBDIR', '')}")
print(f"[harmony_setup] CC from env: {os.environ.get('CC', 'not set')}")
print(f"[harmony_setup] LDSHARED from env: {os.environ.get('LDSHARED', 'not set')}")

# Now execute the original setup.py
sys.argv[0] = 'setup.py'
exec(compile(open('setup.py').read(), 'setup.py', 'exec'))
