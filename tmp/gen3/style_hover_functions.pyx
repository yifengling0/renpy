include "style_common.pxi"

cdef int hover_activate_sound_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(226, cache, cache_priorities, priority, <PyObject *> value) # hover_activate_sound
    assign(565, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_activate_sound
    return 0

register_property_function("hover_activate_sound", hover_activate_sound_property)

cdef int hover_adjust_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(227, cache, cache_priorities, priority, <PyObject *> value) # hover_adjust_spacing
    assign(566, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_adjust_spacing
    return 0

register_property_function("hover_adjust_spacing", hover_adjust_spacing_property)

cdef int hover_aft_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_null(value)
    assign_prefixed(228, cache, cache_priorities, priority, v, 'hover_') # hover_aft_bar
    assign_prefixed(567, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_aft_bar
    return 0

register_property_function("hover_aft_bar", hover_aft_bar_property)

cdef int hover_aft_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(229, cache, cache_priorities, priority, <PyObject *> value) # hover_aft_gutter
    assign(568, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_aft_gutter
    return 0

register_property_function("hover_aft_gutter", hover_aft_gutter_property)

cdef int hover_alt_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(230, cache, cache_priorities, priority, <PyObject *> value) # hover_alt
    assign(569, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_alt
    return 0

register_property_function("hover_alt", hover_alt_property)

cdef int hover_altruby_style_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(231, cache, cache_priorities, priority, <PyObject *> value) # hover_altruby_style
    assign(570, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_altruby_style
    return 0

register_property_function("hover_altruby_style", hover_altruby_style_property)

cdef int hover_antialias_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(232, cache, cache_priorities, priority, <PyObject *> value) # hover_antialias
    assign(571, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_antialias
    return 0

register_property_function("hover_antialias", hover_antialias_property)

cdef int hover_axis_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(233, cache, cache_priorities, priority, <PyObject *> value) # hover_axis
    assign(572, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_axis
    return 0

register_property_function("hover_axis", hover_axis_property)

cdef int hover_background_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = renpy.easy.displayable_or_none(value)
    assign_prefixed(234, cache, cache_priorities, priority, v, 'hover_') # hover_background
    assign_prefixed(573, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_background
    return 0

register_property_function("hover_background", hover_background_property)

cdef int hover_bar_invert_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(235, cache, cache_priorities, priority, <PyObject *> value) # hover_bar_invert
    assign(574, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_bar_invert
    return 0

register_property_function("hover_bar_invert", hover_bar_invert_property)

cdef int hover_bar_resizing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(236, cache, cache_priorities, priority, <PyObject *> value) # hover_bar_resizing
    assign(575, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_bar_resizing
    return 0

register_property_function("hover_bar_resizing", hover_bar_resizing_property)

cdef int hover_bar_vertical_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(237, cache, cache_priorities, priority, <PyObject *> value) # hover_bar_vertical
    assign(576, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_bar_vertical
    return 0

register_property_function("hover_bar_vertical", hover_bar_vertical_property)

cdef int hover_black_color_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = renpy.easy.color(value)
    assign(238, cache, cache_priorities, priority, <PyObject *> v) # hover_black_color
    assign(577, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_black_color
    return 0

register_property_function("hover_black_color", hover_black_color_property)

cdef int hover_bold_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(239, cache, cache_priorities, priority, <PyObject *> value) # hover_bold
    assign(578, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_bold
    return 0

register_property_function("hover_bold", hover_bold_property)

cdef int hover_bottom_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(240, cache, cache_priorities, priority, <PyObject *> value) # hover_bottom_margin
    assign(579, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_bottom_margin
    return 0

register_property_function("hover_bottom_margin", hover_bottom_margin_property)

cdef int hover_bottom_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(241, cache, cache_priorities, priority, <PyObject *> value) # hover_bottom_padding
    assign(580, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_bottom_padding
    return 0

register_property_function("hover_bottom_padding", hover_bottom_padding_property)

cdef int hover_box_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(242, cache, cache_priorities, priority, <PyObject *> value) # hover_box_align
    assign(581, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_box_align
    return 0

register_property_function("hover_box_align", hover_box_align_property)

cdef int hover_box_justify_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(243, cache, cache_priorities, priority, <PyObject *> value) # hover_box_justify
    assign(582, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_box_justify
    return 0

register_property_function("hover_box_justify", hover_box_justify_property)

cdef int hover_box_layout_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(244, cache, cache_priorities, priority, <PyObject *> value) # hover_box_layout
    assign(583, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_box_layout
    return 0

register_property_function("hover_box_layout", hover_box_layout_property)

cdef int hover_box_reverse_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(245, cache, cache_priorities, priority, <PyObject *> value) # hover_box_reverse
    assign(584, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_box_reverse
    return 0

register_property_function("hover_box_reverse", hover_box_reverse_property)

cdef int hover_box_wrap_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(246, cache, cache_priorities, priority, <PyObject *> value) # hover_box_wrap
    assign(585, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_box_wrap
    return 0

register_property_function("hover_box_wrap", hover_box_wrap_property)

cdef int hover_box_wrap_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(247, cache, cache_priorities, priority, <PyObject *> value) # hover_box_wrap_spacing
    assign(586, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_box_wrap_spacing
    return 0

register_property_function("hover_box_wrap_spacing", hover_box_wrap_spacing_property)

cdef int hover_caret_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = renpy.easy.displayable_or_none(value)
    assign(248, cache, cache_priorities, priority, <PyObject *> v) # hover_caret
    assign(587, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_caret
    return 0

register_property_function("hover_caret", hover_caret_property)

cdef int hover_child_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = renpy.easy.displayable_or_none(value)
    assign_prefixed(249, cache, cache_priorities, priority, v, 'hover_') # hover_child
    assign_prefixed(588, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_child
    return 0

register_property_function("hover_child", hover_child_property)

cdef int hover_clipping_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(250, cache, cache_priorities, priority, <PyObject *> value) # hover_clipping
    assign(589, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_clipping
    return 0

register_property_function("hover_clipping", hover_clipping_property)

cdef int hover_color_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = renpy.easy.color(value)
    assign(251, cache, cache_priorities, priority, <PyObject *> v) # hover_color
    assign(590, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_color
    return 0

register_property_function("hover_color", hover_color_property)

cdef int hover_debug_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(252, cache, cache_priorities, priority, <PyObject *> value) # hover_debug
    assign(591, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_debug
    return 0

register_property_function("hover_debug", hover_debug_property)

cdef int hover_drop_shadow_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(253, cache, cache_priorities, priority, <PyObject *> value) # hover_drop_shadow
    assign(592, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_drop_shadow
    return 0

register_property_function("hover_drop_shadow", hover_drop_shadow_property)

cdef int hover_drop_shadow_color_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = renpy.easy.color(value)
    assign(254, cache, cache_priorities, priority, <PyObject *> v) # hover_drop_shadow_color
    assign(593, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_drop_shadow_color
    return 0

register_property_function("hover_drop_shadow_color", hover_drop_shadow_color_property)

cdef int hover_emoji_font_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(255, cache, cache_priorities, priority, <PyObject *> value) # hover_emoji_font
    assign(594, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_emoji_font
    return 0

register_property_function("hover_emoji_font", hover_emoji_font_property)

cdef int hover_extra_alt_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(256, cache, cache_priorities, priority, <PyObject *> value) # hover_extra_alt
    assign(595, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_extra_alt
    return 0

register_property_function("hover_extra_alt", hover_extra_alt_property)

cdef int hover_first_indent_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(257, cache, cache_priorities, priority, <PyObject *> value) # hover_first_indent
    assign(596, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_first_indent
    return 0

register_property_function("hover_first_indent", hover_first_indent_property)

cdef int hover_first_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(258, cache, cache_priorities, priority, <PyObject *> value) # hover_first_spacing
    assign(597, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_first_spacing
    return 0

register_property_function("hover_first_spacing", hover_first_spacing_property)

cdef int hover_fit_first_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(259, cache, cache_priorities, priority, <PyObject *> value) # hover_fit_first
    assign(598, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_fit_first
    return 0

register_property_function("hover_fit_first", hover_fit_first_property)

cdef int hover_focus_mask_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = expand_focus_mask(value)
    assign(260, cache, cache_priorities, priority, <PyObject *> v) # hover_focus_mask
    assign(599, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_focus_mask
    return 0

register_property_function("hover_focus_mask", hover_focus_mask_property)

cdef int hover_focus_rect_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(261, cache, cache_priorities, priority, <PyObject *> value) # hover_focus_rect
    assign(600, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_focus_rect
    return 0

register_property_function("hover_focus_rect", hover_focus_rect_property)

cdef int hover_font_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(262, cache, cache_priorities, priority, <PyObject *> value) # hover_font
    assign(601, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_font
    return 0

register_property_function("hover_font", hover_font_property)

cdef int hover_font_features_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(263, cache, cache_priorities, priority, <PyObject *> value) # hover_font_features
    assign(602, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_font_features
    return 0

register_property_function("hover_font_features", hover_font_features_property)

cdef int hover_fore_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_null(value)
    assign_prefixed(264, cache, cache_priorities, priority, v, 'hover_') # hover_fore_bar
    assign_prefixed(603, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_fore_bar
    return 0

register_property_function("hover_fore_bar", hover_fore_bar_property)

cdef int hover_fore_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(265, cache, cache_priorities, priority, <PyObject *> value) # hover_fore_gutter
    assign(604, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_fore_gutter
    return 0

register_property_function("hover_fore_gutter", hover_fore_gutter_property)

cdef int hover_foreground_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = renpy.easy.displayable_or_none(value)
    assign_prefixed(266, cache, cache_priorities, priority, v, 'hover_') # hover_foreground
    assign_prefixed(605, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_foreground
    return 0

register_property_function("hover_foreground", hover_foreground_property)

cdef int hover_group_alt_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(267, cache, cache_priorities, priority, <PyObject *> value) # hover_group_alt
    assign(606, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_group_alt
    return 0

register_property_function("hover_group_alt", hover_group_alt_property)

cdef int hover_hinting_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(268, cache, cache_priorities, priority, <PyObject *> value) # hover_hinting
    assign(607, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_hinting
    return 0

register_property_function("hover_hinting", hover_hinting_property)

cdef int hover_hover_sound_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(269, cache, cache_priorities, priority, <PyObject *> value) # hover_hover_sound
    assign(608, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_hover_sound
    return 0

register_property_function("hover_hover_sound", hover_hover_sound_property)

cdef int hover_hyperlink_functions_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(270, cache, cache_priorities, priority, <PyObject *> value) # hover_hyperlink_functions
    assign(609, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_hyperlink_functions
    return 0

register_property_function("hover_hyperlink_functions", hover_hyperlink_functions_property)

cdef int hover_instance_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(271, cache, cache_priorities, priority, <PyObject *> value) # hover_instance
    assign(610, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_instance
    return 0

register_property_function("hover_instance", hover_instance_property)

cdef int hover_italic_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(272, cache, cache_priorities, priority, <PyObject *> value) # hover_italic
    assign(611, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_italic
    return 0

register_property_function("hover_italic", hover_italic_property)

cdef int hover_justify_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(273, cache, cache_priorities, priority, <PyObject *> value) # hover_justify
    assign(612, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_justify
    return 0

register_property_function("hover_justify", hover_justify_property)

cdef int hover_kerning_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(274, cache, cache_priorities, priority, <PyObject *> value) # hover_kerning
    assign(613, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_kerning
    return 0

register_property_function("hover_kerning", hover_kerning_property)

cdef int hover_key_events_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(275, cache, cache_priorities, priority, <PyObject *> value) # hover_key_events
    assign(614, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_key_events
    return 0

register_property_function("hover_key_events", hover_key_events_property)

cdef int hover_keyboard_focus_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(276, cache, cache_priorities, priority, <PyObject *> value) # hover_keyboard_focus
    assign(615, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_keyboard_focus
    return 0

register_property_function("hover_keyboard_focus", hover_keyboard_focus_property)

cdef int hover_keyboard_focus_insets_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(277, cache, cache_priorities, priority, <PyObject *> value) # hover_keyboard_focus_insets
    assign(616, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_keyboard_focus_insets
    return 0

register_property_function("hover_keyboard_focus_insets", hover_keyboard_focus_insets_property)

cdef int hover_language_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(278, cache, cache_priorities, priority, <PyObject *> value) # hover_language
    assign(617, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_language
    return 0

register_property_function("hover_language", hover_language_property)

cdef int hover_layout_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(279, cache, cache_priorities, priority, <PyObject *> value) # hover_layout
    assign(618, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_layout
    return 0

register_property_function("hover_layout", hover_layout_property)

cdef int hover_left_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(280, cache, cache_priorities, priority, <PyObject *> value) # hover_left_margin
    assign(619, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_left_margin
    return 0

register_property_function("hover_left_margin", hover_left_margin_property)

cdef int hover_left_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(281, cache, cache_priorities, priority, <PyObject *> value) # hover_left_padding
    assign(620, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_left_padding
    return 0

register_property_function("hover_left_padding", hover_left_padding_property)

cdef int hover_line_leading_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(282, cache, cache_priorities, priority, <PyObject *> value) # hover_line_leading
    assign(621, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_line_leading
    return 0

register_property_function("hover_line_leading", hover_line_leading_property)

cdef int hover_line_overlap_split_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(283, cache, cache_priorities, priority, <PyObject *> value) # hover_line_overlap_split
    assign(622, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_line_overlap_split
    return 0

register_property_function("hover_line_overlap_split", hover_line_overlap_split_property)

cdef int hover_line_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(284, cache, cache_priorities, priority, <PyObject *> value) # hover_line_spacing
    assign(623, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_line_spacing
    return 0

register_property_function("hover_line_spacing", hover_line_spacing_property)

cdef int hover_min_width_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(285, cache, cache_priorities, priority, <PyObject *> value) # hover_min_width
    assign(624, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_min_width
    return 0

register_property_function("hover_min_width", hover_min_width_property)

cdef int hover_mipmap_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(286, cache, cache_priorities, priority, <PyObject *> value) # hover_mipmap
    assign(625, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_mipmap
    return 0

register_property_function("hover_mipmap", hover_mipmap_property)

cdef int hover_modal_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(287, cache, cache_priorities, priority, <PyObject *> value) # hover_modal
    assign(626, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_modal
    return 0

register_property_function("hover_modal", hover_modal_property)

cdef int hover_mouse_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(288, cache, cache_priorities, priority, <PyObject *> value) # hover_mouse
    assign(627, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_mouse
    return 0

register_property_function("hover_mouse", hover_mouse_property)

cdef int hover_newline_indent_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(289, cache, cache_priorities, priority, <PyObject *> value) # hover_newline_indent
    assign(628, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_newline_indent
    return 0

register_property_function("hover_newline_indent", hover_newline_indent_property)

cdef int hover_order_reverse_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(290, cache, cache_priorities, priority, <PyObject *> value) # hover_order_reverse
    assign(629, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_order_reverse
    return 0

register_property_function("hover_order_reverse", hover_order_reverse_property)

cdef int hover_outline_scaling_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(291, cache, cache_priorities, priority, <PyObject *> value) # hover_outline_scaling
    assign(630, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_outline_scaling
    return 0

register_property_function("hover_outline_scaling", hover_outline_scaling_property)

cdef int hover_outlines_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = expand_outlines(value)
    assign(292, cache, cache_priorities, priority, <PyObject *> v) # hover_outlines
    assign(631, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_outlines
    return 0

register_property_function("hover_outlines", hover_outlines_property)

cdef int hover_prefer_emoji_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(293, cache, cache_priorities, priority, <PyObject *> value) # hover_prefer_emoji
    assign(632, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_prefer_emoji
    return 0

register_property_function("hover_prefer_emoji", hover_prefer_emoji_property)

cdef int hover_reading_order_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(294, cache, cache_priorities, priority, <PyObject *> value) # hover_reading_order
    assign(633, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_reading_order
    return 0

register_property_function("hover_reading_order", hover_reading_order_property)

cdef int hover_rest_indent_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(295, cache, cache_priorities, priority, <PyObject *> value) # hover_rest_indent
    assign(634, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_rest_indent
    return 0

register_property_function("hover_rest_indent", hover_rest_indent_property)

cdef int hover_right_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(296, cache, cache_priorities, priority, <PyObject *> value) # hover_right_margin
    assign(635, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_right_margin
    return 0

register_property_function("hover_right_margin", hover_right_margin_property)

cdef int hover_right_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(297, cache, cache_priorities, priority, <PyObject *> value) # hover_right_padding
    assign(636, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_right_padding
    return 0

register_property_function("hover_right_padding", hover_right_padding_property)

cdef int hover_ruby_line_leading_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(298, cache, cache_priorities, priority, <PyObject *> value) # hover_ruby_line_leading
    assign(637, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_ruby_line_leading
    return 0

register_property_function("hover_ruby_line_leading", hover_ruby_line_leading_property)

cdef int hover_ruby_style_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(299, cache, cache_priorities, priority, <PyObject *> value) # hover_ruby_style
    assign(638, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_ruby_style
    return 0

register_property_function("hover_ruby_style", hover_ruby_style_property)

cdef int hover_shaper_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(300, cache, cache_priorities, priority, <PyObject *> value) # hover_shaper
    assign(639, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_shaper
    return 0

register_property_function("hover_shaper", hover_shaper_property)

cdef int hover_size_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(301, cache, cache_priorities, priority, <PyObject *> value) # hover_size
    assign(640, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_size
    return 0

register_property_function("hover_size", hover_size_property)

cdef int hover_size_group_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(302, cache, cache_priorities, priority, <PyObject *> value) # hover_size_group
    assign(641, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_size_group
    return 0

register_property_function("hover_size_group", hover_size_group_property)

cdef int hover_slow_abortable_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(303, cache, cache_priorities, priority, <PyObject *> value) # hover_slow_abortable
    assign(642, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_slow_abortable
    return 0

register_property_function("hover_slow_abortable", hover_slow_abortable_property)

cdef int hover_slow_cps_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(304, cache, cache_priorities, priority, <PyObject *> value) # hover_slow_cps
    assign(643, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_slow_cps
    return 0

register_property_function("hover_slow_cps", hover_slow_cps_property)

cdef int hover_slow_cps_multiplier_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(305, cache, cache_priorities, priority, <PyObject *> value) # hover_slow_cps_multiplier
    assign(644, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_slow_cps_multiplier
    return 0

register_property_function("hover_slow_cps_multiplier", hover_slow_cps_multiplier_property)

cdef int hover_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(306, cache, cache_priorities, priority, <PyObject *> value) # hover_spacing
    assign(645, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_spacing
    return 0

register_property_function("hover_spacing", hover_spacing_property)

cdef int hover_strikethrough_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(307, cache, cache_priorities, priority, <PyObject *> value) # hover_strikethrough
    assign(646, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_strikethrough
    return 0

register_property_function("hover_strikethrough", hover_strikethrough_property)

cdef int hover_subpixel_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(308, cache, cache_priorities, priority, <PyObject *> value) # hover_subpixel
    assign(647, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_subpixel
    return 0

register_property_function("hover_subpixel", hover_subpixel_property)

cdef int hover_subtitle_width_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(309, cache, cache_priorities, priority, <PyObject *> value) # hover_subtitle_width
    assign(648, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_subtitle_width
    return 0

register_property_function("hover_subtitle_width", hover_subtitle_width_property)

cdef int hover_text_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(310, cache, cache_priorities, priority, <PyObject *> value) # hover_text_align
    assign(649, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_text_align
    return 0

register_property_function("hover_text_align", hover_text_align_property)

cdef int hover_text_y_fudge_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(311, cache, cache_priorities, priority, <PyObject *> value) # hover_text_y_fudge
    assign(650, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_text_y_fudge
    return 0

register_property_function("hover_text_y_fudge", hover_text_y_fudge_property)

cdef int hover_textshader_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(312, cache, cache_priorities, priority, <PyObject *> value) # hover_textshader
    assign(651, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_textshader
    return 0

register_property_function("hover_textshader", hover_textshader_property)

cdef int hover_thumb_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_null(value)
    assign_prefixed(313, cache, cache_priorities, priority, v, 'hover_') # hover_thumb
    assign_prefixed(652, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_thumb
    return 0

register_property_function("hover_thumb", hover_thumb_property)

cdef int hover_thumb_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(314, cache, cache_priorities, priority, <PyObject *> value) # hover_thumb_align
    assign(653, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_thumb_align
    return 0

register_property_function("hover_thumb_align", hover_thumb_align_property)

cdef int hover_thumb_offset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(315, cache, cache_priorities, priority, <PyObject *> value) # hover_thumb_offset
    assign(654, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_thumb_offset
    return 0

register_property_function("hover_thumb_offset", hover_thumb_offset_property)

cdef int hover_thumb_shadow_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_null(value)
    assign_prefixed(316, cache, cache_priorities, priority, v, 'hover_') # hover_thumb_shadow
    assign_prefixed(655, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_thumb_shadow
    return 0

register_property_function("hover_thumb_shadow", hover_thumb_shadow_property)

cdef int hover_time_policy_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(317, cache, cache_priorities, priority, <PyObject *> value) # hover_time_policy
    assign(656, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_time_policy
    return 0

register_property_function("hover_time_policy", hover_time_policy_property)

cdef int hover_top_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(318, cache, cache_priorities, priority, <PyObject *> value) # hover_top_margin
    assign(657, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_top_margin
    return 0

register_property_function("hover_top_margin", hover_top_margin_property)

cdef int hover_top_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(319, cache, cache_priorities, priority, <PyObject *> value) # hover_top_padding
    assign(658, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_top_padding
    return 0

register_property_function("hover_top_padding", hover_top_padding_property)

cdef int hover_underline_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(320, cache, cache_priorities, priority, <PyObject *> value) # hover_underline
    assign(659, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_underline
    return 0

register_property_function("hover_underline", hover_underline_property)

cdef int hover_unscrollable_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(321, cache, cache_priorities, priority, <PyObject *> value) # hover_unscrollable
    assign(660, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_unscrollable
    return 0

register_property_function("hover_unscrollable", hover_unscrollable_property)

cdef int hover_vertical_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(322, cache, cache_priorities, priority, <PyObject *> value) # hover_vertical
    assign(661, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_vertical
    return 0

register_property_function("hover_vertical", hover_vertical_property)

cdef int hover_xanchor_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    v = expand_anchor(value)
    assign(323, cache, cache_priorities, priority, <PyObject *> v) # hover_xanchor
    assign(662, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xanchor
    return 0

register_property_function("hover_xanchor", hover_xanchor_property)

cdef int hover_xfill_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(324, cache, cache_priorities, priority, <PyObject *> value) # hover_xfill
    assign(663, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_xfill
    return 0

register_property_function("hover_xfill", hover_xfill_property)

cdef int hover_xfit_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(325, cache, cache_priorities, priority, <PyObject *> value) # hover_xfit
    assign(664, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_xfit
    return 0

register_property_function("hover_xfit", hover_xfit_property)

cdef int hover_xmaximum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(326, cache, cache_priorities, priority, <PyObject *> value) # hover_xmaximum
    assign(665, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_xmaximum
    return 0

register_property_function("hover_xmaximum", hover_xmaximum_property)

cdef int hover_xminimum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    v = none_is_0(value)
    assign(327, cache, cache_priorities, priority, <PyObject *> v) # hover_xminimum
    assign(666, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xminimum
    return 0

register_property_function("hover_xminimum", hover_xminimum_property)

cdef int hover_xoffset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(328, cache, cache_priorities, priority, <PyObject *> value) # hover_xoffset
    assign(667, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_xoffset
    return 0

register_property_function("hover_xoffset", hover_xoffset_property)

cdef int hover_xpos_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(329, cache, cache_priorities, priority, <PyObject *> value) # hover_xpos
    assign(668, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_xpos
    return 0

register_property_function("hover_xpos", hover_xpos_property)

cdef int hover_xspacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(330, cache, cache_priorities, priority, <PyObject *> value) # hover_xspacing
    assign(669, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_xspacing
    return 0

register_property_function("hover_xspacing", hover_xspacing_property)

cdef int hover_yanchor_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    v = expand_anchor(value)
    assign(331, cache, cache_priorities, priority, <PyObject *> v) # hover_yanchor
    assign(670, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yanchor
    return 0

register_property_function("hover_yanchor", hover_yanchor_property)

cdef int hover_yfill_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(332, cache, cache_priorities, priority, <PyObject *> value) # hover_yfill
    assign(671, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_yfill
    return 0

register_property_function("hover_yfill", hover_yfill_property)

cdef int hover_yfit_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(333, cache, cache_priorities, priority, <PyObject *> value) # hover_yfit
    assign(672, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_yfit
    return 0

register_property_function("hover_yfit", hover_yfit_property)

cdef int hover_ymaximum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(334, cache, cache_priorities, priority, <PyObject *> value) # hover_ymaximum
    assign(673, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_ymaximum
    return 0

register_property_function("hover_ymaximum", hover_ymaximum_property)

cdef int hover_yminimum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    v = none_is_0(value)
    assign(335, cache, cache_priorities, priority, <PyObject *> v) # hover_yminimum
    assign(674, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yminimum
    return 0

register_property_function("hover_yminimum", hover_yminimum_property)

cdef int hover_yoffset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(336, cache, cache_priorities, priority, <PyObject *> value) # hover_yoffset
    assign(675, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_yoffset
    return 0

register_property_function("hover_yoffset", hover_yoffset_property)

cdef int hover_ypos_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 3

    assign(337, cache, cache_priorities, priority, <PyObject *> value) # hover_ypos
    assign(676, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_ypos
    return 0

register_property_function("hover_ypos", hover_ypos_property)

cdef int hover_yspacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(338, cache, cache_priorities, priority, <PyObject *> value) # hover_yspacing
    assign(677, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_yspacing
    return 0

register_property_function("hover_yspacing", hover_yspacing_property)

cdef int hover_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    assign(280, cache, cache_priorities, priority, <PyObject *> v) # hover_left_margin
    assign(619, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_left_margin

    v = index_1(value)
    assign(318, cache, cache_priorities, priority, <PyObject *> v) # hover_top_margin
    assign(657, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_top_margin

    v = index_2_or_0(value)
    assign(296, cache, cache_priorities, priority, <PyObject *> v) # hover_right_margin
    assign(635, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_right_margin

    v = index_3_or_1(value)
    assign(240, cache, cache_priorities, priority, <PyObject *> v) # hover_bottom_margin
    assign(579, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_bottom_margin
    return 0

register_property_function("hover_margin", hover_margin_property)

cdef int hover_xmargin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(280, cache, cache_priorities, priority, <PyObject *> value) # hover_left_margin
    assign(619, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_left_margin

    assign(296, cache, cache_priorities, priority, <PyObject *> value) # hover_right_margin
    assign(635, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_right_margin
    return 0

register_property_function("hover_xmargin", hover_xmargin_property)

cdef int hover_ymargin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(318, cache, cache_priorities, priority, <PyObject *> value) # hover_top_margin
    assign(657, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_top_margin

    assign(240, cache, cache_priorities, priority, <PyObject *> value) # hover_bottom_margin
    assign(579, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_bottom_margin
    return 0

register_property_function("hover_ymargin", hover_ymargin_property)

cdef int hover_xalign_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(329, cache, cache_priorities, priority, <PyObject *> value) # hover_xpos
    assign(668, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_xpos

    v = expand_anchor(value)
    assign(323, cache, cache_priorities, priority, <PyObject *> v) # hover_xanchor
    assign(662, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xanchor
    return 0

register_property_function("hover_xalign", hover_xalign_property)

cdef int hover_yalign_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(337, cache, cache_priorities, priority, <PyObject *> value) # hover_ypos
    assign(676, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_ypos

    v = expand_anchor(value)
    assign(331, cache, cache_priorities, priority, <PyObject *> v) # hover_yanchor
    assign(670, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yanchor
    return 0

register_property_function("hover_yalign", hover_yalign_property)

cdef int hover_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    assign(281, cache, cache_priorities, priority, <PyObject *> v) # hover_left_padding
    assign(620, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_left_padding

    v = index_1(value)
    assign(319, cache, cache_priorities, priority, <PyObject *> v) # hover_top_padding
    assign(658, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_top_padding

    v = index_2_or_0(value)
    assign(297, cache, cache_priorities, priority, <PyObject *> v) # hover_right_padding
    assign(636, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_right_padding

    v = index_3_or_1(value)
    assign(241, cache, cache_priorities, priority, <PyObject *> v) # hover_bottom_padding
    assign(580, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_bottom_padding
    return 0

register_property_function("hover_padding", hover_padding_property)

cdef int hover_xpadding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(281, cache, cache_priorities, priority, <PyObject *> value) # hover_left_padding
    assign(620, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_left_padding

    assign(297, cache, cache_priorities, priority, <PyObject *> value) # hover_right_padding
    assign(636, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_right_padding
    return 0

register_property_function("hover_xpadding", hover_xpadding_property)

cdef int hover_ypadding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(319, cache, cache_priorities, priority, <PyObject *> value) # hover_top_padding
    assign(658, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_top_padding

    assign(241, cache, cache_priorities, priority, <PyObject *> value) # hover_bottom_padding
    assign(580, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_bottom_padding
    return 0

register_property_function("hover_ypadding", hover_ypadding_property)

cdef int hover_minwidth_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(285, cache, cache_priorities, priority, <PyObject *> value) # hover_min_width
    assign(624, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_min_width
    return 0

register_property_function("hover_minwidth", hover_minwidth_property)

cdef int hover_textalign_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(310, cache, cache_priorities, priority, <PyObject *> value) # hover_text_align
    assign(649, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_text_align
    return 0

register_property_function("hover_textalign", hover_textalign_property)

cdef int hover_slow_speed_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(304, cache, cache_priorities, priority, <PyObject *> value) # hover_slow_cps
    assign(643, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_slow_cps
    return 0

register_property_function("hover_slow_speed", hover_slow_speed_property)

cdef int hover_enable_hover_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2
    return 0

register_property_function("hover_enable_hover", hover_enable_hover_property)

cdef int hover_left_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(265, cache, cache_priorities, priority, <PyObject *> value) # hover_fore_gutter
    assign(604, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_fore_gutter
    return 0

register_property_function("hover_left_gutter", hover_left_gutter_property)

cdef int hover_right_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(229, cache, cache_priorities, priority, <PyObject *> value) # hover_aft_gutter
    assign(568, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_aft_gutter
    return 0

register_property_function("hover_right_gutter", hover_right_gutter_property)

cdef int hover_top_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(265, cache, cache_priorities, priority, <PyObject *> value) # hover_fore_gutter
    assign(604, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_fore_gutter
    return 0

register_property_function("hover_top_gutter", hover_top_gutter_property)

cdef int hover_bottom_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(229, cache, cache_priorities, priority, <PyObject *> value) # hover_aft_gutter
    assign(568, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_aft_gutter
    return 0

register_property_function("hover_bottom_gutter", hover_bottom_gutter_property)

cdef int hover_left_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_null(value)
    assign_prefixed(264, cache, cache_priorities, priority, v, 'hover_') # hover_fore_bar
    assign_prefixed(603, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_fore_bar
    return 0

register_property_function("hover_left_bar", hover_left_bar_property)

cdef int hover_right_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_null(value)
    assign_prefixed(228, cache, cache_priorities, priority, v, 'hover_') # hover_aft_bar
    assign_prefixed(567, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_aft_bar
    return 0

register_property_function("hover_right_bar", hover_right_bar_property)

cdef int hover_top_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_null(value)
    assign_prefixed(264, cache, cache_priorities, priority, v, 'hover_') # hover_fore_bar
    assign_prefixed(603, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_fore_bar
    return 0

register_property_function("hover_top_bar", hover_top_bar_property)

cdef int hover_bottom_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_null(value)
    assign_prefixed(228, cache, cache_priorities, priority, v, 'hover_') # hover_aft_bar
    assign_prefixed(567, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_aft_bar
    return 0

register_property_function("hover_bottom_bar", hover_bottom_bar_property)

cdef int hover_base_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_null(value)
    assign_prefixed(264, cache, cache_priorities, priority, v, 'hover_') # hover_fore_bar
    assign_prefixed(603, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_fore_bar

    v = none_is_null(value)
    assign_prefixed(228, cache, cache_priorities, priority, v, 'hover_') # hover_aft_bar
    assign_prefixed(567, cache, cache_priorities, priority, v, 'selected_hover_') # selected_hover_aft_bar
    return 0

register_property_function("hover_base_bar", hover_base_bar_property)

cdef int hover_box_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(306, cache, cache_priorities, priority, <PyObject *> value) # hover_spacing
    assign(645, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_spacing
    return 0

register_property_function("hover_box_spacing", hover_box_spacing_property)

cdef int hover_box_first_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(258, cache, cache_priorities, priority, <PyObject *> value) # hover_first_spacing
    assign(597, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_first_spacing
    return 0

register_property_function("hover_box_first_spacing", hover_box_first_spacing_property)

cdef int hover_pos_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    assign(329, cache, cache_priorities, priority, <PyObject *> v) # hover_xpos
    assign(668, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xpos

    v = index_1(value)
    assign(337, cache, cache_priorities, priority, <PyObject *> v) # hover_ypos
    assign(676, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_ypos
    return 0

register_property_function("hover_pos", hover_pos_property)

cdef int hover_anchor_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    v = expand_anchor(v)
    assign(323, cache, cache_priorities, priority, <PyObject *> v) # hover_xanchor
    assign(662, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xanchor

    v = index_1(value)
    v = expand_anchor(v)
    assign(331, cache, cache_priorities, priority, <PyObject *> v) # hover_yanchor
    assign(670, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yanchor
    return 0

register_property_function("hover_anchor", hover_anchor_property)

cdef int hover_offset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    assign(328, cache, cache_priorities, priority, <PyObject *> v) # hover_xoffset
    assign(667, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xoffset

    v = index_1(value)
    assign(336, cache, cache_priorities, priority, <PyObject *> v) # hover_yoffset
    assign(675, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yoffset
    return 0

register_property_function("hover_offset", hover_offset_property)

cdef int hover_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    assign(329, cache, cache_priorities, priority, <PyObject *> v) # hover_xpos
    assign(668, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xpos

    v = index_1(value)
    assign(337, cache, cache_priorities, priority, <PyObject *> v) # hover_ypos
    assign(676, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_ypos

    v = index_0(value)
    v = expand_anchor(v)
    assign(323, cache, cache_priorities, priority, <PyObject *> v) # hover_xanchor
    assign(662, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xanchor

    v = index_1(value)
    v = expand_anchor(v)
    assign(331, cache, cache_priorities, priority, <PyObject *> v) # hover_yanchor
    assign(670, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yanchor
    return 0

register_property_function("hover_align", hover_align_property)

cdef int hover_maximum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    assign(326, cache, cache_priorities, priority, <PyObject *> v) # hover_xmaximum
    assign(665, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xmaximum

    v = index_1(value)
    assign(334, cache, cache_priorities, priority, <PyObject *> v) # hover_ymaximum
    assign(673, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_ymaximum
    return 0

register_property_function("hover_maximum", hover_maximum_property)

cdef int hover_minimum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    v = none_is_0(v)
    assign(327, cache, cache_priorities, priority, <PyObject *> v) # hover_xminimum
    assign(666, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xminimum

    v = index_1(value)
    v = none_is_0(v)
    assign(335, cache, cache_priorities, priority, <PyObject *> v) # hover_yminimum
    assign(674, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yminimum
    return 0

register_property_function("hover_minimum", hover_minimum_property)

cdef int hover_xsize_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_0(value)
    assign(327, cache, cache_priorities, priority, <PyObject *> v) # hover_xminimum
    assign(666, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xminimum

    assign(326, cache, cache_priorities, priority, <PyObject *> value) # hover_xmaximum
    assign(665, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_xmaximum
    return 0

register_property_function("hover_xsize", hover_xsize_property)

cdef int hover_ysize_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = none_is_0(value)
    assign(335, cache, cache_priorities, priority, <PyObject *> v) # hover_yminimum
    assign(674, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yminimum

    assign(334, cache, cache_priorities, priority, <PyObject *> value) # hover_ymaximum
    assign(673, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_ymaximum
    return 0

register_property_function("hover_ysize", hover_ysize_property)

cdef int hover_xysize_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    v = none_is_0(v)
    assign(327, cache, cache_priorities, priority, <PyObject *> v) # hover_xminimum
    assign(666, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xminimum

    v = index_0(value)
    assign(326, cache, cache_priorities, priority, <PyObject *> v) # hover_xmaximum
    assign(665, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xmaximum

    v = index_1(value)
    v = none_is_0(v)
    assign(335, cache, cache_priorities, priority, <PyObject *> v) # hover_yminimum
    assign(674, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yminimum

    v = index_1(value)
    assign(334, cache, cache_priorities, priority, <PyObject *> v) # hover_ymaximum
    assign(673, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_ymaximum
    return 0

register_property_function("hover_xysize", hover_xysize_property)

cdef int hover_area_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    assign(329, cache, cache_priorities, priority, <PyObject *> v) # hover_xpos
    assign(668, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xpos

    v = index_1(value)
    assign(337, cache, cache_priorities, priority, <PyObject *> v) # hover_ypos
    assign(676, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_ypos

    v = 0
    v = expand_anchor(v)
    assign(323, cache, cache_priorities, priority, <PyObject *> v) # hover_xanchor
    assign(662, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xanchor

    v = 0
    v = expand_anchor(v)
    assign(331, cache, cache_priorities, priority, <PyObject *> v) # hover_yanchor
    assign(670, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yanchor

    v = True
    assign(324, cache, cache_priorities, priority, <PyObject *> v) # hover_xfill
    assign(663, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xfill

    v = True
    assign(332, cache, cache_priorities, priority, <PyObject *> v) # hover_yfill
    assign(671, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yfill

    v = index_2(value)
    assign(326, cache, cache_priorities, priority, <PyObject *> v) # hover_xmaximum
    assign(665, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xmaximum

    v = index_3(value)
    assign(334, cache, cache_priorities, priority, <PyObject *> v) # hover_ymaximum
    assign(673, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_ymaximum

    v = index_2(value)
    v = none_is_0(v)
    assign(327, cache, cache_priorities, priority, <PyObject *> v) # hover_xminimum
    assign(666, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xminimum

    v = index_3(value)
    v = none_is_0(v)
    assign(335, cache, cache_priorities, priority, <PyObject *> v) # hover_yminimum
    assign(674, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yminimum
    return 0

register_property_function("hover_area", hover_area_property)

cdef int hover_xcenter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(329, cache, cache_priorities, priority, <PyObject *> value) # hover_xpos
    assign(668, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_xpos

    v = 0.5
    v = expand_anchor(v)
    assign(323, cache, cache_priorities, priority, <PyObject *> v) # hover_xanchor
    assign(662, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xanchor
    return 0

register_property_function("hover_xcenter", hover_xcenter_property)

cdef int hover_ycenter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    assign(337, cache, cache_priorities, priority, <PyObject *> value) # hover_ypos
    assign(676, cache, cache_priorities, priority, <PyObject *> value) # selected_hover_ypos

    v = 0.5
    v = expand_anchor(v)
    assign(331, cache, cache_priorities, priority, <PyObject *> v) # hover_yanchor
    assign(670, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yanchor
    return 0

register_property_function("hover_ycenter", hover_ycenter_property)

cdef int hover_xycenter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 2

    v = index_0(value)
    assign(329, cache, cache_priorities, priority, <PyObject *> v) # hover_xpos
    assign(668, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xpos

    v = index_1(value)
    assign(337, cache, cache_priorities, priority, <PyObject *> v) # hover_ypos
    assign(676, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_ypos

    v = 0.5
    v = expand_anchor(v)
    assign(323, cache, cache_priorities, priority, <PyObject *> v) # hover_xanchor
    assign(662, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_xanchor

    v = 0.5
    v = expand_anchor(v)
    assign(331, cache, cache_priorities, priority, <PyObject *> v) # hover_yanchor
    assign(670, cache, cache_priorities, priority, <PyObject *> v) # selected_hover_yanchor
    return 0

register_property_function("hover_xycenter", hover_xycenter_property)

