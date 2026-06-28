# Ren'Py MSVC Build Script
param([switch]$SkipDeps, [switch]$Clean)
$ErrorActionPreference = "Stop"
$SCRIPT_DIR = $PSScriptRoot
$VINTAGE_POMELO = Split-Path -Parent $SCRIPT_DIR
$PROJECT_ROOT = Split-Path -Parent $VINTAGE_POMELO
$PYTHON_EXE = "$PROJECT_ROOT\Python-3.12.12\PCbuild\amd64\python.exe"
$SDL2_INC = "$VINTAGE_POMELO\RPGRunner\RPGRunner\SDL2\include"
$SDL2_LIB = "$VINTAGE_POMELO\RPGRunner\RPGRunner\SDL2\lib\x64"
$MINGW64 = "C:\msys64\mingw64"

Write-Host "`n=== Ren'Py MSVC Build ===`n" -ForegroundColor Cyan
if (-not (Test-Path $PYTHON_EXE)) {
    Write-Host "ERROR: Python not found" -ForegroundColor Red; exit 1
}
Write-Host "[OK] Python MSVC" -ForegroundColor Green
if (-not (Test-Path $SDL2_INC)) {
    Write-Host "ERROR: SDL2 not found" -ForegroundColor Red; exit 1
}
Write-Host "[OK] RPGRunner SDL2" -ForegroundColor Green

if (-not $SkipDeps) {
    Write-Host "`nInstalling Python packages..." -ForegroundColor Yellow
    & $PYTHON_EXE -m pip install --upgrade pip setuptools wheel cython
}

Write-Host "`nConfiguring environment..." -ForegroundColor Yellow
$env:PKG_CONFIG_PATH = "$MINGW64\lib\pkgconfig"
$env:INCLUDE = "$SDL2_INC;$MINGW64\include"
$env:LIB = "$SDL2_LIB;$MINGW64\lib"
$env:PATH = "$MINGW64\bin;$env:PATH"
$env:DISTUTILS_USE_SDK = "1"

if ($Clean) {
    Write-Host "`nCleaning build..." -ForegroundColor Yellow
    Push-Location $SCRIPT_DIR
    if (Test-Path "build") { Remove-Item -Recurse -Force "build" }
    Get-ChildItem -Recurse -Filter "*.pyd" | Remove-Item -Force -ErrorAction SilentlyContinue
    Pop-Location
}

Write-Host "`nBuilding Ren'Py extensions (10-20 min)...`n" -ForegroundColor Yellow
Push-Location $SCRIPT_DIR
try {
    & $PYTHON_EXE setup.py build_ext --inplace
    if ($LASTEXITCODE -ne 0) {
        Write-Host "`nERROR: Build failed`n" -ForegroundColor Red
        exit 1
    }
} finally {
    Pop-Location
}

Write-Host "`n=== Verifying Build ===" -ForegroundColor Cyan
$pydCount = (Get-ChildItem "$SCRIPT_DIR" -Recurse -Filter "*.pyd").Count
Write-Host "Total .pyd modules: $pydCount" -ForegroundColor Green
Write-Host "`n=== BUILD COMPLETE ===`n" -ForegroundColor Green
