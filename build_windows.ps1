# =========================================================
# Ren'Py Windows Build Script
# Target: Windows x64 with MSYS2 + MinGW toolchain
# Date: 2026-02-10
# =========================================================

param(
    [switch]$SkipMSYS2Check = $false,
    [switch]$SkipDependencies = $false,
    [switch]$CleanBuild = $false,
    [string]$PythonPath = ""
)

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

# =========================================================
# Configuration
# =========================================================

$SCRIPT_DIR = $PSScriptRoot
$PROJECT_ROOT = Split-Path -Parent $SCRIPT_DIR
$RENPY_DIR = $SCRIPT_DIR
$PYTHON_312_DIR = Join-Path $PROJECT_ROOT "Python-3.12.12"

# MSYS2 默认安装路径
$MSYS2_ROOT = "C:\msys64"
$MINGW64_BIN = Join-Path $MSYS2_ROOT "mingw64\bin"
$MSYS2_BIN = Join-Path $MSYS2_ROOT "usr\bin"

# Required packages for MSYS2
$MSYS2_PACKAGES = @(
    "mingw-w64-x86_64-gcc"
    "mingw-w64-x86_64-cython"
    "mingw-w64-x86_64-SDL2"
    "mingw-w64-x86_64-SDL2_image"
    "mingw-w64-x86_64-SDL2_mixer"
    "mingw-w64-x86_64-SDL2_ttf"
    "mingw-w64-x86_64-ffmpeg"
    "mingw-w64-x86_64-freetype"
    "mingw-w64-x86_64-harfbuzz"
    "mingw-w64-x86_64-fribidi"
    "mingw-w64-x86_64-assimp"
    "mingw-w64-x86_64-openssl"
    "mingw-w64-x86_64-libjpeg-turbo"
    "mingw-w64-x86_64-libpng"
    "mingw-w64-x86_64-libwebp"
    "mingw-w64-x86_64-pkgconf"
    "mingw-w64-x86_64-python"
    "mingw-w64-x86_64-python-pip"
)

# Python packages needed
$PYTHON_PACKAGES = @(
    "cython>=3.0.0"
    "setuptools"
    "wheel"
    "pkgconfig"
)

# =========================================================
# Helper Functions
# =========================================================

function Write-Banner {
    param([string]$Message)
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host " $Message" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "[✓] $Message" -ForegroundColor Green
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "[✗] $Message" -ForegroundColor Red
}

function Write-Info {
    param([string]$Message)
    Write-Host "[i] $Message" -ForegroundColor Yellow
}

function Test-CommandExists {
    param([string]$Command)
    try {
        if (Get-Command $Command -ErrorAction SilentlyContinue) {
            return $true
        }
        return $false
    } catch {
        return $false
    }
}

# =========================================================
# Step 1: Check MSYS2 Installation
# =========================================================

function Test-MSYS2Installation {
    Write-Banner "检查 MSYS2 安装状态"
    
    if (-not (Test-Path $MSYS2_ROOT)) {
        Write-Error-Custom "MSYS2 未安装在 $MSYS2_ROOT"
        Write-Info "请从以下地址下载并安装 MSYS2:"
        Write-Info "https://www.msys2.org/"
        Write-Info "安装后运行: pacman -Syu"
        return $false
    }
    
    Write-Success "MSYS2 已安装: $MSYS2_ROOT"
    
    # Check if pacman is accessible
    $pacman = Join-Path $MSYS2_BIN "pacman.exe"
    if (-not (Test-Path $pacman)) {
        Write-Error-Custom "pacman 未找到: $pacman"
        return $false
    }
    
    Write-Success "pacman 可用"
    return $true
}

# =========================================================
# Step 2: Install Dependencies via MSYS2
# =========================================================

