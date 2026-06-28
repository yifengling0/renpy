## Ren'Py 简单 Demo - 界面定义

# Say 对话框屏幕
screen say(who, what):
    style_prefix "say"

    window:
        id "window"
        background Solid("#000000cc")
        
        has vbox:
            spacing 10
            xfill True
            
        if who is not None:
            text who:
                id "who"
                xalign 0.5
                
        text what:
            id "what"
            xalign 0.5

# 选择菜单屏幕
screen choice(items):
    style_prefix "choice"

    vbox:
        xalign 0.5
        yalign 0.5
        spacing 20

        for i in items:
            textbutton i.caption:
                action i.action
                xalign 0.5

# 样式定义
style say_window:
    xalign 0.5
    xfill True
    yalign 1.0
    ysize gui.textbox_height
    background Solid("#000000cc")
    padding (20, 20, 20, 20)

style say_label:
    size gui.name_text_size
    color gui.accent_color
    font gui.name_text_font

style say_dialogue:
    size gui.text_size
    color gui.text_color

style choice_vbox:
    xalign 0.5
    yalign 0.5

style choice_button:
    xalign 0.5
    padding (20, 10, 20, 10)
    background Solid("#333333")
    hover_background Solid("#0066cc")

style choice_button_text:
    size gui.interface_text_size
    color gui.interface_text_color
    hover_color "#ffffff"
    xalign 0.5
