cdef class Style(StyleCore):

    property activate_sound:
        def __get__(self):
            return self._get(0)
        def __set__(self, value):
            self.properties.append({ 'activate_sound' : value })
        def __del__(self):
            self.delattr('activate_sound')

    property adjust_spacing:
        def __get__(self):
            return self._get(1)
        def __set__(self, value):
            self.properties.append({ 'adjust_spacing' : value })
        def __del__(self):
            self.delattr('adjust_spacing')

    property aft_bar:
        def __get__(self):
            return self._get(2)
        def __set__(self, value):
            self.properties.append({ 'aft_bar' : value })
        def __del__(self):
            self.delattr('aft_bar')

    property aft_gutter:
        def __get__(self):
            return self._get(3)
        def __set__(self, value):
            self.properties.append({ 'aft_gutter' : value })
        def __del__(self):
            self.delattr('aft_gutter')

    property alt:
        def __get__(self):
            return self._get(4)
        def __set__(self, value):
            self.properties.append({ 'alt' : value })
        def __del__(self):
            self.delattr('alt')

    property altruby_style:
        def __get__(self):
            return self._get(5)
        def __set__(self, value):
            self.properties.append({ 'altruby_style' : value })
        def __del__(self):
            self.delattr('altruby_style')

    property antialias:
        def __get__(self):
            return self._get(6)
        def __set__(self, value):
            self.properties.append({ 'antialias' : value })
        def __del__(self):
            self.delattr('antialias')

    property axis:
        def __get__(self):
            return self._get(7)
        def __set__(self, value):
            self.properties.append({ 'axis' : value })
        def __del__(self):
            self.delattr('axis')

    property background:
        def __get__(self):
            return self._get(8)
        def __set__(self, value):
            self.properties.append({ 'background' : value })
        def __del__(self):
            self.delattr('background')

    property bar_invert:
        def __get__(self):
            return self._get(9)
        def __set__(self, value):
            self.properties.append({ 'bar_invert' : value })
        def __del__(self):
            self.delattr('bar_invert')

    property bar_resizing:
        def __get__(self):
            return self._get(10)
        def __set__(self, value):
            self.properties.append({ 'bar_resizing' : value })
        def __del__(self):
            self.delattr('bar_resizing')

    property bar_vertical:
        def __get__(self):
            return self._get(11)
        def __set__(self, value):
            self.properties.append({ 'bar_vertical' : value })
        def __del__(self):
            self.delattr('bar_vertical')

    property black_color:
        def __get__(self):
            return self._get(12)
        def __set__(self, value):
            self.properties.append({ 'black_color' : value })
        def __del__(self):
            self.delattr('black_color')

    property bold:
        def __get__(self):
            return self._get(13)
        def __set__(self, value):
            self.properties.append({ 'bold' : value })
        def __del__(self):
            self.delattr('bold')

    property bottom_margin:
        def __get__(self):
            return self._get(14)
        def __set__(self, value):
            self.properties.append({ 'bottom_margin' : value })
        def __del__(self):
            self.delattr('bottom_margin')

    property bottom_padding:
        def __get__(self):
            return self._get(15)
        def __set__(self, value):
            self.properties.append({ 'bottom_padding' : value })
        def __del__(self):
            self.delattr('bottom_padding')

    property box_align:
        def __get__(self):
            return self._get(16)
        def __set__(self, value):
            self.properties.append({ 'box_align' : value })
        def __del__(self):
            self.delattr('box_align')

    property box_justify:
        def __get__(self):
            return self._get(17)
        def __set__(self, value):
            self.properties.append({ 'box_justify' : value })
        def __del__(self):
            self.delattr('box_justify')

    property box_layout:
        def __get__(self):
            return self._get(18)
        def __set__(self, value):
            self.properties.append({ 'box_layout' : value })
        def __del__(self):
            self.delattr('box_layout')

    property box_reverse:
        def __get__(self):
            return self._get(19)
        def __set__(self, value):
            self.properties.append({ 'box_reverse' : value })
        def __del__(self):
            self.delattr('box_reverse')

    property box_wrap:
        def __get__(self):
            return self._get(20)
        def __set__(self, value):
            self.properties.append({ 'box_wrap' : value })
        def __del__(self):
            self.delattr('box_wrap')

    property box_wrap_spacing:
        def __get__(self):
            return self._get(21)
        def __set__(self, value):
            self.properties.append({ 'box_wrap_spacing' : value })
        def __del__(self):
            self.delattr('box_wrap_spacing')

    property caret:
        def __get__(self):
            return self._get(22)
        def __set__(self, value):
            self.properties.append({ 'caret' : value })
        def __del__(self):
            self.delattr('caret')

    property child:
        def __get__(self):
            return self._get(23)
        def __set__(self, value):
            self.properties.append({ 'child' : value })
        def __del__(self):
            self.delattr('child')

    property clipping:
        def __get__(self):
            return self._get(24)
        def __set__(self, value):
            self.properties.append({ 'clipping' : value })
        def __del__(self):
            self.delattr('clipping')

    property color:
        def __get__(self):
            return self._get(25)
        def __set__(self, value):
            self.properties.append({ 'color' : value })
        def __del__(self):
            self.delattr('color')

    property debug:
        def __get__(self):
            return self._get(26)
        def __set__(self, value):
            self.properties.append({ 'debug' : value })
        def __del__(self):
            self.delattr('debug')

    property drop_shadow:
        def __get__(self):
            return self._get(27)
        def __set__(self, value):
            self.properties.append({ 'drop_shadow' : value })
        def __del__(self):
            self.delattr('drop_shadow')

    property drop_shadow_color:
        def __get__(self):
            return self._get(28)
        def __set__(self, value):
            self.properties.append({ 'drop_shadow_color' : value })
        def __del__(self):
            self.delattr('drop_shadow_color')

    property emoji_font:
        def __get__(self):
            return self._get(29)
        def __set__(self, value):
            self.properties.append({ 'emoji_font' : value })
        def __del__(self):
            self.delattr('emoji_font')

    property extra_alt:
        def __get__(self):
            return self._get(30)
        def __set__(self, value):
            self.properties.append({ 'extra_alt' : value })
        def __del__(self):
            self.delattr('extra_alt')

    property first_indent:
        def __get__(self):
            return self._get(31)
        def __set__(self, value):
            self.properties.append({ 'first_indent' : value })
        def __del__(self):
            self.delattr('first_indent')

    property first_spacing:
        def __get__(self):
            return self._get(32)
        def __set__(self, value):
            self.properties.append({ 'first_spacing' : value })
        def __del__(self):
            self.delattr('first_spacing')

    property fit_first:
        def __get__(self):
            return self._get(33)
        def __set__(self, value):
            self.properties.append({ 'fit_first' : value })
        def __del__(self):
            self.delattr('fit_first')

    property focus_mask:
        def __get__(self):
            return self._get(34)
        def __set__(self, value):
            self.properties.append({ 'focus_mask' : value })
        def __del__(self):
            self.delattr('focus_mask')

    property focus_rect:
        def __get__(self):
            return self._get(35)
        def __set__(self, value):
            self.properties.append({ 'focus_rect' : value })
        def __del__(self):
            self.delattr('focus_rect')

    property font:
        def __get__(self):
            return self._get(36)
        def __set__(self, value):
            self.properties.append({ 'font' : value })
        def __del__(self):
            self.delattr('font')

    property font_features:
        def __get__(self):
            return self._get(37)
        def __set__(self, value):
            self.properties.append({ 'font_features' : value })
        def __del__(self):
            self.delattr('font_features')

    property fore_bar:
        def __get__(self):
            return self._get(38)
        def __set__(self, value):
            self.properties.append({ 'fore_bar' : value })
        def __del__(self):
            self.delattr('fore_bar')

    property fore_gutter:
        def __get__(self):
            return self._get(39)
        def __set__(self, value):
            self.properties.append({ 'fore_gutter' : value })
        def __del__(self):
            self.delattr('fore_gutter')

    property foreground:
        def __get__(self):
            return self._get(40)
        def __set__(self, value):
            self.properties.append({ 'foreground' : value })
        def __del__(self):
            self.delattr('foreground')

    property group_alt:
        def __get__(self):
            return self._get(41)
        def __set__(self, value):
            self.properties.append({ 'group_alt' : value })
        def __del__(self):
            self.delattr('group_alt')

    property hinting:
        def __get__(self):
            return self._get(42)
        def __set__(self, value):
            self.properties.append({ 'hinting' : value })
        def __del__(self):
            self.delattr('hinting')

    property hover_sound:
        def __get__(self):
            return self._get(43)
        def __set__(self, value):
            self.properties.append({ 'hover_sound' : value })
        def __del__(self):
            self.delattr('hover_sound')

    property hyperlink_functions:
        def __get__(self):
            return self._get(44)
        def __set__(self, value):
            self.properties.append({ 'hyperlink_functions' : value })
        def __del__(self):
            self.delattr('hyperlink_functions')

    property instance:
        def __get__(self):
            return self._get(45)
        def __set__(self, value):
            self.properties.append({ 'instance' : value })
        def __del__(self):
            self.delattr('instance')

    property italic:
        def __get__(self):
            return self._get(46)
        def __set__(self, value):
            self.properties.append({ 'italic' : value })
        def __del__(self):
            self.delattr('italic')

    property justify:
        def __get__(self):
            return self._get(47)
        def __set__(self, value):
            self.properties.append({ 'justify' : value })
        def __del__(self):
            self.delattr('justify')

    property kerning:
        def __get__(self):
            return self._get(48)
        def __set__(self, value):
            self.properties.append({ 'kerning' : value })
        def __del__(self):
            self.delattr('kerning')

    property key_events:
        def __get__(self):
            return self._get(49)
        def __set__(self, value):
            self.properties.append({ 'key_events' : value })
        def __del__(self):
            self.delattr('key_events')

    property keyboard_focus:
        def __get__(self):
            return self._get(50)
        def __set__(self, value):
            self.properties.append({ 'keyboard_focus' : value })
        def __del__(self):
            self.delattr('keyboard_focus')

    property keyboard_focus_insets:
        def __get__(self):
            return self._get(51)
        def __set__(self, value):
            self.properties.append({ 'keyboard_focus_insets' : value })
        def __del__(self):
            self.delattr('keyboard_focus_insets')

    property language:
        def __get__(self):
            return self._get(52)
        def __set__(self, value):
            self.properties.append({ 'language' : value })
        def __del__(self):
            self.delattr('language')

    property layout:
        def __get__(self):
            return self._get(53)
        def __set__(self, value):
            self.properties.append({ 'layout' : value })
        def __del__(self):
            self.delattr('layout')

    property left_margin:
        def __get__(self):
            return self._get(54)
        def __set__(self, value):
            self.properties.append({ 'left_margin' : value })
        def __del__(self):
            self.delattr('left_margin')

    property left_padding:
        def __get__(self):
            return self._get(55)
        def __set__(self, value):
            self.properties.append({ 'left_padding' : value })
        def __del__(self):
            self.delattr('left_padding')

    property line_leading:
        def __get__(self):
            return self._get(56)
        def __set__(self, value):
            self.properties.append({ 'line_leading' : value })
        def __del__(self):
            self.delattr('line_leading')

    property line_overlap_split:
        def __get__(self):
            return self._get(57)
        def __set__(self, value):
            self.properties.append({ 'line_overlap_split' : value })
        def __del__(self):
            self.delattr('line_overlap_split')

    property line_spacing:
        def __get__(self):
            return self._get(58)
        def __set__(self, value):
            self.properties.append({ 'line_spacing' : value })
        def __del__(self):
            self.delattr('line_spacing')

    property min_width:
        def __get__(self):
            return self._get(59)
        def __set__(self, value):
            self.properties.append({ 'min_width' : value })
        def __del__(self):
            self.delattr('min_width')

    property mipmap:
        def __get__(self):
            return self._get(60)
        def __set__(self, value):
            self.properties.append({ 'mipmap' : value })
        def __del__(self):
            self.delattr('mipmap')

    property modal:
        def __get__(self):
            return self._get(61)
        def __set__(self, value):
            self.properties.append({ 'modal' : value })
        def __del__(self):
            self.delattr('modal')

    property mouse:
        def __get__(self):
            return self._get(62)
        def __set__(self, value):
            self.properties.append({ 'mouse' : value })
        def __del__(self):
            self.delattr('mouse')

    property newline_indent:
        def __get__(self):
            return self._get(63)
        def __set__(self, value):
            self.properties.append({ 'newline_indent' : value })
        def __del__(self):
            self.delattr('newline_indent')

    property order_reverse:
        def __get__(self):
            return self._get(64)
        def __set__(self, value):
            self.properties.append({ 'order_reverse' : value })
        def __del__(self):
            self.delattr('order_reverse')

    property outline_scaling:
        def __get__(self):
            return self._get(65)
        def __set__(self, value):
            self.properties.append({ 'outline_scaling' : value })
        def __del__(self):
            self.delattr('outline_scaling')

    property outlines:
        def __get__(self):
            return self._get(66)
        def __set__(self, value):
            self.properties.append({ 'outlines' : value })
        def __del__(self):
            self.delattr('outlines')

    property prefer_emoji:
        def __get__(self):
            return self._get(67)
        def __set__(self, value):
            self.properties.append({ 'prefer_emoji' : value })
        def __del__(self):
            self.delattr('prefer_emoji')

    property reading_order:
        def __get__(self):
            return self._get(68)
        def __set__(self, value):
            self.properties.append({ 'reading_order' : value })
        def __del__(self):
            self.delattr('reading_order')

    property rest_indent:
        def __get__(self):
            return self._get(69)
        def __set__(self, value):
            self.properties.append({ 'rest_indent' : value })
        def __del__(self):
            self.delattr('rest_indent')

    property right_margin:
        def __get__(self):
            return self._get(70)
        def __set__(self, value):
            self.properties.append({ 'right_margin' : value })
        def __del__(self):
            self.delattr('right_margin')

    property right_padding:
        def __get__(self):
            return self._get(71)
        def __set__(self, value):
            self.properties.append({ 'right_padding' : value })
        def __del__(self):
            self.delattr('right_padding')

    property ruby_line_leading:
        def __get__(self):
            return self._get(72)
        def __set__(self, value):
            self.properties.append({ 'ruby_line_leading' : value })
        def __del__(self):
            self.delattr('ruby_line_leading')

    property ruby_style:
        def __get__(self):
            return self._get(73)
        def __set__(self, value):
            self.properties.append({ 'ruby_style' : value })
        def __del__(self):
            self.delattr('ruby_style')

    property shaper:
        def __get__(self):
            return self._get(74)
        def __set__(self, value):
            self.properties.append({ 'shaper' : value })
        def __del__(self):
            self.delattr('shaper')

    property size:
        def __get__(self):
            return self._get(75)
        def __set__(self, value):
            self.properties.append({ 'size' : value })
        def __del__(self):
            self.delattr('size')

    property size_group:
        def __get__(self):
            return self._get(76)
        def __set__(self, value):
            self.properties.append({ 'size_group' : value })
        def __del__(self):
            self.delattr('size_group')

    property slow_abortable:
        def __get__(self):
            return self._get(77)
        def __set__(self, value):
            self.properties.append({ 'slow_abortable' : value })
        def __del__(self):
            self.delattr('slow_abortable')

    property slow_cps:
        def __get__(self):
            return self._get(78)
        def __set__(self, value):
            self.properties.append({ 'slow_cps' : value })
        def __del__(self):
            self.delattr('slow_cps')

    property slow_cps_multiplier:
        def __get__(self):
            return self._get(79)
        def __set__(self, value):
            self.properties.append({ 'slow_cps_multiplier' : value })
        def __del__(self):
            self.delattr('slow_cps_multiplier')

    property spacing:
        def __get__(self):
            return self._get(80)
        def __set__(self, value):
            self.properties.append({ 'spacing' : value })
        def __del__(self):
            self.delattr('spacing')

    property strikethrough:
        def __get__(self):
            return self._get(81)
        def __set__(self, value):
            self.properties.append({ 'strikethrough' : value })
        def __del__(self):
            self.delattr('strikethrough')

    property subpixel:
        def __get__(self):
            return self._get(82)
        def __set__(self, value):
            self.properties.append({ 'subpixel' : value })
        def __del__(self):
            self.delattr('subpixel')

    property subtitle_width:
        def __get__(self):
            return self._get(83)
        def __set__(self, value):
            self.properties.append({ 'subtitle_width' : value })
        def __del__(self):
            self.delattr('subtitle_width')

    property text_align:
        def __get__(self):
            return self._get(84)
        def __set__(self, value):
            self.properties.append({ 'text_align' : value })
        def __del__(self):
            self.delattr('text_align')

    property text_y_fudge:
        def __get__(self):
            return self._get(85)
        def __set__(self, value):
            self.properties.append({ 'text_y_fudge' : value })
        def __del__(self):
            self.delattr('text_y_fudge')

    property textshader:
        def __get__(self):
            return self._get(86)
        def __set__(self, value):
            self.properties.append({ 'textshader' : value })
        def __del__(self):
            self.delattr('textshader')

    property thumb:
        def __get__(self):
            return self._get(87)
        def __set__(self, value):
            self.properties.append({ 'thumb' : value })
        def __del__(self):
            self.delattr('thumb')

    property thumb_align:
        def __get__(self):
            return self._get(88)
        def __set__(self, value):
            self.properties.append({ 'thumb_align' : value })
        def __del__(self):
            self.delattr('thumb_align')

    property thumb_offset:
        def __get__(self):
            return self._get(89)
        def __set__(self, value):
            self.properties.append({ 'thumb_offset' : value })
        def __del__(self):
            self.delattr('thumb_offset')

    property thumb_shadow:
        def __get__(self):
            return self._get(90)
        def __set__(self, value):
            self.properties.append({ 'thumb_shadow' : value })
        def __del__(self):
            self.delattr('thumb_shadow')

    property time_policy:
        def __get__(self):
            return self._get(91)
        def __set__(self, value):
            self.properties.append({ 'time_policy' : value })
        def __del__(self):
            self.delattr('time_policy')

    property top_margin:
        def __get__(self):
            return self._get(92)
        def __set__(self, value):
            self.properties.append({ 'top_margin' : value })
        def __del__(self):
            self.delattr('top_margin')

    property top_padding:
        def __get__(self):
            return self._get(93)
        def __set__(self, value):
            self.properties.append({ 'top_padding' : value })
        def __del__(self):
            self.delattr('top_padding')

    property underline:
        def __get__(self):
            return self._get(94)
        def __set__(self, value):
            self.properties.append({ 'underline' : value })
        def __del__(self):
            self.delattr('underline')

    property unscrollable:
        def __get__(self):
            return self._get(95)
        def __set__(self, value):
            self.properties.append({ 'unscrollable' : value })
        def __del__(self):
            self.delattr('unscrollable')

    property vertical:
        def __get__(self):
            return self._get(96)
        def __set__(self, value):
            self.properties.append({ 'vertical' : value })
        def __del__(self):
            self.delattr('vertical')

    property xanchor:
        def __get__(self):
            return self._get(97)
        def __set__(self, value):
            self.properties.append({ 'xanchor' : value })
        def __del__(self):
            self.delattr('xanchor')

    property xfill:
        def __get__(self):
            return self._get(98)
        def __set__(self, value):
            self.properties.append({ 'xfill' : value })
        def __del__(self):
            self.delattr('xfill')

    property xfit:
        def __get__(self):
            return self._get(99)
        def __set__(self, value):
            self.properties.append({ 'xfit' : value })
        def __del__(self):
            self.delattr('xfit')

    property xmaximum:
        def __get__(self):
            return self._get(100)
        def __set__(self, value):
            self.properties.append({ 'xmaximum' : value })
        def __del__(self):
            self.delattr('xmaximum')

    property xminimum:
        def __get__(self):
            return self._get(101)
        def __set__(self, value):
            self.properties.append({ 'xminimum' : value })
        def __del__(self):
            self.delattr('xminimum')

    property xoffset:
        def __get__(self):
            return self._get(102)
        def __set__(self, value):
            self.properties.append({ 'xoffset' : value })
        def __del__(self):
            self.delattr('xoffset')

    property xpos:
        def __get__(self):
            return self._get(103)
        def __set__(self, value):
            self.properties.append({ 'xpos' : value })
        def __del__(self):
            self.delattr('xpos')

    property xspacing:
        def __get__(self):
            return self._get(104)
        def __set__(self, value):
            self.properties.append({ 'xspacing' : value })
        def __del__(self):
            self.delattr('xspacing')

    property yanchor:
        def __get__(self):
            return self._get(105)
        def __set__(self, value):
            self.properties.append({ 'yanchor' : value })
        def __del__(self):
            self.delattr('yanchor')

    property yfill:
        def __get__(self):
            return self._get(106)
        def __set__(self, value):
            self.properties.append({ 'yfill' : value })
        def __del__(self):
            self.delattr('yfill')

    property yfit:
        def __get__(self):
            return self._get(107)
        def __set__(self, value):
            self.properties.append({ 'yfit' : value })
        def __del__(self):
            self.delattr('yfit')

    property ymaximum:
        def __get__(self):
            return self._get(108)
        def __set__(self, value):
            self.properties.append({ 'ymaximum' : value })
        def __del__(self):
            self.delattr('ymaximum')

    property yminimum:
        def __get__(self):
            return self._get(109)
        def __set__(self, value):
            self.properties.append({ 'yminimum' : value })
        def __del__(self):
            self.delattr('yminimum')

    property yoffset:
        def __get__(self):
            return self._get(110)
        def __set__(self, value):
            self.properties.append({ 'yoffset' : value })
        def __del__(self):
            self.delattr('yoffset')

    property ypos:
        def __get__(self):
            return self._get(111)
        def __set__(self, value):
            self.properties.append({ 'ypos' : value })
        def __del__(self):
            self.delattr('ypos')

    property yspacing:
        def __get__(self):
            return self._get(112)
        def __set__(self, value):
            self.properties.append({ 'yspacing' : value })
        def __del__(self):
            self.delattr('yspacing')