function Install-MSYS2Dependencies {
    Write-Banner "安装 MSYS2 依赖包"
    
    $pacman = Join-Path $MSYS2_BIN "pacman.exe"
    
    Write-Info "将安装以下包:"
    $MSYS2_PACKAGES | ForEach-Object { Write-Host "  - $_" }
    
    Write-Info "开始安装 (这可能需要几分钟)..."
    
    # Use --needed to skip already installed packages
    $packageList = $MSYS2_PACKAGES -join " "
    
    try {
        # Run pacman in MSYS2 environment
        & $pacman -S --needed --noconfirm $MSYS2_PACKAGES
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "所有依赖包安装完成"
            return $true
        } else {
            Write-Error-Custom "pacman 返回错误代码: $LASTEXITCODE"
            return $false
        }
    } catch {
        Write-Error-Custom "安装依赖时出错: $_"
        return $false
    }
}

# =========================================================
# Step 3: Setup Python Environment
# =========================================================

function Setup-PythonEnvironment {
    Write-Banner "配置 Python 环境"
    
    # Find Python 3.12
    $pythonExe = ""
    
    if ($PythonPath -ne "") {
        $pythonExe = $PythonPath
        Write-Info "使用指定的 Python: $pythonExe"
    } else {
        # Try MSYS2 Python first
        $mingwPython = Join-Path $MINGW64_BIN "python.exe"
        if (Test-Path $mingwPython) {
            $pythonExe = $mingwPython
            Write-Info "使用 MSYS2 Python: $pythonExe"
        } else {
            # Try system Python
            if (Test-CommandExists "python") {
                $pythonExe = "python"
                Write-Info "使用系统 Python: python"
            } else {
                Write-Error-Custom "未找到 Python 3.12"
                Write-Info "请安装 Python 3.12 或使用 -PythonPath 参数指定路径"
                return $null
            }
        }
    }
    
    # Verify Python version
    try {
        $versionOutput = & $pythonExe --version 2>&1
        Write-Success "Python 版本: $versionOutput"
        
        if ($versionOutput -notmatch "3\.12") {
            Write-Error-Custom "需要 Python 3.12.x"
            return $null
        }
    } catch {
        Write-Error-Custom "无法运行 Python: $_"
        return $null
    }
    
    return $pythonExe
}

function Install-PythonPackages {
    param([string]$PythonExe)
    
    Write-Banner "安装 Python 依赖包"
    
    foreach ($package in $PYTHON_PACKAGES) {
        Write-Info "安装 $package..."
        try {
            & $PythonExe -m pip install $package --upgrade
            if ($LASTEXITCODE -eq 0) {
                Write-Success "$package 安装成功"
            } else {
                Write-Error-Custom "$package 安装失败"
                return $false
            }
        } catch {
            Write-Error-Custom "安装 $package 时出错: $_"
            return $false
        }
    }
    
    return $true
}

# =========================================================
# Step 4: Build Ren'Py Modules
# =========================================================

function Build-RenpyModules {
    param([string]$PythonExe)
    
    Write-Banner "编译 Ren'Py Cython 模块"
    
    # Change to renpy directory
    Push-Location $RENPY_DIR
    
    try {
        # Clean previous build if requested
        if ($CleanBuild) {
            Write-Info "清理之前的构建..."
            if (Test-Path "build") {
                Remove-Item -Recurse -Force "build"
                Write-Success "build/ 已清理"
            }
            
            # Remove .pyd files
            Get-ChildItem -Recurse -Filter "*.pyd" | Remove-Item -Force
            Write-Success "已删除旧的 .pyd 文件"
        }
        
        # Setup environment for pkg-config
        $env:PKG_CONFIG_PATH = Join-Path $MINGW64_BIN "..\lib\pkgconfig"
        $env:PATH = "$MINGW64_BIN;$MSYS2_BIN;$env:PATH"
        
        Write-Info "环境变量:"
        Write-Host "  PKG_CONFIG_PATH = $env:PKG_CONFIG_PATH"
        Write-Host "  PATH (前缀) = $MINGW64_BIN"
        
        # Build using setup.py
        Write-Info "开始编译..."
        Write-Host ""
        
        & $PythonExe setup.py build_ext --inplace --compiler=mingw32
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Ren'Py 模块编译成功!"
            return $true
        } else {
            Write-Error-Custom "编译失败，退出代码: $LASTEXITCODE"
            return $false
        }
    } catch {
        Write-Error-Custom "编译过程出错: $_"
        return $false
    } finally {
        Pop-Location
    }
}

