include "style_common.pxi"

cdef int selected_insensitive_activate_sound_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(339, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_activate_sound
    return 0

register_property_function("selected_insensitive_activate_sound", selected_insensitive_activate_sound_property)

cdef int selected_insensitive_adjust_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(340, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_adjust_spacing
    return 0

register_property_function("selected_insensitive_adjust_spacing", selected_insensitive_adjust_spacing_property)

cdef int selected_insensitive_aft_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(341, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_aft_bar
    return 0

register_property_function("selected_insensitive_aft_bar", selected_insensitive_aft_bar_property)

cdef int selected_insensitive_aft_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(342, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_aft_gutter
    return 0

register_property_function("selected_insensitive_aft_gutter", selected_insensitive_aft_gutter_property)

cdef int selected_insensitive_alt_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(343, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_alt
    return 0

register_property_function("selected_insensitive_alt", selected_insensitive_alt_property)

cdef int selected_insensitive_altruby_style_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(344, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_altruby_style
    return 0

register_property_function("selected_insensitive_altruby_style", selected_insensitive_altruby_style_property)

cdef int selected_insensitive_antialias_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(345, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_antialias
    return 0

register_property_function("selected_insensitive_antialias", selected_insensitive_antialias_property)

cdef int selected_insensitive_axis_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(346, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_axis
    return 0

register_property_function("selected_insensitive_axis", selected_insensitive_axis_property)

cdef int selected_insensitive_background_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.displayable_or_none(value)
    assign_prefixed(347, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_background
    return 0

register_property_function("selected_insensitive_background", selected_insensitive_background_property)

cdef int selected_insensitive_bar_invert_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(348, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_bar_invert
    return 0

register_property_function("selected_insensitive_bar_invert", selected_insensitive_bar_invert_property)

cdef int selected_insensitive_bar_resizing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(349, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_bar_resizing
    return 0

register_property_function("selected_insensitive_bar_resizing", selected_insensitive_bar_resizing_property)

cdef int selected_insensitive_bar_vertical_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(350, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_bar_vertical
    return 0

register_property_function("selected_insensitive_bar_vertical", selected_insensitive_bar_vertical_property)

cdef int selected_insensitive_black_color_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.color(value)
    assign(351, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_black_color
    return 0

register_property_function("selected_insensitive_black_color", selected_insensitive_black_color_property)

cdef int selected_insensitive_bold_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(352, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_bold
    return 0

register_property_function("selected_insensitive_bold", selected_insensitive_bold_property)

cdef int selected_insensitive_bottom_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(353, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_bottom_margin
    return 0

register_property_function("selected_insensitive_bottom_margin", selected_insensitive_bottom_margin_property)

cdef int selected_insensitive_bottom_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(354, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_bottom_padding
    return 0

register_property_function("selected_insensitive_bottom_padding", selected_insensitive_bottom_padding_property)

cdef int selected_insensitive_box_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(355, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_box_align
    return 0

register_property_function("selected_insensitive_box_align", selected_insensitive_box_align_property)

cdef int selected_insensitive_box_justify_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(356, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_box_justify
    return 0

register_property_function("selected_insensitive_box_justify", selected_insensitive_box_justify_property)

cdef int selected_insensitive_box_layout_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(357, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_box_layout
    return 0

register_property_function("selected_insensitive_box_layout", selected_insensitive_box_layout_property)

cdef int selected_insensitive_box_reverse_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(358, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_box_reverse
    return 0

register_property_function("selected_insensitive_box_reverse", selected_insensitive_box_reverse_property)

cdef int selected_insensitive_box_wrap_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(359, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_box_wrap
    return 0

register_property_function("selected_insensitive_box_wrap", selected_insensitive_box_wrap_property)

cdef int selected_insensitive_box_wrap_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(360, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_box_wrap_spacing
    return 0

register_property_function("selected_insensitive_box_wrap_spacing", selected_insensitive_box_wrap_spacing_property)

cdef int selected_insensitive_caret_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.displayable_or_none(value)
    assign(361, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_caret
    return 0

register_property_function("selected_insensitive_caret", selected_insensitive_caret_property)

cdef int selected_insensitive_child_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.displayable_or_none(value)
    assign_prefixed(362, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_child
    return 0

register_property_function("selected_insensitive_child", selected_insensitive_child_property)

cdef int selected_insensitive_clipping_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(363, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_clipping
    return 0

register_property_function("selected_insensitive_clipping", selected_insensitive_clipping_property)

cdef int selected_insensitive_color_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.color(value)
    assign(364, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_color
    return 0

register_property_function("selected_insensitive_color", selected_insensitive_color_property)

cdef int selected_insensitive_debug_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(365, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_debug
    return 0

register_property_function("selected_insensitive_debug", selected_insensitive_debug_property)

cdef int selected_insensitive_drop_shadow_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(366, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_drop_shadow
    return 0

register_property_function("selected_insensitive_drop_shadow", selected_insensitive_drop_shadow_property)

cdef int selected_insensitive_drop_shadow_color_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.color(value)
    assign(367, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_drop_shadow_color
    return 0

register_property_function("selected_insensitive_drop_shadow_color", selected_insensitive_drop_shadow_color_property)

cdef int selected_insensitive_emoji_font_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(368, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_emoji_font
    return 0

register_property_function("selected_insensitive_emoji_font", selected_insensitive_emoji_font_property)

cdef int selected_insensitive_extra_alt_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(369, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_extra_alt
    return 0

register_property_function("selected_insensitive_extra_alt", selected_insensitive_extra_alt_property)

cdef int selected_insensitive_first_indent_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(370, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_first_indent
    return 0

register_property_function("selected_insensitive_first_indent", selected_insensitive_first_indent_property)

cdef int selected_insensitive_first_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(371, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_first_spacing
    return 0

register_property_function("selected_insensitive_first_spacing", selected_insensitive_first_spacing_property)

cdef int selected_insensitive_fit_first_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(372, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_fit_first
    return 0

register_property_function("selected_insensitive_fit_first", selected_insensitive_fit_first_property)

cdef int selected_insensitive_focus_mask_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = expand_focus_mask(value)
    assign(373, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_focus_mask
    return 0

register_property_function("selected_insensitive_focus_mask", selected_insensitive_focus_mask_property)

cdef int selected_insensitive_focus_rect_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(374, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_focus_rect
    return 0

register_property_function("selected_insensitive_focus_rect", selected_insensitive_focus_rect_property)

cdef int selected_insensitive_font_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(375, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_font
    return 0

register_property_function("selected_insensitive_font", selected_insensitive_font_property)

cdef int selected_insensitive_font_features_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(376, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_font_features
    return 0

register_property_function("selected_insensitive_font_features", selected_insensitive_font_features_property)

cdef int selected_insensitive_fore_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(377, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_fore_bar
    return 0

register_property_function("selected_insensitive_fore_bar", selected_insensitive_fore_bar_property)

cdef int selected_insensitive_fore_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(378, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_fore_gutter
    return 0

register_property_function("selected_insensitive_fore_gutter", selected_insensitive_fore_gutter_property)

cdef int selected_insensitive_foreground_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = renpy.easy.displayable_or_none(value)
    assign_prefixed(379, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_foreground
    return 0

register_property_function("selected_insensitive_foreground", selected_insensitive_foreground_property)

cdef int selected_insensitive_group_alt_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(380, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_group_alt
    return 0

register_property_function("selected_insensitive_group_alt", selected_insensitive_group_alt_property)

cdef int selected_insensitive_hinting_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(381, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_hinting
    return 0

register_property_function("selected_insensitive_hinting", selected_insensitive_hinting_property)

cdef int selected_insensitive_hover_sound_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(382, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_hover_sound
    return 0

register_property_function("selected_insensitive_hover_sound", selected_insensitive_hover_sound_property)

cdef int selected_insensitive_hyperlink_functions_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(383, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_hyperlink_functions
    return 0

register_property_function("selected_insensitive_hyperlink_functions", selected_insensitive_hyperlink_functions_property)

cdef int selected_insensitive_instance_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(384, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_instance
    return 0

register_property_function("selected_insensitive_instance", selected_insensitive_instance_property)

cdef int selected_insensitive_italic_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(385, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_italic
    return 0

register_property_function("selected_insensitive_italic", selected_insensitive_italic_property)

cdef int selected_insensitive_justify_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(386, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_justify
    return 0

register_property_function("selected_insensitive_justify", selected_insensitive_justify_property)

cdef int selected_insensitive_kerning_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(387, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_kerning
    return 0

register_property_function("selected_insensitive_kerning", selected_insensitive_kerning_property)

cdef int selected_insensitive_key_events_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(388, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_key_events
    return 0

register_property_function("selected_insensitive_key_events", selected_insensitive_key_events_property)

cdef int selected_insensitive_keyboard_focus_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(389, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_keyboard_focus
    return 0

register_property_function("selected_insensitive_keyboard_focus", selected_insensitive_keyboard_focus_property)

cdef int selected_insensitive_keyboard_focus_insets_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(390, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_keyboard_focus_insets
    return 0

register_property_function("selected_insensitive_keyboard_focus_insets", selected_insensitive_keyboard_focus_insets_property)

cdef int selected_insensitive_language_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(391, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_language
    return 0

register_property_function("selected_insensitive_language", selected_insensitive_language_property)

cdef int selected_insensitive_layout_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(392, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_layout
    return 0

register_property_function("selected_insensitive_layout", selected_insensitive_layout_property)

cdef int selected_insensitive_left_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(393, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_left_margin
    return 0

register_property_function("selected_insensitive_left_margin", selected_insensitive_left_margin_property)

cdef int selected_insensitive_left_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(394, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_left_padding
    return 0

register_property_function("selected_insensitive_left_padding", selected_insensitive_left_padding_property)

cdef int selected_insensitive_line_leading_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(395, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_line_leading
    return 0

register_property_function("selected_insensitive_line_leading", selected_insensitive_line_leading_property)

cdef int selected_insensitive_line_overlap_split_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(396, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_line_overlap_split
    return 0

register_property_function("selected_insensitive_line_overlap_split", selected_insensitive_line_overlap_split_property)

cdef int selected_insensitive_line_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(397, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_line_spacing
    return 0

register_property_function("selected_insensitive_line_spacing", selected_insensitive_line_spacing_property)

cdef int selected_insensitive_min_width_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(398, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_min_width
    return 0

register_property_function("selected_insensitive_min_width", selected_insensitive_min_width_property)

cdef int selected_insensitive_mipmap_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(399, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_mipmap
    return 0

register_property_function("selected_insensitive_mipmap", selected_insensitive_mipmap_property)

cdef int selected_insensitive_modal_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(400, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_modal
    return 0

register_property_function("selected_insensitive_modal", selected_insensitive_modal_property)

cdef int selected_insensitive_mouse_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(401, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_mouse
    return 0

register_property_function("selected_insensitive_mouse", selected_insensitive_mouse_property)

cdef int selected_insensitive_newline_indent_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(402, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_newline_indent
    return 0

register_property_function("selected_insensitive_newline_indent", selected_insensitive_newline_indent_property)

cdef int selected_insensitive_order_reverse_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(403, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_order_reverse
    return 0

register_property_function("selected_insensitive_order_reverse", selected_insensitive_order_reverse_property)

cdef int selected_insensitive_outline_scaling_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(404, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_outline_scaling
    return 0

register_property_function("selected_insensitive_outline_scaling", selected_insensitive_outline_scaling_property)

cdef int selected_insensitive_outlines_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = expand_outlines(value)
    assign(405, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_outlines
    return 0

register_property_function("selected_insensitive_outlines", selected_insensitive_outlines_property)

cdef int selected_insensitive_prefer_emoji_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(406, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_prefer_emoji
    return 0

register_property_function("selected_insensitive_prefer_emoji", selected_insensitive_prefer_emoji_property)

cdef int selected_insensitive_reading_order_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(407, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_reading_order
    return 0

register_property_function("selected_insensitive_reading_order", selected_insensitive_reading_order_property)

cdef int selected_insensitive_rest_indent_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(408, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_rest_indent
    return 0

register_property_function("selected_insensitive_rest_indent", selected_insensitive_rest_indent_property)

cdef int selected_insensitive_right_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(409, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_right_margin
    return 0

register_property_function("selected_insensitive_right_margin", selected_insensitive_right_margin_property)

cdef int selected_insensitive_right_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(410, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_right_padding
    return 0

register_property_function("selected_insensitive_right_padding", selected_insensitive_right_padding_property)

cdef int selected_insensitive_ruby_line_leading_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(411, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_ruby_line_leading
    return 0

register_property_function("selected_insensitive_ruby_line_leading", selected_insensitive_ruby_line_leading_property)

cdef int selected_insensitive_ruby_style_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(412, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_ruby_style
    return 0

register_property_function("selected_insensitive_ruby_style", selected_insensitive_ruby_style_property)

cdef int selected_insensitive_shaper_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(413, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_shaper
    return 0

register_property_function("selected_insensitive_shaper", selected_insensitive_shaper_property)

cdef int selected_insensitive_size_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(414, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_size
    return 0

register_property_function("selected_insensitive_size", selected_insensitive_size_property)

cdef int selected_insensitive_size_group_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(415, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_size_group
    return 0

register_property_function("selected_insensitive_size_group", selected_insensitive_size_group_property)

cdef int selected_insensitive_slow_abortable_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(416, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_slow_abortable
    return 0

register_property_function("selected_insensitive_slow_abortable", selected_insensitive_slow_abortable_property)

cdef int selected_insensitive_slow_cps_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(417, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_slow_cps
    return 0

register_property_function("selected_insensitive_slow_cps", selected_insensitive_slow_cps_property)

cdef int selected_insensitive_slow_cps_multiplier_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(418, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_slow_cps_multiplier
    return 0

register_property_function("selected_insensitive_slow_cps_multiplier", selected_insensitive_slow_cps_multiplier_property)

cdef int selected_insensitive_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(419, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_spacing
    return 0

register_property_function("selected_insensitive_spacing", selected_insensitive_spacing_property)

cdef int selected_insensitive_strikethrough_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(420, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_strikethrough
    return 0

register_property_function("selected_insensitive_strikethrough", selected_insensitive_strikethrough_property)

cdef int selected_insensitive_subpixel_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(421, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_subpixel
    return 0

register_property_function("selected_insensitive_subpixel", selected_insensitive_subpixel_property)

cdef int selected_insensitive_subtitle_width_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(422, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_subtitle_width
    return 0

register_property_function("selected_insensitive_subtitle_width", selected_insensitive_subtitle_width_property)

cdef int selected_insensitive_text_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(423, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_text_align
    return 0

register_property_function("selected_insensitive_text_align", selected_insensitive_text_align_property)

cdef int selected_insensitive_text_y_fudge_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(424, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_text_y_fudge
    return 0

register_property_function("selected_insensitive_text_y_fudge", selected_insensitive_text_y_fudge_property)

cdef int selected_insensitive_textshader_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(425, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_textshader
    return 0

register_property_function("selected_insensitive_textshader", selected_insensitive_textshader_property)

cdef int selected_insensitive_thumb_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(426, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_thumb
    return 0

register_property_function("selected_insensitive_thumb", selected_insensitive_thumb_property)

cdef int selected_insensitive_thumb_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(427, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_thumb_align
    return 0

register_property_function("selected_insensitive_thumb_align", selected_insensitive_thumb_align_property)

cdef int selected_insensitive_thumb_offset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(428, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_thumb_offset
    return 0

register_property_function("selected_insensitive_thumb_offset", selected_insensitive_thumb_offset_property)

cdef int selected_insensitive_thumb_shadow_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(429, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_thumb_shadow
    return 0

register_property_function("selected_insensitive_thumb_shadow", selected_insensitive_thumb_shadow_property)

cdef int selected_insensitive_time_policy_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(430, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_time_policy
    return 0

register_property_function("selected_insensitive_time_policy", selected_insensitive_time_policy_property)

cdef int selected_insensitive_top_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(431, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_top_margin
    return 0

register_property_function("selected_insensitive_top_margin", selected_insensitive_top_margin_property)

cdef int selected_insensitive_top_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(432, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_top_padding
    return 0

register_property_function("selected_insensitive_top_padding", selected_insensitive_top_padding_property)

cdef int selected_insensitive_underline_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(433, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_underline
    return 0

register_property_function("selected_insensitive_underline", selected_insensitive_underline_property)

cdef int selected_insensitive_unscrollable_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(434, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_unscrollable
    return 0

register_property_function("selected_insensitive_unscrollable", selected_insensitive_unscrollable_property)

cdef int selected_insensitive_vertical_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(435, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_vertical
    return 0

register_property_function("selected_insensitive_vertical", selected_insensitive_vertical_property)

cdef int selected_insensitive_xanchor_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    v = expand_anchor(value)
    assign(436, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xanchor
    return 0

register_property_function("selected_insensitive_xanchor", selected_insensitive_xanchor_property)

cdef int selected_insensitive_xfill_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(437, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_xfill
    return 0

register_property_function("selected_insensitive_xfill", selected_insensitive_xfill_property)

cdef int selected_insensitive_xfit_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(438, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_xfit
    return 0

register_property_function("selected_insensitive_xfit", selected_insensitive_xfit_property)

cdef int selected_insensitive_xmaximum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(439, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_xmaximum
    return 0

register_property_function("selected_insensitive_xmaximum", selected_insensitive_xmaximum_property)

cdef int selected_insensitive_xminimum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    v = none_is_0(value)
    assign(440, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xminimum
    return 0

register_property_function("selected_insensitive_xminimum", selected_insensitive_xminimum_property)

cdef int selected_insensitive_xoffset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(441, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_xoffset
    return 0

register_property_function("selected_insensitive_xoffset", selected_insensitive_xoffset_property)

cdef int selected_insensitive_xpos_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(442, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_xpos
    return 0

register_property_function("selected_insensitive_xpos", selected_insensitive_xpos_property)

cdef int selected_insensitive_xspacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(443, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_xspacing
    return 0

register_property_function("selected_insensitive_xspacing", selected_insensitive_xspacing_property)

cdef int selected_insensitive_yanchor_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    v = expand_anchor(value)
    assign(444, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yanchor
    return 0

register_property_function("selected_insensitive_yanchor", selected_insensitive_yanchor_property)

cdef int selected_insensitive_yfill_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(445, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_yfill
    return 0

register_property_function("selected_insensitive_yfill", selected_insensitive_yfill_property)

cdef int selected_insensitive_yfit_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(446, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_yfit
    return 0

register_property_function("selected_insensitive_yfit", selected_insensitive_yfit_property)

cdef int selected_insensitive_ymaximum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(447, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_ymaximum
    return 0

register_property_function("selected_insensitive_ymaximum", selected_insensitive_ymaximum_property)

cdef int selected_insensitive_yminimum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    v = none_is_0(value)
    assign(448, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yminimum
    return 0

register_property_function("selected_insensitive_yminimum", selected_insensitive_yminimum_property)

cdef int selected_insensitive_yoffset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(449, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_yoffset
    return 0

register_property_function("selected_insensitive_yoffset", selected_insensitive_yoffset_property)

cdef int selected_insensitive_ypos_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 7

    assign(450, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_ypos
    return 0

register_property_function("selected_insensitive_ypos", selected_insensitive_ypos_property)

cdef int selected_insensitive_yspacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(451, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_yspacing
    return 0

register_property_function("selected_insensitive_yspacing", selected_insensitive_yspacing_property)

cdef int selected_insensitive_margin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(393, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_left_margin

    v = index_1(value)
    assign(431, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_top_margin

    v = index_2_or_0(value)
    assign(409, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_right_margin

    v = index_3_or_1(value)
    assign(353, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_bottom_margin
    return 0

register_property_function("selected_insensitive_margin", selected_insensitive_margin_property)

cdef int selected_insensitive_xmargin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(393, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_left_margin

    assign(409, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_right_margin
    return 0

register_property_function("selected_insensitive_xmargin", selected_insensitive_xmargin_property)

cdef int selected_insensitive_ymargin_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(431, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_top_margin

    assign(353, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_bottom_margin
    return 0

register_property_function("selected_insensitive_ymargin", selected_insensitive_ymargin_property)

cdef int selected_insensitive_xalign_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(442, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_xpos

    v = expand_anchor(value)
    assign(436, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xanchor
    return 0

register_property_function("selected_insensitive_xalign", selected_insensitive_xalign_property)

cdef int selected_insensitive_yalign_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(450, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_ypos

    v = expand_anchor(value)
    assign(444, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yanchor
    return 0

register_property_function("selected_insensitive_yalign", selected_insensitive_yalign_property)

cdef int selected_insensitive_padding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(394, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_left_padding

    v = index_1(value)
    assign(432, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_top_padding

    v = index_2_or_0(value)
    assign(410, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_right_padding

    v = index_3_or_1(value)
    assign(354, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_bottom_padding
    return 0

register_property_function("selected_insensitive_padding", selected_insensitive_padding_property)

cdef int selected_insensitive_xpadding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(394, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_left_padding

    assign(410, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_right_padding
    return 0

register_property_function("selected_insensitive_xpadding", selected_insensitive_xpadding_property)

cdef int selected_insensitive_ypadding_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(432, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_top_padding

    assign(354, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_bottom_padding
    return 0

register_property_function("selected_insensitive_ypadding", selected_insensitive_ypadding_property)

cdef int selected_insensitive_minwidth_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(398, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_min_width
    return 0

register_property_function("selected_insensitive_minwidth", selected_insensitive_minwidth_property)

cdef int selected_insensitive_textalign_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(423, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_text_align
    return 0

register_property_function("selected_insensitive_textalign", selected_insensitive_textalign_property)

cdef int selected_insensitive_slow_speed_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(417, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_slow_cps
    return 0

register_property_function("selected_insensitive_slow_speed", selected_insensitive_slow_speed_property)

cdef int selected_insensitive_enable_hover_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6
    return 0

register_property_function("selected_insensitive_enable_hover", selected_insensitive_enable_hover_property)

cdef int selected_insensitive_left_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(378, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_fore_gutter
    return 0

register_property_function("selected_insensitive_left_gutter", selected_insensitive_left_gutter_property)

cdef int selected_insensitive_right_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(342, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_aft_gutter
    return 0

register_property_function("selected_insensitive_right_gutter", selected_insensitive_right_gutter_property)

cdef int selected_insensitive_top_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(378, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_fore_gutter
    return 0

register_property_function("selected_insensitive_top_gutter", selected_insensitive_top_gutter_property)

cdef int selected_insensitive_bottom_gutter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(342, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_aft_gutter
    return 0

register_property_function("selected_insensitive_bottom_gutter", selected_insensitive_bottom_gutter_property)

cdef int selected_insensitive_left_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(377, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_fore_bar
    return 0

register_property_function("selected_insensitive_left_bar", selected_insensitive_left_bar_property)

cdef int selected_insensitive_right_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(341, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_aft_bar
    return 0

register_property_function("selected_insensitive_right_bar", selected_insensitive_right_bar_property)

cdef int selected_insensitive_top_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(377, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_fore_bar
    return 0

register_property_function("selected_insensitive_top_bar", selected_insensitive_top_bar_property)

cdef int selected_insensitive_bottom_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(341, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_aft_bar
    return 0

register_property_function("selected_insensitive_bottom_bar", selected_insensitive_bottom_bar_property)

cdef int selected_insensitive_base_bar_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_null(value)
    assign_prefixed(377, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_fore_bar

    v = none_is_null(value)
    assign_prefixed(341, cache, cache_priorities, priority, v, 'selected_insensitive_') # selected_insensitive_aft_bar
    return 0

register_property_function("selected_insensitive_base_bar", selected_insensitive_base_bar_property)

cdef int selected_insensitive_box_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(419, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_spacing
    return 0

register_property_function("selected_insensitive_box_spacing", selected_insensitive_box_spacing_property)

cdef int selected_insensitive_box_first_spacing_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(371, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_first_spacing
    return 0

register_property_function("selected_insensitive_box_first_spacing", selected_insensitive_box_first_spacing_property)

cdef int selected_insensitive_pos_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(442, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xpos

    v = index_1(value)
    assign(450, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_ypos
    return 0

register_property_function("selected_insensitive_pos", selected_insensitive_pos_property)

cdef int selected_insensitive_anchor_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    v = expand_anchor(v)
    assign(436, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xanchor

    v = index_1(value)
    v = expand_anchor(v)
    assign(444, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yanchor
    return 0

register_property_function("selected_insensitive_anchor", selected_insensitive_anchor_property)

cdef int selected_insensitive_offset_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(441, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xoffset

    v = index_1(value)
    assign(449, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yoffset
    return 0

register_property_function("selected_insensitive_offset", selected_insensitive_offset_property)

cdef int selected_insensitive_align_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(442, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xpos

    v = index_1(value)
    assign(450, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_ypos

    v = index_0(value)
    v = expand_anchor(v)
    assign(436, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xanchor

    v = index_1(value)
    v = expand_anchor(v)
    assign(444, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yanchor
    return 0

register_property_function("selected_insensitive_align", selected_insensitive_align_property)

cdef int selected_insensitive_maximum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(439, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xmaximum

    v = index_1(value)
    assign(447, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_ymaximum
    return 0

register_property_function("selected_insensitive_maximum", selected_insensitive_maximum_property)

cdef int selected_insensitive_minimum_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    v = none_is_0(v)
    assign(440, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xminimum

    v = index_1(value)
    v = none_is_0(v)
    assign(448, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yminimum
    return 0

register_property_function("selected_insensitive_minimum", selected_insensitive_minimum_property)

cdef int selected_insensitive_xsize_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_0(value)
    assign(440, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xminimum

    assign(439, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_xmaximum
    return 0

register_property_function("selected_insensitive_xsize", selected_insensitive_xsize_property)

cdef int selected_insensitive_ysize_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = none_is_0(value)
    assign(448, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yminimum

    assign(447, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_ymaximum
    return 0

register_property_function("selected_insensitive_ysize", selected_insensitive_ysize_property)

cdef int selected_insensitive_xysize_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    v = none_is_0(v)
    assign(440, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xminimum

    v = index_0(value)
    assign(439, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xmaximum

    v = index_1(value)
    v = none_is_0(v)
    assign(448, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yminimum

    v = index_1(value)
    assign(447, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_ymaximum
    return 0

register_property_function("selected_insensitive_xysize", selected_insensitive_xysize_property)

cdef int selected_insensitive_area_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(442, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xpos

    v = index_1(value)
    assign(450, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_ypos

    v = 0
    v = expand_anchor(v)
    assign(436, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xanchor

    v = 0
    v = expand_anchor(v)
    assign(444, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yanchor

    v = True
    assign(437, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xfill

    v = True
    assign(445, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yfill

    v = index_2(value)
    assign(439, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xmaximum

    v = index_3(value)
    assign(447, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_ymaximum

    v = index_2(value)
    v = none_is_0(v)
    assign(440, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xminimum

    v = index_3(value)
    v = none_is_0(v)
    assign(448, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yminimum
    return 0

register_property_function("selected_insensitive_area", selected_insensitive_area_property)

cdef int selected_insensitive_xcenter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(442, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_xpos

    v = 0.5
    v = expand_anchor(v)
    assign(436, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xanchor
    return 0

register_property_function("selected_insensitive_xcenter", selected_insensitive_xcenter_property)

cdef int selected_insensitive_ycenter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    assign(450, cache, cache_priorities, priority, <PyObject *> value) # selected_insensitive_ypos

    v = 0.5
    v = expand_anchor(v)
    assign(444, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yanchor
    return 0

register_property_function("selected_insensitive_ycenter", selected_insensitive_ycenter_property)

cdef int selected_insensitive_xycenter_property(PyObject **cache, int *cache_priorities, int priority, object value) except -1:
    priority += 6

    v = index_0(value)
    assign(442, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xpos

    v = index_1(value)
    assign(450, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_ypos

    v = 0.5
    v = expand_anchor(v)
    assign(436, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_xanchor

    v = 0.5
    v = expand_anchor(v)
    assign(444, cache, cache_priorities, priority, <PyObject *> v) # selected_insensitive_yanchor
    return 0

register_property_function("selected_insensitive_xycenter", selected_insensitive_xycenter_property)

