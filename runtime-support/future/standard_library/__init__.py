# future.standard_library shim for Python 3.12+
# On Python 3, standard library names are already correct.

def install_aliases():
    """No-op on Python 3 - aliases are already the standard names."""
    pass


def hooks():
    """No-op context manager."""
    import contextlib
    return contextlib.nullcontext()
