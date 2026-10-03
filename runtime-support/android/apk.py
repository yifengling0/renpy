"""
HarmonyOS android.apk module for Ren'Py.

On Android, this module reads game assets directly from the APK file
(a ZIP archive) without extracting them to disk.  HarmonyOS uses HAP
packaging which has a different structure — game assets are extracted
to the sandbox filesystem at install time.

Returning an empty listing from APK.list() causes Ren'Py's loader to
fall through to standard filesystem access, which is the correct
behaviour on HarmonyOS.
"""


class APK:
    """
    HarmonyOS equivalent of the Android APK asset accessor.

    On HarmonyOS, all game resources reside on the filesystem under the
    application sandbox.  This class intentionally returns empty results
    so that Ren'Py uses its filesystem-based loader instead.
    """

    def __init__(self, prefix="", apk=None):
        self.prefix = prefix
        self.apk = apk

    def list(self):
        """No APK assets — game files are on the HarmonyOS filesystem."""
        return []

    def open(self, fn, mode='rb'):
        """Assets are accessed via the filesystem, not APK."""
        raise FileNotFoundError(
            f"APK resource not available on HarmonyOS: {fn}")

