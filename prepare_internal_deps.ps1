# =========================================================
# Windows 依赖库准备脚本（草案）
# 用途：下载/编译 SDL2 等库到项目内部，独立于 MSYS2
# 状态：未完成 - 需要根据实际需求调整
# =========================================================

param(
    [switch]$DownloadPrebuilt = $true,
    [switch]$BuildFromSource = $false,
    [string]$TargetArch = "x86_64"
)

$ErrorActionPreference = "Stop"

# =========================================================
# 配置
# =========================================================

$SCRIPT_DIR = $PSScriptRoot
$PROJECT_ROOT = Split-Path -Parent (Split-Path -Parent $SCRIPT_DIR)
$DEPS_DIR = Join-Path $PROJECT_ROOT "Python-3.12.12\windows_deps"
$TARGET_DIR = Join-Path $DEPS_DIR $TargetArch

$LIB_DIR = Join-Path $TARGET_DIR "lib"
$INCLUDE_DIR = Join-Path $TARGET_DIR "include"
$BIN_DIR = Join-Path $TARGET_DIR "bin"

# 创建目录
New-Item -ItemType Directory -Force -Path $LIB_DIR | Out-Null
New-Item -ItemType Directory -Force -Path $INCLUDE_DIR | Out-Null
New-Item -ItemType Directory -Force -Path $BIN_DIR | Out-Null

Write-Host "依赖库将安装到: $TARGET_DIR" -ForegroundColor Cyan

# =========================================================
# 依赖库列表
# =========================================================

$DEPENDENCIES = @{
    "SDL2" = @{
        "version" = "2.32.10"
        "mingw_url" = "https://github.com/libsdl-org/SDL/releases/download/release-2.32.10/SDL2-devel-2.32.10-mingw.tar.gz"
        "required" = $true
    }
    "SDL2_image" = @{
        "version" = "2.8.8"
        "mingw_url" = "https://github.com/libsdl-org/SDL_image/releases/download/release-2.8.8/SDL2_image-devel-2.8.8-mingw.tar.gz"
        "required" = $true
    }
    "SDL2_mixer" = @{
        "version" = "2.8.1"
        "mingw_url" = "https://github.com/libsdl-org/SDL_mixer/releases/download/release-2.8.1/SDL2_mixer-devel-2.8.1-mingw.tar.gz"
        "required" = $true
    }
    "SDL2_ttf" = @{
        "version" = "2.24.0"
        "mingw_url" = "https://github.com/libsdl-org/SDL_ttf/releases/download/release-2.24.0/SDL2_ttf-devel-2.24.0-mingw.tar.gz"
        "required" = $true
    }
}

# =========================================================
# 下载预编译库
# =========================================================

function Download-And-Extract {
    param(
        [string]$Name,
        [string]$Url,
        [string]$TargetDir
    )
    
    Write-Host "`n[下载] $Name..." -ForegroundColor Yellow
    
    $tmpDir = Join-Path $env:TEMP "renpy_deps"
    New-Item -ItemType Directory -Force -Path $tmpDir | Out-Null
    
    $archivePath = Join-Path $tmpDir "$Name.tar.gz"
    
    try {
        # 下载
        Write-Host "  从 $Url 下载..." -ForegroundColor Gray
        Invoke-WebRequest -Uri $Url -OutFile $archivePath -UseBasicParsing
        
        # 解压（需要 7-Zip 或 tar）
        if (Get-Command tar -ErrorAction SilentlyContinue) {
            Write-Host "  解压到 $TargetDir..." -ForegroundColor Gray
            tar -xzf $archivePath -C $tmpDir
            
            # 复制文件到目标目录
            # 注意：MinGW 包通常有 x86_64-w64-mingw32 子目录
            $extractedDir = Get-ChildItem -Path $tmpDir -Directory | Where-Object { $_.Name -like "*$Name*" } | Select-Object -First 1
            
            if ($extractedDir) {
                $mingwDir = Join-Path $extractedDir.FullName "x86_64-w64-mingw32"
                
                if (Test-Path $mingwDir) {
                    # 复制 lib
                    if (Test-Path (Join-Path $mingwDir "lib")) {
                        Copy-Item -Path (Join-Path $mingwDir "lib\*") -Destination $LIB_DIR -Recurse -Force
                    }
                    
                    # 复制 include
                    if (Test-Path (Join-Path $mingwDir "include")) {
                        Copy-Item -Path (Join-Path $mingwDir "include\*") -Destination $INCLUDE_DIR -Recurse -Force
                    }
                    
                    # 复制 bin (DLL)
                    if (Test-Path (Join-Path $mingwDir "bin")) {
                        Copy-Item -Path (Join-Path $mingwDir "bin\*.dll") -Destination $BIN_DIR -Force
                    }
                    
                    Write-Host "  ✓ $Name 安装完成" -ForegroundColor Green
                } else {
                    Write-Host "  ✗ 未找到 MinGW 目录" -ForegroundColor Red
                }
            } else {
                Write-Host "  ✗ 解压失败" -ForegroundColor Red
            }
        } else {
            Write-Host "  ✗ 未找到 tar 命令，请安装 Git for Windows 或 7-Zip" -ForegroundColor Red
        }
    } catch {
        Write-Host "  ✗ 下载/解压失败: $_" -ForegroundColor Red
    } finally {
        # 清理
        if (Test-Path $archivePath) {
            Remove-Item $archivePath -Force
        }
    }
}

# =========================================================
# 主流程
# =========================================================

if ($DownloadPrebuilt) {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host " 下载预编译依赖库" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    
    foreach ($dep in $DEPENDENCIES.Keys) {
        $info = $DEPENDENCIES[$dep]
        
        if ($info.required -or $info.mingw_url) {
            Download-And-Extract -Name $dep -Url $info.mingw_url -TargetDir $TARGET_DIR
        }
    }
    
    Write-Host "`n✓ 依赖库下载完成" -ForegroundColor Green
    Write-Host "库文件: $LIB_DIR" -ForegroundColor Gray
    Write-Host "头文件: $INCLUDE_DIR" -ForegroundColor Gray
    Write-Host "DLL: $BIN_DIR" -ForegroundColor Gray
}

if ($BuildFromSource) {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host " 从源码编译（未实现）" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    
    Write-Host "提示：从源码编译需要以下步骤：" -ForegroundColor Yellow
    Write-Host "1. 下载各库的源码" -ForegroundColor Gray
    Write-Host "2. 配置 MinGW 编译环境" -ForegroundColor Gray
    Write-Host "3. 运行 ./configure --prefix=$TARGET_DIR" -ForegroundColor Gray
    Write-Host "4. make && make install" -ForegroundColor Gray
    Write-Host "`n建议先使用 -DownloadPrebuilt 快速验证" -ForegroundColor Yellow
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " 下一步" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. 修改 setup.py 添加内部库路径支持：" -ForegroundColor White
Write-Host "   - 在 setuplib.py 中添加 use_internal_deps 标志" -ForegroundColor Gray
Write-Host "   - 修改 include_dirs 和 library_dirs" -ForegroundColor Gray
Write-Host ""
Write-Host "2. 测试编译：" -ForegroundColor White
Write-Host "   python setup.py build_ext --inplace --use-internal-deps" -ForegroundColor Gray
Write-Host ""
Write-Host "3. 验证 DLL 依赖：" -ForegroundColor White
Write-Host "   $env:PATH = '$BIN_DIR;$env:PATH'" -ForegroundColor Gray
Write-Host "   python -c 'import _renpy'" -ForegroundColor Gray
Write-Host ""
