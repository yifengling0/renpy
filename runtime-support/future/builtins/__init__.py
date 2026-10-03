# future.builtins shim for Python 3.12+
# On Python 3, builtins are already the correct versions.

from builtins import *  # noqa: F401,F403

# Explicit re-exports for common usage
from builtins import chr, int, str, bytes, range, object, zip, map, filter, open, super, hex, oct, input, round, max, min  # noqa: F401
