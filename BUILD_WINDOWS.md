# Ren'Py Windows 构建指南

## 快速开始

### 方法 1: 自动化构建 (推荐)

```powershell
# 在 PowerShell 中运行
cd vintage-pomelo\renpy
.\build_windows.ps1
```

构建脚本会自动：
- ✅ 检查 MSYS2 安装状态
- ✅ 安装所有必需的依赖库 (SDL2, FFmpeg, 等)
- ✅ 配置 Python 3.12 环境
- ✅ 编译 56+ Cython 模块
- ✅ 验证构建结果

### 方法 2: 手动构建

如果您已经配置好环境：

```powershell
# 跳过依赖检查，直接构建
.\build_windows.ps1 -SkipDependencies

# 清理旧构建后重新编译
.\build_windows.ps1 -CleanBuild

# 指定 Python 路径
.\build_windows.ps1 -PythonPath "C:\Python312\python.exe"
```

---

## 前置要求

### 1. MSYS2 (必需)

**下载**: https://www.msys2.org/

**安装后运行**:
```bash
# 在 MSYS2 终端中
pacman -Syu
```

**验证安装**:
```powershell
Test-Path C:\msys64
```

### 2. Python 3.12 (必需)

脚本会自动使用以下之一：
- MSYS2 内置的 Python (`C:\msys64\mingw64\bin\python.exe`)
- 系统 Python 3.12

**手动安装** (可选):
- 从 https://www.python.org/ 下载
- 或使用项目内的 `Python-3.12.12` 构建

### 3. Visual Studio Build Tools (可选)

如果使用 MSVC 编译器而非 MinGW：
- 下载: https://visualstudio.microsoft.com/downloads/
- 选择 "C++ build tools"

---

## 依赖库清单

构建脚本会自动安装以下包：

| 类别 | 包名 | 用途 |
|------|------|------|
| **核心** | SDL2 | 图形/输入/音频框架 |
| | SDL2_image | 图像加载 (PNG/JPEG/WEBP) |
| | SDL2_mixer | 音频混音 |
| | SDL2_ttf | TrueType 字体 |
| **视频** | FFmpeg | 视频播放/编解码 |
| **文本** | FreeType2 | 字体光栅化 |
| | HarfBuzz | 复杂文本布局 |
| | Fribidi | 双向文本 (阿拉伯语/希伯来语) |
| **3D** | Assimp | 3D 模型加载 |
| **安全** | OpenSSL | 加密签名 |
| **工具** | pkg-config | 库配置检测 |
| | GCC/MinGW | C/C++ 编译器 |
| | Cython | Python-to-C 转换器 |

---

## 构建输出

成功后会生成：

```
vintage-pomelo/renpy/
├── renpy/
│   ├── _renpy.pyd               ← 核心模块
│   ├── display/
│   │   ├── accelerator.pyd
│   │   ├── render.pyd
│   │   └── ...
│   ├── pygame_sdl2/
│   │   ├── display.pyd
│   │   ├── surface.pyd
│   │   └── ...
│   └── text/
│       ├── ftfont.pyd
│       ├── hbfont.pyd
│       └── ...
└── build/                       ← 临时构建文件
```

总共约 **50-60 个 .pyd 文件** (Windows 动态库)

---

## 验证构建

### 自动验证

构建脚本会自动运行测试。

### 手动验证

```powershell
cd vintage-pomelo\renpy

# 测试核心模块
python -c "import _renpy; print('✓ Core OK')"

# 测试 Pygame SDL2
python -c "from renpy.pygame_sdl2 import display; print('✓ Pygame OK')"

# 测试文本渲染
python -c "from renpy.text import ftfont; print('✓ FreeType OK')"

# 运行完整测试套件
python -m pytest renpy/test/
```

---

## 常见问题

### ❌ "MSYS2 未安装"

**解决方案**:
1. 从 https://www.msys2.org/ 下载安装器
2. 安装到 `C:\msys64` (默认路径)
3. 运行 MSYS2，执行 `pacman -Syu` 更新系统

### ❌ "Python 3.12 not found"

**解决方案**:
```powershell
# 方法 1: 使用 MSYS2 Python
C:\msys64\mingw64\bin\python.exe --version

# 方法 2: 指定路径
.\build_windows.ps1 -PythonPath "C:\Python312\python.exe"
```

### ❌ "pkg-config: command not found"

**解决方案**:
```bash
# 在 MSYS2 终端中
pacman -S mingw-w64-x86_64-pkgconf
```

### ❌ "SDL2 not found"

**解决方案**:
```bash
# 在 MSYS2 终端中
pacman -S mingw-w64-x86_64-SDL2 \
          mingw-w64-x86_64-SDL2_image \
          mingw-w64-x86_64-SDL2_mixer \
          mingw-w64-x86_64-SDL2_ttf
```

### ❌ 编译时出现 "ImportError: DLL load failed"

**原因**: PATH 环境变量未包含 MinGW DLL

**解决方案**:
```powershell
$env:PATH = "C:\msys64\mingw64\bin;$env:PATH"
python -c "import _renpy"
```

---

## 性能优化

### 并行编译

编辑 `setup.py` 添加：
```python
# 使用多核编译
ext_modules = cythonize(extensions, nthreads=4)
```

### Release 模式

```powershell
# 移除调试符号，减小文件大小
python setup.py build_ext --inplace --compiler=mingw32 --release
```

---

## 与 HarmonyOS 移植的集成

### 当前状态

- ✅ Windows x64 构建 (.pyd)
- ⏳ HarmonyOS aarch64/x86_64 构建 (.so)

### 下一步

1. **复用 SDL2 库**: 
   - Windows: MSYS2 提供
   - HarmonyOS: 已在 `Python-3.12.12/harmony_deps/` 准备

2. **跨平台编译**:
   ```bash
   # 使用 HarmonyOS SDK
   ./build_harmony_aarch64.sh
   ```

3. **集成到 VintagePomelo**:
   - 将编译好的模块打包到 APK
   - 使用 Python _ctypes 调用 SDL2

---

## 参考资料

- **Ren'Py 官方文档**: https://www.renpy.org/doc/html/
- **MSYS2 官网**: https://www.msys2.org/
- **SDL2 文档**: https://wiki.libsdl.org/
- **Cython 文档**: https://cython.readthedocs.io/

---

## 许可证

See [LICENSE](LICENSE) file for details.

构建脚本遵循 MIT 许可证。
