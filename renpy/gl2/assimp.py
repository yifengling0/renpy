# Stub module for renpy.gl2.assimp
# The real module is a Cython extension (assimp.pyx) that wraps the Assimp C++
# library for GLTF/3D model loading. Since Assimp is not available on HarmonyOS,
# this stub provides the expected interface as no-ops.

import threading


# Thread lock used by the loader system
loader = None
loader_lock = threading.Lock()


def free_memory():
    """Free any cached 3D model memory. No-op on HarmonyOS."""
    pass


def preload():
    """Preload 3D model assets. No-op on HarmonyOS."""
    pass


def finish_predict():
    """Finish prediction for 3D model loading. No-op on HarmonyOS."""
    pass


class GLTFModel:
    """
    Stub for the GLTF 3D model displayable.
    On platforms without Assimp, this is a no-op placeholder.
    """

    def __init__(self, *args, **kwargs):
        pass

    def __repr__(self):
        return "<GLTFModel stub (Assimp not available)>"
