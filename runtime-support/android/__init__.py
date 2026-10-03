"""
HarmonyOS android compatibility module for Ren'Py.

Provides stub implementations of the android Python module APIs
that Ren'Py calls when renpy.android is True.  No native calls —
pure Python only, to guarantee stable startup.
"""

import os


# ---------------------------------------------------------------------------
# android.init — truthy attribute *and* callable
# ---------------------------------------------------------------------------
class _InitCallable:
    def __bool__(self):
        return True
    def __call__(self):
        pass

init = _InitCallable()


def wakelock(state):
    pass


def vibrate(duration):
    pass


def get_dpi():
    return 320


class _PackageManager:
    def hasSystemFeature(self, feature):
        return False


class _Activity:
    mActivity = None

    def armOnStop(self):
        pass

    def finishOnStop(self):
        pass

    def finishAndRemoveTask(self):
        pass

    def hidePresplash(self):
        pass

    def getPackageManager(self):
        return _PackageManager()

    def checkSelfPermission(self, perm):
        return 0

    @staticmethod
    def isChromebook():
        return False


_activity_instance = _Activity()
_activity_instance.mActivity = _activity_instance

activity = _activity_instance
