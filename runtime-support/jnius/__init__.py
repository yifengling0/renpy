"""
HarmonyOS jnius compatibility module for Ren'Py.

Provides stub implementations of pyjnius autoclass for the Java
classes Ren'Py actually uses.  No native calls — pure Python only.
"""

import locale
import os
import platform


# ===================================================================
# java.lang.System
# ===================================================================
class _System:
    @staticmethod
    def exit(code=0):
        os._exit(code)

    @staticmethod
    def getProperty(name, default=None):
        return os.environ.get(name, default)


# ===================================================================
# org.libsdl.app.SDLActivity / PythonSDLActivity
# ===================================================================
class _SDLActivity:
    mHasFocus = True

    class mActivity:
        @staticmethod
        def hidePresplash():
            pass

        @staticmethod
        def isChromebook():
            return False

        @staticmethod
        def checkSelfPermission(perm):
            return 0

        @staticmethod
        def getPackageManager():
            class _PM:
                @staticmethod
                def hasSystemFeature(feature):
                    return False
            return _PM()


_sdl_activity = _SDLActivity()


# ===================================================================
# android.os.Build
# ===================================================================
class _Build:
    MANUFACTURER = "HUAWEI"
    MODEL = platform.machine() or "HarmonyOS"
    BOARD = platform.machine() or "unknown"
    DEVICE = MODEL
    PRODUCT = "HarmonyOS"
    BRAND = MANUFACTURER

    class VERSION:
        SDK_INT = 12
        RELEASE = "5.0"


_build = _Build()


# ===================================================================
# java.util.Locale
# ===================================================================
class _LocaleDefault:
    def getLanguage(self):
        try:
            lang, _ = locale.getdefaultlocale()
            if lang:
                return lang.split("_")[0]
        except Exception:
            pass
        return "zh"

    def getCountry(self):
        try:
            lang, _ = locale.getdefaultlocale()
            if lang and "_" in lang:
                return lang.split("_")[1].split(".")[0]
        except Exception:
            pass
        return "CN"


class _Locale:
    @staticmethod
    def getDefault():
        return _LocaleDefault()


# ===================================================================
# android.speech.tts.TextToSpeech
# ===================================================================
class _TextToSpeech:
    QUEUE_FLUSH = 0
    QUEUE_ADD = 1

    def __init__(self, *args, **kwargs):
        pass

    def speak(self, text, queue_mode=0, params=None, utterance_id=None):
        pass

    def stop(self):
        pass

    def shutdown(self):
        pass

    def setLanguage(self, locale_obj):
        return 0

    def isLanguageAvailable(self, locale_obj):
        return -2


# ===================================================================
# autoclass
# ===================================================================
_CLASS_MAP = {
    "java.lang.System":                    _System,
    "org.libsdl.app.SDLActivity":          _sdl_activity,
    "org.renpy.android.PythonSDLActivity": _sdl_activity,
    "android.os.Build":                    _build,
    "java.util.Locale":                    _Locale,
    "android.speech.tts.TextToSpeech":     _TextToSpeech,
}


def autoclass(class_name):
    cls = _CLASS_MAP.get(class_name)
    if cls is not None:
        return cls
    return type(class_name.rsplit(".", 1)[-1], (), {})()
