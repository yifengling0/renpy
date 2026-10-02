include "style_common.pxi"

cdef int selected_idle_activate_sound_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(452, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_activate_sound
    return 0

register_property_function("selected_idle_activate_sound", selected_idle_activate_sound_property)

cdef int selected_idle_adjust_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(453, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_adjust_spacing
    return 0

register_property_function("selected_idle_adjust_spacing", selected_idle_adjust_spacing_property)

cdef int selected_idle_aft_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(454, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_aft_bar
    return 0

register_property_function("selected_idle_aft_bar", selected_idle_aft_bar_property)

cdef int selected_idle_aft_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(455, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_aft_gutter
    return 0

register_property_function("selected_idle_aft_gutter", selected_idle_aft_gutter_property)

cdef int selected_idle_alt_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(456, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_alt
    return 0

register_property_function("selected_idle_alt", selected_idle_alt_property)

cdef int selected_idle_altruby_style_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(457, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_altruby_style
    return 0

register_property_function("selected_idle_altruby_style", selected_idle_altruby_style_property)

cdef int selected_idle_antialias_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(458, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_antialias
    return 0

register_property_function("selected_idle_antialias", selected_idle_antialias_property)

cdef int selected_idle_axis_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(459, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_axis
    return 0

register_property_function("selected_idle_axis", selected_idle_axis_property)

cdef int selected_idle_background_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.displayable_or_none(value)
    assign_prefixed(460, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_background
    return 0

register_property_function("selected_idle_background", selected_idle_background_property)

cdef int selected_idle_bar_invert_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(461, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_bar_invert
    return 0

register_property_function("selected_idle_bar_invert", selected_idle_bar_invert_property)

cdef int selected_idle_bar_resizing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(462, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_bar_resizing
    return 0

register_property_function("selected_idle_bar_resizing", selected_idle_bar_resizing_property)

cdef int selected_idle_bar_vertical_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(463, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_bar_vertical
    return 0

register_property_function("selected_idle_bar_vertical", selected_idle_bar_vertical_property)

cdef int selected_idle_black_color_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.color(value)
    assign(464, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_black_color
    return 0

register_property_function("selected_idle_black_color", selected_idle_black_color_property)

cdef int selected_idle_bold_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(465, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_bold
    return 0

register_property_function("selected_idle_bold", selected_idle_bold_property)

cdef int selected_idle_bottom_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(466, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_bottom_margin
    return 0

register_property_function("selected_idle_bottom_margin", selected_idle_bottom_margin_property)

cdef int selected_idle_bottom_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(467, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_bottom_padding
    return 0

register_property_function("selected_idle_bottom_padding", selected_idle_bottom_padding_property)

cdef int selected_idle_box_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(468, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_box_align
    return 0

register_property_function("selected_idle_box_align", selected_idle_box_align_property)

cdef int selected_idle_box_justify_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(469, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_box_justify
    return 0

register_property_function("selected_idle_box_justify", selected_idle_box_justify_property)

cdef int selected_idle_box_layout_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(470, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_box_layout
    return 0

register_property_function("selected_idle_box_layout", selected_idle_box_layout_property)

cdef int selected_idle_box_reverse_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(471, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_box_reverse
    return 0

register_property_function("selected_idle_box_reverse", selected_idle_box_reverse_property)

cdef int selected_idle_box_wrap_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(472, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_box_wrap
    return 0

register_property_function("selected_idle_box_wrap", selected_idle_box_wrap_property)

cdef int selected_idle_box_wrap_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(473, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_box_wrap_spacing
    return 0

register_property_function("selected_idle_box_wrap_spacing", selected_idle_box_wrap_spacing_property)

cdef int selected_idle_caret_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.displayable_or_none(value)
    assign(474, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_caret
    return 0

register_property_function("selected_idle_caret", selected_idle_caret_property)

cdef int selected_idle_child_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.displayable_or_none(value)
    assign_prefixed(475, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_child
    return 0

register_property_function("selected_idle_child", selected_idle_child_property)

cdef int selected_idle_clipping_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(476, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_clipping
    return 0

register_property_function("selected_idle_clipping", selected_idle_clipping_property)

cdef int selected_idle_color_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.color(value)
    assign(477, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_color
    return 0

register_property_function("selected_idle_color", selected_idle_color_property)

cdef int selected_idle_debug_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(478, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_debug
    return 0

register_property_function("selected_idle_debug", selected_idle_debug_property)

cdef int selected_idle_drop_shadow_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(479, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_drop_shadow
    return 0

register_property_function("selected_idle_drop_shadow", selected_idle_drop_shadow_property)

cdef int selected_idle_drop_shadow_color_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.color(value)
    assign(480, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_drop_shadow_color
    return 0

register_property_function("selected_idle_drop_shadow_color", selected_idle_drop_shadow_color_property)

cdef int selected_idle_emoji_font_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(481, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_emoji_font
    return 0

register_property_function("selected_idle_emoji_font", selected_idle_emoji_font_property)

cdef int selected_idle_extra_alt_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(482, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_extra_alt
    return 0

register_property_function("selected_idle_extra_alt", selected_idle_extra_alt_property)

cdef int selected_idle_first_indent_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(483, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_first_indent
    return 0

register_property_function("selected_idle_first_indent", selected_idle_first_indent_property)

cdef int selected_idle_first_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(484, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_first_spacing
    return 0

register_property_function("selected_idle_first_spacing", selected_idle_first_spacing_property)

cdef int selected_idle_fit_first_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(485, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_fit_first
    return 0

register_property_function("selected_idle_fit_first", selected_idle_fit_first_property)

cdef int selected_idle_focus_mask_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = expand_focus_mask(value)
    assign(486, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_focus_mask
    return 0

register_property_function("selected_idle_focus_mask", selected_idle_focus_mask_property)

cdef int selected_idle_focus_rect_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(487, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_focus_rect
    return 0

register_property_function("selected_idle_focus_rect", selected_idle_focus_rect_property)

cdef int selected_idle_font_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(488, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_font
    return 0

register_property_function("selected_idle_font", selected_idle_font_property)

cdef int selected_idle_font_features_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(489, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_font_features
    return 0

register_property_function("selected_idle_font_features", selected_idle_font_features_property)

cdef int selected_idle_fore_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(490, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_fore_bar
    return 0

register_property_function("selected_idle_fore_bar", selected_idle_fore_bar_property)

cdef int selected_idle_fore_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(491, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_fore_gutter
    return 0

register_property_function("selected_idle_fore_gutter", selected_idle_fore_gutter_property)

cdef int selected_idle_foreground_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.displayable_or_none(value)
    assign_prefixed(492, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_foreground
    return 0

register_property_function("selected_idle_foreground", selected_idle_foreground_property)

cdef int selected_idle_group_alt_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(493, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_group_alt
    return 0

register_property_function("selected_idle_group_alt", selected_idle_group_alt_property)

cdef int selected_idle_hinting_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(494, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_hinting
    return 0

register_property_function("selected_idle_hinting", selected_idle_hinting_property)

cdef int selected_idle_hover_sound_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(495, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_hover_sound
    return 0

register_property_function("selected_idle_hover_sound", selected_idle_hover_sound_property)

cdef int selected_idle_hyperlink_functions_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(496, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_hyperlink_functions
    return 0

register_property_function("selected_idle_hyperlink_functions", selected_idle_hyperlink_functions_property)

cdef int selected_idle_instance_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(497, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_instance
    return 0

register_property_function("selected_idle_instance", selected_idle_instance_property)

cdef int selected_idle_italic_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(498, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_italic
    return 0

register_property_function("selected_idle_italic", selected_idle_italic_property)

cdef int selected_idle_justify_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(499, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_justify
    return 0

register_property_function("selected_idle_justify", selected_idle_justify_property)

cdef int selected_idle_kerning_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(500, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_kerning
    return 0

register_property_function("selected_idle_kerning", selected_idle_kerning_property)

cdef int selected_idle_key_events_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(501, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_key_events
    return 0

register_property_function("selected_idle_key_events", selected_idle_key_events_property)

cdef int selected_idle_keyboard_focus_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(502, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_keyboard_focus
    return 0

register_property_function("selected_idle_keyboard_focus", selected_idle_keyboard_focus_property)

cdef int selected_idle_keyboard_focus_insets_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(503, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_keyboard_focus_insets
    return 0

register_property_function("selected_idle_keyboard_focus_insets", selected_idle_keyboard_focus_insets_property)

cdef int selected_idle_language_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(504, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_language
    return 0

register_property_function("selected_idle_language", selected_idle_language_property)

cdef int selected_idle_layout_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(505, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_layout
    return 0

register_property_function("selected_idle_layout", selected_idle_layout_property)

cdef int selected_idle_left_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(506, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_left_margin
    return 0

register_property_function("selected_idle_left_margin", selected_idle_left_margin_property)

cdef int selected_idle_left_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(507, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_left_padding
    return 0

register_property_function("selected_idle_left_padding", selected_idle_left_padding_property)

cdef int selected_idle_line_leading_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(508, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_line_leading
    return 0

register_property_function("selected_idle_line_leading", selected_idle_line_leading_property)

cdef int selected_idle_line_overlap_split_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(509, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_line_overlap_split
    return 0

register_property_function("selected_idle_line_overlap_split", selected_idle_line_overlap_split_property)

cdef int selected_idle_line_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(510, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_line_spacing
    return 0

register_property_function("selected_idle_line_spacing", selected_idle_line_spacing_property)

cdef int selected_idle_min_width_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(511, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_min_width
    return 0

register_property_function("selected_idle_min_width", selected_idle_min_width_property)

cdef int selected_idle_mipmap_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(512, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_mipmap
    return 0

register_property_function("selected_idle_mipmap", selected_idle_mipmap_property)

cdef int selected_idle_modal_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(513, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_modal
    return 0

register_property_function("selected_idle_modal", selected_idle_modal_property)

cdef int selected_idle_mouse_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(514, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_mouse
    return 0

register_property_function("selected_idle_mouse", selected_idle_mouse_property)

cdef int selected_idle_newline_indent_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(515, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_newline_indent
    return 0

register_property_function("selected_idle_newline_indent", selected_idle_newline_indent_property)

cdef int selected_idle_order_reverse_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(516, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_order_reverse
    return 0

register_property_function("selected_idle_order_reverse", selected_idle_order_reverse_property)

cdef int selected_idle_outline_scaling_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(517, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_outline_scaling
    return 0

register_property_function("selected_idle_outline_scaling", selected_idle_outline_scaling_property)

cdef int selected_idle_outlines_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = expand_outlines(value)
    assign(518, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_outlines
    return 0

register_property_function("selected_idle_outlines", selected_idle_outlines_property)

cdef int selected_idle_prefer_emoji_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(519, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_prefer_emoji
    return 0

register_property_function("selected_idle_prefer_emoji", selected_idle_prefer_emoji_property)

cdef int selected_idle_reading_order_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(520, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_reading_order
    return 0

register_property_function("selected_idle_reading_order", selected_idle_reading_order_property)

cdef int selected_idle_rest_indent_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(521, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_rest_indent
    return 0

register_property_function("selected_idle_rest_indent", selected_idle_rest_indent_property)

cdef int selected_idle_right_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(522, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_right_margin
    return 0

register_property_function("selected_idle_right_margin", selected_idle_right_margin_property)

cdef int selected_idle_right_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(523, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_right_padding
    return 0

register_property_function("selected_idle_right_padding", selected_idle_right_padding_property)

cdef int selected_idle_ruby_line_leading_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(524, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_ruby_line_leading
    return 0

register_property_function("selected_idle_ruby_line_leading", selected_idle_ruby_line_leading_property)

cdef int selected_idle_ruby_style_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(525, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_ruby_style
    return 0

register_property_function("selected_idle_ruby_style", selected_idle_ruby_style_property)

cdef int selected_idle_shaper_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(526, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_shaper
    return 0

register_property_function("selected_idle_shaper", selected_idle_shaper_property)

cdef int selected_idle_size_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(527, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_size
    return 0

register_property_function("selected_idle_size", selected_idle_size_property)

cdef int selected_idle_size_group_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(528, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_size_group
    return 0

register_property_function("selected_idle_size_group", selected_idle_size_group_property)

cdef int selected_idle_slow_abortable_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(529, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_slow_abortable
    return 0

register_property_function("selected_idle_slow_abortable", selected_idle_slow_abortable_property)

cdef int selected_idle_slow_cps_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(530, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_slow_cps
    return 0

register_property_function("selected_idle_slow_cps", selected_idle_slow_cps_property)

cdef int selected_idle_slow_cps_multiplier_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(531, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_slow_cps_multiplier
    return 0

register_property_function("selected_idle_slow_cps_multiplier", selected_idle_slow_cps_multiplier_property)

cdef int selected_idle_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(532, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_spacing
    return 0

register_property_function("selected_idle_spacing", selected_idle_spacing_property)

cdef int selected_idle_strikethrough_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(533, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_strikethrough
    return 0

register_property_function("selected_idle_strikethrough", selected_idle_strikethrough_property)

cdef int selected_idle_subpixel_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(534, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_subpixel
    return 0

register_property_function("selected_idle_subpixel", selected_idle_subpixel_property)

cdef int selected_idle_subtitle_width_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(535, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_subtitle_width
    return 0

register_property_function("selected_idle_subtitle_width", selected_idle_subtitle_width_property)

cdef int selected_idle_text_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(536, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_text_align
    return 0

register_property_function("selected_idle_text_align", selected_idle_text_align_property)

cdef int selected_idle_text_y_fudge_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(537, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_text_y_fudge
    return 0

register_property_function("selected_idle_text_y_fudge", selected_idle_text_y_fudge_property)

cdef int selected_idle_textshader_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(538, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_textshader
    return 0

register_property_function("selected_idle_textshader", selected_idle_textshader_property)

cdef int selected_idle_thumb_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(539, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_thumb
    return 0

register_property_function("selected_idle_thumb", selected_idle_thumb_property)

cdef int selected_idle_thumb_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(540, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_thumb_align
    return 0

register_property_function("selected_idle_thumb_align", selected_idle_thumb_align_property)

cdef int selected_idle_thumb_offset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(541, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_thumb_offset
    return 0

register_property_function("selected_idle_thumb_offset", selected_idle_thumb_offset_property)

cdef int selected_idle_thumb_shadow_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(542, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_thumb_shadow
    return 0

register_property_function("selected_idle_thumb_shadow", selected_idle_thumb_shadow_property)

cdef int selected_idle_time_policy_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(543, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_time_policy
    return 0

register_property_function("selected_idle_time_policy", selected_idle_time_policy_property)

cdef int selected_idle_top_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(544, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_top_margin
    return 0

register_property_function("selected_idle_top_margin", selected_idle_top_margin_property)

cdef int selected_idle_top_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(545, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_top_padding
    return 0

register_property_function("selected_idle_top_padding", selected_idle_top_padding_property)

cdef int selected_idle_underline_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(546, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_underline
    return 0

register_property_function("selected_idle_underline", selected_idle_underline_property)

cdef int selected_idle_unscrollable_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(547, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_unscrollable
    return 0

register_property_function("selected_idle_unscrollable", selected_idle_unscrollable_property)

cdef int selected_idle_vertical_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(548, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_vertical
    return 0

register_property_function("selected_idle_vertical", selected_idle_vertical_property)

cdef int selected_idle_xanchor_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    v = expand_anchor(value)
    assign(549, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xanchor
    return 0

register_property_function("selected_idle_xanchor", selected_idle_xanchor_property)

cdef int selected_idle_xfill_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(550, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_xfill
    return 0

register_property_function("selected_idle_xfill", selected_idle_xfill_property)

cdef int selected_idle_xfit_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(551, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_xfit
    return 0

register_property_function("selected_idle_xfit", selected_idle_xfit_property)

cdef int selected_idle_xmaximum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(552, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_xmaximum
    return 0

register_property_function("selected_idle_xmaximum", selected_idle_xmaximum_property)

cdef int selected_idle_xminimum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    v = none_is_0(value)
    assign(553, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xminimum
    return 0

register_property_function("selected_idle_xminimum", selected_idle_xminimum_property)

cdef int selected_idle_xoffset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(554, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_xoffset
    return 0

register_property_function("selected_idle_xoffset", selected_idle_xoffset_property)

cdef int selected_idle_xpos_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(555, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_xpos
    return 0

register_property_function("selected_idle_xpos", selected_idle_xpos_property)

cdef int selected_idle_xspacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(556, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_xspacing
    return 0

register_property_function("selected_idle_xspacing", selected_idle_xspacing_property)

cdef int selected_idle_yanchor_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    v = expand_anchor(value)
    assign(557, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yanchor
    return 0

register_property_function("selected_idle_yanchor", selected_idle_yanchor_property)

cdef int selected_idle_yfill_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(558, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_yfill
    return 0

register_property_function("selected_idle_yfill", selected_idle_yfill_property)

cdef int selected_idle_yfit_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(559, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_yfit
    return 0

register_property_function("selected_idle_yfit", selected_idle_yfit_property)

cdef int selected_idle_ymaximum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(560, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_ymaximum
    return 0

register_property_function("selected_idle_ymaximum", selected_idle_ymaximum_property)

cdef int selected_idle_yminimum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    v = none_is_0(value)
    assign(561, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yminimum
    return 0

register_property_function("selected_idle_yminimum", selected_idle_yminimum_property)

cdef int selected_idle_yoffset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(562, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_yoffset
    return 0

register_property_function("selected_idle_yoffset", selected_idle_yoffset_property)

cdef int selected_idle_ypos_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(563, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_ypos
    return 0

register_property_function("selected_idle_ypos", selected_idle_ypos_property)

cdef int selected_idle_yspacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(564, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_yspacing
    return 0

register_property_function("selected_idle_yspacing", selected_idle_yspacing_property)

cdef int selected_idle_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(506, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_left_margin

    v = index_1(value)
    assign(544, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_top_margin

    v = index_2_or_0(value)
    assign(522, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_right_margin

    v = index_3_or_1(value)
    assign(466, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_bottom_margin
    return 0

register_property_function("selected_idle_margin", selected_idle_margin_property)

cdef int selected_idle_xmargin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(506, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_left_margin

    assign(522, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_right_margin
    return 0

register_property_function("selected_idle_xmargin", selected_idle_xmargin_property)

cdef int selected_idle_ymargin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(544, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_top_margin

    assign(466, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_bottom_margin
    return 0

register_property_function("selected_idle_ymargin", selected_idle_ymargin_property)

cdef int selected_idle_xalign_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(555, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_xpos

    v = expand_anchor(value)
    assign(549, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xanchor
    return 0

register_property_function("selected_idle_xalign", selected_idle_xalign_property)

cdef int selected_idle_yalign_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(563, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_ypos

    v = expand_anchor(value)
    assign(557, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yanchor
    return 0

register_property_function("selected_idle_yalign", selected_idle_yalign_property)

cdef int selected_idle_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(507, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_left_padding

    v = index_1(value)
    assign(545, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_top_padding

    v = index_2_or_0(value)
    assign(523, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_right_padding

    v = index_3_or_1(value)
    assign(467, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_bottom_padding
    return 0

register_property_function("selected_idle_padding", selected_idle_padding_property)

cdef int selected_idle_xpadding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(507, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_left_padding

    assign(523, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_right_padding
    return 0

register_property_function("selected_idle_xpadding", selected_idle_xpadding_property)

cdef int selected_idle_ypadding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(545, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_top_padding

    assign(467, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_bottom_padding
    return 0

register_property_function("selected_idle_ypadding", selected_idle_ypadding_property)

cdef int selected_idle_minwidth_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(511, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_min_width
    return 0

register_property_function("selected_idle_minwidth", selected_idle_minwidth_property)

cdef int selected_idle_textalign_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(536, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_text_align
    return 0

register_property_function("selected_idle_textalign", selected_idle_textalign_property)

cdef int selected_idle_slow_speed_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(530, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_slow_cps
    return 0

register_property_function("selected_idle_slow_speed", selected_idle_slow_speed_property)

cdef int selected_idle_enable_hover_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6
    return 0

register_property_function("selected_idle_enable_hover", selected_idle_enable_hover_property)

cdef int selected_idle_left_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(491, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_fore_gutter
    return 0

register_property_function("selected_idle_left_gutter", selected_idle_left_gutter_property)

cdef int selected_idle_right_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(455, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_aft_gutter
    return 0

register_property_function("selected_idle_right_gutter", selected_idle_right_gutter_property)

cdef int selected_idle_top_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(491, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_fore_gutter
    return 0

register_property_function("selected_idle_top_gutter", selected_idle_top_gutter_property)

cdef int selected_idle_bottom_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(455, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_aft_gutter
    return 0

register_property_function("selected_idle_bottom_gutter", selected_idle_bottom_gutter_property)

cdef int selected_idle_left_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(490, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_fore_bar
    return 0

register_property_function("selected_idle_left_bar", selected_idle_left_bar_property)

cdef int selected_idle_right_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(454, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_aft_bar
    return 0

register_property_function("selected_idle_right_bar", selected_idle_right_bar_property)

cdef int selected_idle_top_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(490, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_fore_bar
    return 0

register_property_function("selected_idle_top_bar", selected_idle_top_bar_property)

cdef int selected_idle_bottom_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(454, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_aft_bar
    return 0

register_property_function("selected_idle_bottom_bar", selected_idle_bottom_bar_property)

cdef int selected_idle_base_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(490, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_fore_bar

    v = none_is_null(value)
    assign_prefixed(454, cache, cache_priorities, priority, v, 'selected_idle_') # selected_idle_aft_bar
    return 0

register_property_function("selected_idle_base_bar", selected_idle_base_bar_property)

cdef int selected_idle_box_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(532, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_spacing
    return 0

register_property_function("selected_idle_box_spacing", selected_idle_box_spacing_property)

cdef int selected_idle_box_first_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(484, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_first_spacing
    return 0

register_property_function("selected_idle_box_first_spacing", selected_idle_box_first_spacing_property)

cdef int selected_idle_pos_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(555, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xpos

    v = index_1(value)
    assign(563, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_ypos
    return 0

register_property_function("selected_idle_pos", selected_idle_pos_property)

cdef int selected_idle_anchor_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    v = expand_anchor(v)
    assign(549, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xanchor

    v = index_1(value)
    v = expand_anchor(v)
    assign(557, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yanchor
    return 0

register_property_function("selected_idle_anchor", selected_idle_anchor_property)

cdef int selected_idle_offset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(554, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xoffset

    v = index_1(value)
    assign(562, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yoffset
    return 0

register_property_function("selected_idle_offset", selected_idle_offset_property)

cdef int selected_idle_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(555, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xpos

    v = index_1(value)
    assign(563, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_ypos

    v = index_0(value)
    v = expand_anchor(v)
    assign(549, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xanchor

    v = index_1(value)
    v = expand_anchor(v)
    assign(557, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yanchor
    return 0

register_property_function("selected_idle_align", selected_idle_align_property)

cdef int selected_idle_maximum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(552, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xmaximum

    v = index_1(value)
    assign(560, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_ymaximum
    return 0

register_property_function("selected_idle_maximum", selected_idle_maximum_property)

cdef int selected_idle_minimum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    v = none_is_0(v)
    assign(553, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xminimum

    v = index_1(value)
    v = none_is_0(v)
    assign(561, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yminimum
    return 0

register_property_function("selected_idle_minimum", selected_idle_minimum_property)

cdef int selected_idle_xsize_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_0(value)
    assign(553, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xminimum

    assign(552, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_xmaximum
    return 0

register_property_function("selected_idle_xsize", selected_idle_xsize_property)

cdef int selected_idle_ysize_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_0(value)
    assign(561, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yminimum

    assign(560, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_ymaximum
    return 0

register_property_function("selected_idle_ysize", selected_idle_ysize_property)

cdef int selected_idle_xysize_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    v = none_is_0(v)
    assign(553, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xminimum

    v = index_0(value)
    assign(552, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xmaximum

    v = index_1(value)
    v = none_is_0(v)
    assign(561, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yminimum

    v = index_1(value)
    assign(560, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_ymaximum
    return 0

register_property_function("selected_idle_xysize", selected_idle_xysize_property)

cdef int selected_idle_area_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(555, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xpos

    v = index_1(value)
    assign(563, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_ypos

    v = 0
    v = expand_anchor(v)
    assign(549, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xanchor

    v = 0
    v = expand_anchor(v)
    assign(557, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yanchor

    v = True
    assign(550, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xfill

    v = True
    assign(558, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yfill

    v = index_2(value)
    assign(552, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xmaximum

    v = index_3(value)
    assign(560, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_ymaximum

    v = index_2(value)
    v = none_is_0(v)
    assign(553, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xminimum

    v = index_3(value)
    v = none_is_0(v)
    assign(561, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yminimum
    return 0

register_property_function("selected_idle_area", selected_idle_area_property)

cdef int selected_idle_xcenter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(555, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_xpos

    v = 0.5
    v = expand_anchor(v)
    assign(549, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xanchor
    return 0

register_property_function("selected_idle_xcenter", selected_idle_xcenter_property)

cdef int selected_idle_ycenter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(563, cache, cache_priorities, priority, <PyObject *> value) # selected_idle_ypos

    v = 0.5
    v = expand_anchor(v)
    assign(557, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yanchor
    return 0

register_property_function("selected_idle_ycenter", selected_idle_ycenter_property)

cdef int selected_idle_xycenter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(555, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xpos

    v = index_1(value)
    assign(563, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_ypos

    v = 0.5
    v = expand_anchor(v)
    assign(549, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_xanchor

    v = 0.5
    v = expand_anchor(v)
    assign(557, cache, cache_priorities, priority, <PyObject *> v) # selected_idle_yanchor
    return 0

register_property_function("selected_idle_xycenter", selected_idle_xycenter_property)

