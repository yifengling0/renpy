## Ren'Py 游戏脚本 - 简单 Demo

# 游戏角色定义
define s = Character("夏洛克", color="#c8ffc8")
define w = Character("华生", color="#c8c8ff")

# 游戏开始
label start:
    
    # 显示背景（使用纯色代替图片）
    scene bg black
    
    "欢迎来到 Ren'Py Windows 版本测试！"
    
    "这是一个简单的 demo，用于验证 Ren'Py 引擎在 Windows 上的编译是否成功。"
    
    # 显示角色对话
    s "华生，你看到这个窗口了吗？"
    
    w "是的，夏洛克！看起来 Ren'Py 引擎运行得很好。"
    
    s "太棒了！这意味着我们的 Windows 编译成功了。"
    
    # 菜单选择
    menu:
        "接下来你想做什么？"
        
        "查看构建信息":
            jump build_info
            
        "测试图形功能":
            jump graphics_test
            
        "退出 Demo":
            jump end_demo

label build_info:
    
    s "让我告诉你这个构建的一些信息..."
    
    "编译日期: 2026-02-10"
    "Python 版本: 3.12.12"
    "编译器: MinGW GCC 15.2.0"
    "模块数量: 126 个 .pyd 文件"
    
    w "非常详细！所有核心功能都已编译。"
    
    jump continue_demo

label graphics_test:
    
    w "让我们测试一下图形系统..."
    
    # 改变背景颜色
    scene bg white
    "背景现在是白色的。"
    
    scene bg black
    "现在恢复为黑色。"
    
    s "图形系统工作正常！"
    
    jump continue_demo

label continue_demo:
    
    menu:
        "要继续测试吗？"
        
        "返回主菜单":
            jump start
            
        "结束 Demo":
            jump end_demo

label end_demo:
    
    s "很高兴你能来测试我们的 Ren'Py 引擎。"
    
    w "下一步，我们将把它移植到 HarmonyOS！"
    
    "感谢使用 Ren'Py Windows 版本！"
    
    "Demo 结束。"
    
    return
