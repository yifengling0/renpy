# future.utils shim for Python 3.12+
# Provides the subset of future.utils API used by Ren'Py 7.x

import sys

PY2 = False
PY3 = True
PY26 = False
PY27 = False
PYPY = hasattr(sys, 'pypy_version_info')

string_types = (str,)
integer_types = (int,)
text_type = str
binary_type = bytes
unichr = chr


def bchr(i):
    """Return a byte string of one character with ordinal i."""
    return bytes([i])


def bord(c):
    """Return the ordinal of a single byte."""
    if isinstance(c, int):
        return c
    return ord(c)


def tobytes(s):
    """Convert to bytes."""
    if isinstance(s, bytes):
        return s
    if isinstance(s, str):
        return s.encode('latin-1')
    return bytes(s)


def native_str(s, encoding='utf-8'):
    """Convert to native str type."""
    if isinstance(s, str):
        return s
    if isinstance(s, bytes):
        return s.decode(encoding)
    return str(s)


def exec_(_code_, _globs_=None, _locs_=None):
    """Execute code in the given namespaces."""
    if _globs_ is None:
        frame = sys._getframe(1)
        _globs_ = frame.f_globals
        if _locs_ is None:
            _locs_ = frame.f_locals
    elif _locs_ is None:
        _locs_ = _globs_
    exec(_code_, _globs_, _locs_)


def raise_with_traceback(exc, traceback=Ellipsis):
    if traceback is not Ellipsis:
        exc.__traceback__ = traceback
    raise exc


def with_metaclass(meta, *bases):
    """Create a base class with a metaclass."""
    class metaclass(type):
        def __new__(cls, name, this_bases, d):
            if not d.pop('__metaclass_helper__', False):
                return super().__new__(cls, name, this_bases, d)
            return meta.__new__(meta, name, bases, d)
    return type.__new__(metaclass, 'temporary_class', (), {'__metaclass_helper__': True})


def iteritems(obj, **kw):
    return iter(obj.items(**kw))


def itervalues(obj, **kw):
    return iter(obj.values(**kw))


def iterkeys(obj, **kw):
    return iter(obj.keys(**kw))


def listvalues(obj):
    return list(obj.values())


def listitems(obj):
    return list(obj.items())


def listkeys(obj):
    return list(obj.keys())


def istext(obj):
    return isinstance(obj, str)


def isbytes(obj):
    return isinstance(obj, bytes)


def isidentifier(s, dotted=False):
    return s.isidentifier()


def ensure_new_type(obj):
    return obj


def native(obj):
    if isinstance(obj, str):
        return str(obj)
    return obj


def raise_(exc, traceback=None):
    """Raise an exception with optional traceback (future.utils API)."""
    if traceback is not None:
        raise exc.with_traceback(traceback)
    raise exc


def reraise(tp, value=None, tb=None):
    """Reraise an exception (future.utils API, six.reraise semantics)."""
    import sys
    if value is None:
        value = tp()
    if value.__traceback__ is not None and tb is not None:
        # keep the deeper traceback if already attached
        pass
    if tb is not None:
        raise value.with_traceback(tb)
    raise value