# =========================================================
# Step 5: Verify Build
# =========================================================

function Test-RenpyBuild {
    param([string]$PythonExe)
    
    Write-Banner "验证构建结果"
    
    Push-Location $RENPY_DIR
    
    try {
        # Test core module
        Write-Info "测试 _renpy 核心模块..."
        $result = & $PythonExe -c "import _renpy; print('_renpy OK')" 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Success $result
        } else {
            Write-Error-Custom "_renpy 模块导入失败"
            Write-Host $result
            return $false
        }
        
        # Test pygame compatibility layer
        Write-Info "测试 pygame 兼容层..."
        $result = & $PythonExe -c "from renpy.pygame_sdl2 import display; print('pygame_sdl2 OK')" 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Success $result
        } else {
            Write-Error-Custom "pygame_sdl2 模块导入失败"
            Write-Host $result
            return $false
        }
        
        # Count compiled modules
        $pydFiles = Get-ChildItem -Recurse -Filter "*.pyd" | Measure-Object
        Write-Success "共编译 $($pydFiles.Count) 个 .pyd 模块"
        
        return $true
    } catch {
        Write-Error-Custom "验证过程出错: $_"
        return $false
    } finally {
        Pop-Location
    }
}

# =========================================================
# Main Execution
# =========================================================

function Main {
    Write-Host @"

 ██████╗ ███████╗███╗   ██╗██████╗ ██╗   ██╗
 ██╔══██╗██╔════╝████╗  ██║██╔══██╗╚██╗ ██╔╝
 ██████╔╝█████╗  ██╔██╗ ██║██████╔╝ ╚████╔╝ 
 ██╔══██╗██╔══╝  ██║╚██╗██║██╔═══╝   ╚██╔╝  
 ██║  ██║███████╗██║ ╚████║██║        ██║   
 ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝╚═╝        ╚═╝   
                                              
 Windows Build Script for Ren'Py Engine
 Target: x64 + MSYS2 + MinGW
 
"@ -ForegroundColor Magenta
    
    $startTime = Get-Date
    
    # Step 1: Check MSYS2
    if (-not $SkipMSYS2Check) {
        if (-not (Test-MSYS2Installation)) {
            Write-Error-Custom "MSYS2 检查失败，构建中止"
            exit 1
        }
    }
    
    # Step 2: Install dependencies
    if (-not $SkipDependencies) {
        if (-not (Install-MSYS2Dependencies)) {
            Write-Error-Custom "依赖安装失败，构建中止"
            exit 1
        }
    }
    
    # Step 3: Setup Python
    $pythonExe = Setup-PythonEnvironment
    if ($null -eq $pythonExe) {
        Write-Error-Custom "Python 环境配置失败，构建中止"
        exit 1
    }
    
    # Step 4: Install Python packages
    if (-not (Install-PythonPackages -PythonExe $pythonExe)) {
        Write-Error-Custom "Python 包安装失败，构建中止"
        exit 1
    }
    
    # Step 5: Build Ren'Py modules
    if (-not (Build-RenpyModules -PythonExe $pythonExe)) {
        Write-Error-Custom "Ren'Py 编译失败，构建中止"
        exit 1
    }
    
    # Step 6: Verify build
    if (-not (Test-RenpyBuild -PythonExe $pythonExe)) {
        Write-Error-Custom "构建验证失败"
        exit 1
    }
    
    # Success!
    $endTime = Get-Date
    $duration = $endTime - $startTime
    
    Write-Banner "构建完成!"
    Write-Success "总耗时: $($duration.ToString('mm\:ss'))"
    Write-Success "Ren'Py Windows 版本已就绪"
    Write-Info "下一步: 集成到 VintagePomelo 应用"
}

# Run main function
Main
