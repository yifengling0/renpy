@echo off
REM Ren'Py HarmonyOS Build Script (Windows)
REM Build Ren'Py for HarmonyOS using MSYS2 bash

echo =====================================================
echo Ren'Py HarmonyOS Build Script
echo =====================================================
echo.

REM Target architecture (aarch64 or x86_64)
set ARCH=%1
if "%ARCH%"=="" set ARCH=aarch64

echo Target Architecture: %ARCH%
echo.

REM Check if MSYS2 is installed
if not exist "C:\msys64\usr\bin\bash.exe" (
    echo ERROR: MSYS2 not found at C:\msys64
    echo Please install MSYS2 first.
    exit /b 1
)

REM Launch build script in MSYS2
echo Launching MSYS2 bash to run build_harmony.sh...
echo.

C:\msys64\usr\bin\bash.exe -lc "cd '%CD:\=/%' && ./build_harmony.sh %ARCH%"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Build failed!
    exit /b %ERRORLEVEL%
)

echo.
echo Build completed successfully!
echo.
pause
