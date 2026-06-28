# =========================================================
# Ren'Py Demo 运行脚本
# 运行 "The Question" 示例游戏
# =========================================================

param(
    [string]$GameDir = "the_question",
    [switch]$Debug = $false
)

$ErrorActionPreference = "Stop"

# =========================================================
# 配置
# =========================================================

$SCRIPT_DIR = $PSScriptRoot
$RENPY_DIR = $SCRIPT_DIR

# 设置环境变量
$env:PATH = "C:\msys64\mingw64\bin;$env:PATH"
$PYTHON_EXE = "C:\msys64\mingw64\bin\python.exe"

Write-Host @"

 ██████╗ ███████╗███╗   ██╗██████╗ ██╗   ██╗
 ██╔══██╗██╔════╝████╗  ██║██╔══██╗╚██╗ ██╔╝
 ██████╔╝█████╗  ██╔██╗ ██║██████╔╝ ╚████╔╝ 
 ██╔══██╗██╔══╝  ██║╚██╗██║██╔═══╝   ╚██╔╝  
 ██║  ██║███████╗██║ ╚████║██║        ██║   
 ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝╚═╝        ╚═╝   
                                              
 Ren'Py Demo Launcher
 
"@ -ForegroundColor Magenta

Write-Host "游戏目录: $GameDir" -ForegroundColor Cyan
Write-Host "Python: $PYTHON_EXE" -ForegroundColor Cyan
Write-Host ""

# =========================================================
# 检查环境
# =========================================================

Write-Host "[检查] 验证环境..." -ForegroundColor Yellow

# 检查 Python
if (-not (Test-Path $PYTHON_EXE)) {
    Write-Host "✗ Python 未找到: $PYTHON_EXE" -ForegroundColor Red
    exit 1
}

Write-Host "✓ Python 3.12.12 可用" -ForegroundColor Green

# 检查游戏目录
$GAME_PATH = Join-Path $RENPY_DIR $GameDir
if (-not (Test-Path $GAME_PATH)) {
    Write-Host "✗ 游戏目录不存在: $GAME_PATH" -ForegroundColor Red
    exit 1
}

Write-Host "✓ 游戏目录存在: $GameDir" -ForegroundColor Green

# 检查核心模块
try {
    & $PYTHON_EXE -c "import _renpy; from renpy import pygame" 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Ren'Py 模块可用" -ForegroundColor Green
    } else {
        Write-Host "✗ Ren'Py 模块导入失败" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "✗ Ren'Py 模块测试失败: $_" -ForegroundColor Red
    exit 1
}

# =========================================================
# 启动游戏
# =========================================================

Write-Host ""
Write-Host "[启动] 正在启动 Ren'Py 游戏..." -ForegroundColor Yellow
Write-Host ""

Push-Location $RENPY_DIR

try {
    # Ren'Py 启动命令
    $arguments = @(
        "renpy.py"
        $GameDir
    )
    
    if ($Debug) {
        $arguments += "--debug"
    }
    
    # 显示完整命令
    Write-Host "命令: $PYTHON_EXE $($arguments -join ' ')" -ForegroundColor Gray
    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host " 游戏窗口即将打开" -ForegroundColor Cyan
    Write-Host " 按 Ctrl+C 停止游戏" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host ""
    
    # 启动
    & $PYTHON_EXE @arguments
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✓ 游戏正常退出" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "✗ 游戏退出代码: $LASTEXITCODE" -ForegroundColor Red
    }
} catch {
    Write-Host ""
    Write-Host "✗ 启动失败: $_" -ForegroundColor Red
    exit 1
} finally {
    Pop-Location
}

Write-Host ""
Write-Host "完成！" -ForegroundColor Green
