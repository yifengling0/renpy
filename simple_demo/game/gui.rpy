## Ren'Py 简单 Demo - GUI 配置

# GUI 初始化
init python:
    # 基本 GUI 设置
    gui.init(1280, 720)

# 颜色定义
define gui.accent_color = "#0066cc"
define gui.text_color = "#ffffff"
define gui.interface_text_color = "#ffffff"

# 字体
define gui.text_font = "DejaVuSans.ttf"
define gui.name_text_font = "DejaVuSans-Bold.ttf"
define gui.interface_text_font = "DejaVuSans.ttf"

# 文本大小
define gui.text_size = 22
define gui.name_text_size = 30
define gui.interface_text_size = 22

# 对话框
define gui.textbox_height = 185
define gui.name_xpos = 240
define gui.text_xpos = 268
define gui.text_width = 744

# 背景颜色
define bg_black = Solid("#000000")
define bg_white = Solid("#ffffff")

# 简化的样式
style default:
    font gui.text_font
    size gui.text_size
    color gui.text_color

style say_dialogue:
    color gui.text_color
