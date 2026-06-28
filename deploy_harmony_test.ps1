<#
.SYNOPSIS
    PowerShell script to deploy and test Ren'Py on HarmonyOS emulator
.DESCRIPTION
    Pushes the pre-built staging tar.gz to emulator via hdc and runs tests
#>

$ErrorActionPreference = "Stop"

$HDC = "C:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\toolchains\hdc.exe"
$DEPLOY_TAR = "C:\msys64\tmp\renpy_deploy.tar.gz"
$DEVICE_DIR = "/data/local/tmp/renpy_test"
$ENV_CMD = "export LD_LIBRARY_PATH=/data/local/tmp/renpy_test/lib; export PYTHONHOME=/data/local/tmp/renpy_test"

# ===== Step 0: Check connection =====
Write-Host "`n===== Step 0: Check device =====" -ForegroundColor Magenta
$targets = & $HDC list targets 2>&1
Write-Host "  Targets: $targets"
if (-not $targets -or "$targets" -match "Empty") {
    Write-Host "ERROR: No device connected!" -ForegroundColor Red
    exit 1
}
$arch = (& $HDC shell "uname -m" 2>&1).Trim()
Write-Host "  Arch: $arch"

# ===== Step 1: Check tar.gz =====
Write-Host "`n===== Step 1: Check deploy package =====" -ForegroundColor Magenta
if (-not (Test-Path $DEPLOY_TAR)) {
    Write-Host "ERROR: $DEPLOY_TAR not found!" -ForegroundColor Red
    exit 1
}
$sizeMB = [math]::Round((Get-Item $DEPLOY_TAR).Length / 1MB, 1)
Write-Host "  Package: $DEPLOY_TAR ($sizeMB MB)"

# ===== Step 2: Prepare device dir =====
Write-Host "`n===== Step 2: Prepare device dir =====" -ForegroundColor Magenta
& $HDC shell "rm -rf $DEVICE_DIR" 2>&1 | Write-Host
& $HDC shell "mkdir -p $DEVICE_DIR" 2>&1 | Write-Host

# ===== Step 3: Push tar.gz =====
Write-Host "`n===== Step 3: Push package ($sizeMB MB) =====" -ForegroundColor Magenta
& $HDC file send $DEPLOY_TAR "$DEVICE_DIR/renpy_deploy.tar.gz" 2>&1 | ForEach-Object { Write-Host "  $_" }
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: hdc file send failed!" -ForegroundColor Red
    exit 1
}

# Verify
& $HDC shell "ls -l $DEVICE_DIR/renpy_deploy.tar.gz" 2>&1 | ForEach-Object { Write-Host "  $_" }

# ===== Step 4: Extract =====
Write-Host "`n===== Step 4: Extract on device =====" -ForegroundColor Magenta
& $HDC shell "cd $DEVICE_DIR; tar xzf renpy_deploy.tar.gz" 2>&1 | ForEach-Object { Write-Host "  $_" }
& $HDC shell "rm -f $DEVICE_DIR/renpy_deploy.tar.gz" 2>&1 | Out-Null

Write-Host "  Contents:"
& $HDC shell "ls $DEVICE_DIR/" 2>&1 | ForEach-Object { Write-Host "    $_" }
$soCount = (& $HDC shell "ls $DEVICE_DIR/lib/*.so 2>/dev/null | wc -l" 2>&1).Trim()
$cextCount = (& $HDC shell "find $DEVICE_DIR -name *.cpython-312.so | wc -l" 2>&1).Trim()
Write-Host "  Shared libs: $soCount"
Write-Host "  C extensions: $cextCount"

# ===== Step 5: Permissions =====
Write-Host "`n===== Step 5: Set permissions =====" -ForegroundColor Magenta
& $HDC shell "chmod +x $DEVICE_DIR/python3.12" 2>&1 | Out-Null
& $HDC shell "chmod 755 $DEVICE_DIR/lib/*.so 2>/dev/null" 2>&1 | Out-Null

# ===== Step 6: Verify Python =====
Write-Host "`n===== Step 6: Verify Python =====" -ForegroundColor Magenta
$pyVer = & $HDC shell "cd $DEVICE_DIR; $ENV_CMD; ./python3.12 --version" 2>&1
Write-Host "  $pyVer"

# ===== Step 7: Write and push quick test =====
Write-Host "`n===== Step 7: Quick import test =====" -ForegroundColor Magenta

$testCode = @(
    "import sys, os"
    "sys.path.insert(0, '/data/local/tmp/renpy_test')"
    "sys.path.insert(0, '/data/local/tmp/renpy_test/lib')"
    "print('Python', sys.version)"
    "print('Platform:', sys.platform)"
    ""
    "# Test _renpy"
    "try:"
    "    import _renpy"
    "    print('OK: _renpy')"
    "except Exception as e:"
    "    print('FAIL: _renpy -', e)"
    ""
    "# Test ctypes libs"
    "import ctypes"
    "for lib in ['libSDL2.so','libpython3.12.so','libz.so','libpng16.so','libfreetype.so','libjpeg.so','libharfbuzz.so','libfribidi.so']:"
    "    path = '/data/local/tmp/renpy_test/lib/' + lib"
    "    try:"
    "        ctypes.CDLL(path)"
    "        print('OK:', lib)"
    "    except Exception as e:"
    "        print('FAIL:', lib, '-', e)"
)
$testContent = $testCode -join "`n"
$tempFile = Join-Path $env:TEMP "quick_test.py"
[System.IO.File]::WriteAllText($tempFile, $testContent, [System.Text.UTF8Encoding]::new($false))

& $HDC file send $tempFile "$DEVICE_DIR/quick_test.py" 2>&1 | ForEach-Object { Write-Host "  $_" }
Remove-Item $tempFile -ErrorAction SilentlyContinue

Write-Host ""
& $HDC shell "cd $DEVICE_DIR; $ENV_CMD; ./python3.12 quick_test.py" 2>&1 | ForEach-Object { Write-Host "  $_" }

# ===== Step 8: Full test =====
Write-Host "`n===== Step 8: Full Ren'Py module test =====" -ForegroundColor Magenta

$hasTest = (& $HDC shell "test -f $DEVICE_DIR/test_harmony_device.py; echo RET=`$?" 2>&1) -join ""
if ($hasTest -match "RET=0") {
    Write-Host "  test_harmony_device.py found on device, running..."
} else {
    Write-Host "  Pushing test_harmony_device.py..."
    $localTest = "d:\MyProject\MyApplication\vintage-pomelo\renpy\test_harmony_device.py"
    if (Test-Path $localTest) {
        & $HDC file send $localTest "$DEVICE_DIR/test_harmony_device.py" 2>&1 | ForEach-Object { Write-Host "  $_" }
    } else {
        Write-Host "  WARNING: test_harmony_device.py not found locally" -ForegroundColor Yellow
    }
}

& $HDC shell "cd $DEVICE_DIR; $ENV_CMD; ./python3.12 test_harmony_device.py" 2>&1 | ForEach-Object { Write-Host "  $_" }

# ===== Done =====
Write-Host "`n===== Deploy and test complete =====" -ForegroundColor Magenta
Write-Host "Device dir: $DEVICE_DIR"
