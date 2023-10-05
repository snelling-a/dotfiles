local font = require("font")
local keys = require("keys")
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
M.color_scheme = "Default Dark (base16)"
M.colors = {
	visual_bell = colors.background,
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
M.switch_to_last_active_tab_when_closing_tab = true
M.term = "wezterm"
M.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 70,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 70,
}
M.window_background_opacity = 0.5
M.window_close_confirmation = "NeverPrompt"
M.window_decorations = "RESIZE"
M.window_frame = {
	font_size = 15,
	active_titlebar_bg = colors.background,
}
M.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- github user/repo
table.insert(M.hyperlink_rules, {
	regex = [[["'\s]([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["'\s]] .. "]",
	format = "https://www.github.com/$1/$3",
})

return M
