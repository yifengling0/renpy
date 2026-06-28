"""
Ren'Py 引擎快速测试
测试核心功能是否正常
"""

import sys
import os

# 添加当前目录到路径
sys.path.insert(0, os.path.dirname(__file__))

print("=" * 60)
print("Ren'Py Windows 引擎测试")
print("=" * 60)
print()

# 测试1: 核心模块
print("[1/5] 测试核心 C 扩展模块...")
try:
    import _renpy
    print("  ✓ _renpy 导入成功")
except Exception as e:
    print(f"  ✗ _renpy 导入失败: {e}")
    sys.exit(1)

# 测试2: Pygame SDL2 兼容层
print("[2/5] 测试 Pygame SDL2 兼容层...")
try:
    from renpy import pygame
    print("  ✓ renpy.pygame 导入成功")
except Exception as e:
    print(f"  ✗ renpy.pygame 导入失败: {e}")
    sys.exit(1)

# 测试3: 显示系统
print("[3/5] 测试显示系统...")
try:
    import renpy.pygame.display
    print("  ✓ display 模块可用")
except Exception as e:
    print(f"  ✗ display 模块失败: {e}")
    sys.exit(1)

# 测试4: SDL2 初始化
print("[4/5] 测试 SDL2 初始化...")
try:
    pygame.init()
    print("  ✓ SDL2 初始化成功")
    
    # 获取视频信息
    info = pygame.display.Info()
    print(f"  ✓ 当前分辨率: {info.current_w}x{info.current_h}")
    
    pygame.quit()
except Exception as e:
    print(f"  ✗ SDL2 初始化失败: {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)

# 测试5: 创建测试窗口
print("[5/5] 测试窗口创建...")
try:
    pygame.init()
    
    # 创建小窗口
    screen = pygame.display.set_mode((400, 300))
    pygame.display.set_caption("Ren'Py 测试窗口")
    
    print("  ✓ 窗口创建成功")
    print("  ✓ 窗口将在 2 秒后关闭...")
    
    # 填充颜色
    screen.fill((50, 100, 150))
    pygame.display.flip()
    
    # 等待 2 秒
    import time
    time.sleep(2)
    
    pygame.quit()
    print("  ✓ 窗口已关闭")
    
except Exception as e:
    print(f"  ✗ 窗口创建失败: {e}")
    import traceback
    traceback.print_exc()
    pygame.quit()
    sys.exit(1)

print()
print("=" * 60)
print("✓ 所有测试通过！Ren'Py 引擎工作正常。")
print("=" * 60)
print()
print("下一步：运行完整游戏 demo")
print("命令: python renpy.py the_question")
