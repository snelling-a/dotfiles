local font = require("font")
local keys = require("keys") --[[@as table]]
local wezterm = require("wezterm")
local colors = require("const").colors

require("events")
require("right-status")
require("tabs")

local M = {}

if wezterm.config_builder then
	M = wezterm.config_builder()
end

M.audible_bell = "Disabled"
M.check_for_updates = false
M.color_scheme = "Default Dark (base16)"
M.colors = {
	visual_bell = colors.base00,
	tab_bar = {
		active_tab = {
			bg_color = colors.base02,
			fg_color = colors.base02,
			intensity = "Bold",
		},
		background = colors.base01,
		inactive_tab = {
			bg_color = colors.base01,
			fg_color = colors.base01,
			intensity = "Half",
		},
		inactive_tab_hover = {
			bg_color = colors.base02,
			fg_color = colors.base02,
			italic = false,
		},
	},
}
M.disable_default_key_bindings = true
M.font = font.font
M.font_rules = font.font_rules
M.font_size = font.font_size
M.hide_tab_bar_if_only_one_tab = true
M.hyperlink_rules = wezterm.default_hyperlink_rules()
M.key_tables = keys.key_tables
M.keys = keys.keys
M.leader = keys.leader
M.macos_window_background_blur = 20
M.send_composed_key_when_right_alt_is_pressed = false
M.show_new_tab_button_in_tab_bar = false
M.show_update_window = false
M.switch_to_last_active_tab_when_closing_tab = true
M.term = "wezterm"
M.use_fancy_tab_bar = false
M.visual_bell = {
	fade_in_duration_ms = 70,
	fade_in_function = "EaseIn",
	fade_out_duration_ms = 70,
	fade_out_function = "EaseOut",
}
M.window_background_opacity = 0.5
M.window_decorations = "RESIZE"
M.window_padding = {
	bottom = 0,
	left = 0,
	right = 0,
	top = 0,
}

-- GitHub user/repo
table.insert(M.hyperlink_rules, {
	format = "https://www.github.com/$1/$3",
	regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
})

return M
