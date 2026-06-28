"""
Ren'Py Windows Build Verification Script
快速验证编译的模块是否正常工作
"""

import sys
import importlib
import traceback
from pathlib import Path

# ANSI 颜色代码
GREEN = '\033[92m'
RED = '\033[91m'
YELLOW = '\033[93m'
BLUE = '\033[94m'
RESET = '\033[0m'

def print_header(msg):
    print(f"\n{BLUE}{'='*60}{RESET}")
    print(f"{BLUE}{msg:^60}{RESET}")
    print(f"{BLUE}{'='*60}{RESET}\n")

def print_success(msg):
    print(f"{GREEN}✓{RESET} {msg}")

def print_error(msg):
    print(f"{RED}✗{RESET} {msg}")

def print_warning(msg):
    print(f"{YELLOW}⚠{RESET} {msg}")

def test_module(module_name, description=""):
    """测试单个模块导入"""
    try:
        module = importlib.import_module(module_name)
        msg = f"{module_name}"
        if description:
            msg += f" - {description}"
        print_success(msg)
        return True
    except ImportError as e:
        print_error(f"{module_name} - {str(e)}")
        return False
    except Exception as e:
        print_error(f"{module_name} - 未知错误: {str(e)}")
        return False

def count_pyd_files():
    """统计编译的 .pyd 文件数量"""
    renpy_dir = Path(__file__).parent
    pyd_files = list(renpy_dir.rglob("*.pyd"))
    return len(pyd_files), pyd_files

def main():
    print_header("Ren'Py Windows 构建验证")
    
    print(f"Python 版本: {sys.version}")
    print(f"Python 路径: {sys.executable}\n")
    
    # 计数 .pyd 文件
    pyd_count, pyd_files = count_pyd_files()
    print(f"找到 {pyd_count} 个 .pyd 文件\n")
    
    if pyd_count == 0:
        print_error("未找到任何编译的模块！")
        print_warning("请先运行: python setup.py build_ext --inplace")
        return False
    
    # 核心模块测试
    print_header("核心模块测试")
    core_modules = [
        ("_renpy", "核心 C 扩展"),
        ("renpy.astsupport", "AST 支持"),
        ("renpy.cslots", "C 槽位"),
        ("renpy.lexersupport", "词法分析器"),
        ("renpy.pydict", "Python 字典优化"),
        ("renpy.tfd", "文本渲染"),
    ]
    
    core_passed = 0
    for module, desc in core_modules:
        if test_module(module, desc):
            core_passed += 1
    
    # Pygame SDL2 兼容层测试
    print_header("Pygame SDL2 兼容层")
    pygame_modules = [
        ("renpy.pygame.display", "显示管理"),
        ("renpy.pygame.surface", "表面渲染"),
        ("renpy.pygame.event", "事件处理"),
        ("renpy.pygame.pygame_time", "时间管理"),
        ("renpy.pygame.transform", "变换"),
        ("renpy.pygame.rect", "矩形"),
        ("renpy.pygame.color", "颜色"),
    ]
    
    pygame_passed = 0
    for module, desc in pygame_modules:
        if test_module(module, desc):
            pygame_passed += 1
    
    # 渲染模块测试
    print_header("渲染引擎")
    render_modules = [
        # Note: Some render modules need full Renpy runtime
        ("renpy.display.matrix", "矩阵运算"),
        ("renpy.display.quaternion", "四元数"),
    ]
    
    render_passed = 0
    for module, desc in render_modules:
        if test_module(module, desc):
            render_passed += 1
    
    # 文本渲染测试
    print_header("文本渲染")
    text_modules = [
        ("renpy.text.ftfont", "FreeType 字体"),
        ("renpy.text.hbfont", "HarfBuzz 布局"),
        ("renpy.text.textsupport", "文本支持"),
    ]
    
    text_passed = 0
    for module, desc in text_modules:
        if test_module(module, desc):
            text_passed += 1
    
    # 音频模块测试
    print_header("音频引擎")
    audio_modules = [
        ("renpy.audio.renpysound", "音频播放"),
    ]
    
    audio_passed = 0
    for module, desc in audio_modules:
        if test_module(module, desc):
            audio_passed += 1
    
    # GL2 渲染测试 (可选)
    print_header("OpenGL 渲染 (可选)")
    gl_modules = [
        ("renpy.gl2.gl2draw", "GL2 绘制"),
        ("renpy.gl2.gl2mesh", "GL2 网格"),
        ("renpy.gl2.gl2model", "GL2 模型"),
    ]
    
    gl_passed = 0
    for module, desc in gl_modules:
        if test_module(module, desc):
            gl_passed += 1
    
    # 总结
    print_header("测试总结")
    
    total_tests = (len(core_modules) + len(pygame_modules) + 
                   len(render_modules) + len(text_modules) + 
                   len(audio_modules) + len(gl_modules))
    total_passed = (core_passed + pygame_passed + render_passed + 
                    text_passed + audio_passed + gl_passed)
    
    print(f"核心模块:    {core_passed}/{len(core_modules)} 通过")
    print(f"Pygame SDL2: {pygame_passed}/{len(pygame_modules)} 通过")
    print(f"渲染引擎:    {render_passed}/{len(render_modules)} 通过")
    print(f"文本渲染:    {text_passed}/{len(text_modules)} 通过")
    print(f"音频引擎:    {audio_passed}/{len(audio_modules)} 通过")
    print(f"OpenGL:      {gl_passed}/{len(gl_modules)} 通过")
    print(f"\n总计:        {total_passed}/{total_tests} 通过")
    
    # 关键模块检查
    critical_modules = ["_renpy", "renpy.pygame_sdl2.display", "renpy.display.render"]
    critical_ok = all(test_module(m, "") for m in critical_modules)
    
    print("\n" + "="*60)
    if critical_ok and core_passed >= len(core_modules) * 0.8:
        print_success("构建验证通过！Ren'Py 已准备就绪。")
        print_success(f"成功编译 {pyd_count} 个模块")
        return True
    else:
        print_error("构建验证失败！部分关键模块缺失。")
        print_warning("请检查编译日志并重新构建。")
        return False

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
