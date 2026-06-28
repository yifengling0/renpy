#!/usr/bin/env python
"""
HarmonyOS cross-compilation wrapper for Ren'Py 8.3 module build (Python 3.9 target).
Based on harmony_setup_wrapper.py but wraps module/setup.py instead of setup.py.
"""
import os
import sys
import sysconfig

config_vars = sysconfig.get_config_vars()

target_include = os.environ.get('HARMONY_PYTHON_INCLUDE', '')
target_libdir = os.environ.get('HARMONY_PYTHON_LIBDIR', '')
target_ldlibrary = os.environ.get('HARMONY_PYTHON_LDLIBRARY', 'libpython3.9.so')

# Derive Python version from LDLIBRARY
_pyver = target_ldlibrary
if _pyver.startswith('libpython'):
    _pyver = _pyver[len('libpython'):]
_pyver = '.'.join(_pyver.split('.')[:2])
_pyver_short = _pyver.replace('.', '')
config_vars['EXT_SUFFIX'] = f'.cpython-{_pyver_short}.so'
config_vars['SOABI'] = f'cpython-{_pyver_short}'
config_vars['SHLIB_SUFFIX'] = '.so'
config_vars['CCSHARED'] = '-fPIC'

_march = ''
_env_cflags = os.environ.get('CFLAGS', '')
import re as _re
_m = _re.search(r'-march=\S+', _env_cflags)
if _m:
    _march = ' ' + _m.group(0)
config_vars['CFLAGS'] = f'-fno-strict-overflow -DNDEBUG -O2{_march}'
config_vars['BASECFLAGS'] = ''
config_vars['OPT'] = f'-DNDEBUG -O2{_march}'
config_vars['LDSHARED'] = os.environ.get('LDSHARED', 'clang -shared')

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
config_vars['LIBS'] = ''
config_vars['SYSLIBS'] = ''
config_vars['SHLIBS'] = ''
config_vars['LINKFORSHARED'] = ''
config_vars['MODLIBS'] = ''

# Patch distutils and setuptools
for _mod_name in ('distutils.sysconfig', 'setuptools._distutils.sysconfig'):
    try:
        _mod = __import__(_mod_name, fromlist=['get_config_vars'])
        _dvars = _mod.get_config_vars()
        for k in ['EXT_SUFFIX', 'SOABI', 'SHLIB_SUFFIX', 'CCSHARED', 'CFLAGS',
                  'BASECFLAGS', 'OPT', 'LDSHARED', 'INCLUDEPY', 'CONFINCLUDEPY',
                  'INCLUDEDIR', 'LIBDIR', 'LIBPL', 'LDLIBRARY', 'LIBRARY',
                  'BLDLIBRARY', 'PY3LIBRARY', 'LIBS', 'SYSLIBS', 'SHLIBS',
                  'LINKFORSHARED', 'MODLIBS']:
            _dvars[k] = config_vars[k]
    except Exception:
        pass

cc = os.environ.get('CC', '')
cxx = os.environ.get('CXX', '')
ldshared = os.environ.get('LDSHARED', '')
if cc:
    os.environ['CC'] = cc
    config_vars['CC'] = cc
if cxx:
    os.environ['CXX'] = cxx
if ldshared:
    os.environ['LDSHARED'] = ldshared
    config_vars['LDSHARED'] = ldshared

# Patch build_ext.get_libraries
_host_python_lib = f"python{sys.version_info.major}.{sys.version_info.minor}"
_tmp = target_ldlibrary
if _tmp.startswith('lib'):
    _tmp = _tmp[3:]
_target_python_lib = '.'.join(_tmp.split('.')[:2])

def _patch_build_ext():
    try:
        from distutils.command.build_ext import build_ext as _be
    except ImportError:
        try:
            from setuptools._distutils.command.build_ext import build_ext as _be
        except ImportError:
            return
    _orig = _be.get_libraries
    def _patched(self, ext):
        libs = _orig(self, ext)
        return [_target_python_lib if l == _host_python_lib else l for l in libs]
    _be.get_libraries = _patched

_patch_build_ext()

print(f"[harmony_module] EXT_SUFFIX={config_vars['EXT_SUFFIX']}")
print(f"[harmony_module] INCLUDEPY={config_vars.get('INCLUDEPY', '')}")

# Check deps install resolution
_deps_install = os.environ.get('RENPY_DEPS_INSTALL', '/usr')
if '::' in _deps_install:
    _parts = _deps_install.split('::')
else:
    _parts = _deps_install.split(os.pathsep)
for _p in _parts:
    _so = os.path.join(_p, 'lib', 'libSDL2.so')
    print(f"[harmony_module]   {_so} exists={os.path.exists(_so)}")

# Execute module/setup.py — must be in module/ directory
_module_dir = os.path.join(os.path.dirname(__file__), 'module')
os.chdir(_module_dir)
sys.path.insert(0, _module_dir)
sys.argv[0] = 'setup.py'
with open(sys.argv[0], encoding='utf-8') as _f:
    _code = compile(_f.read(), sys.argv[0], 'exec')
exec(_code)
