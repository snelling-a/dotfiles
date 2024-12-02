---@type Wezterm
_G.Wezterm = require("wezterm")

local const = require("const")
local font = require("font")
local keys = require("keys")

require("events")
require("right-status")
require("tabs")

local M = {}

if Wezterm.config_builder then
	M = Wezterm.config_builder()
end

M.audible_bell = "Disabled"
M.check_for_updates = false
M.color_scheme = const.color_scheme
M.colors = {
	visual_bell = const.colors.base00,
	tab_bar = {
		active_tab = {
			bg_color = const.colors.base02,
			fg_color = const.colors.base02,
			intensity = "Bold",
		},
		background = const.colors.base01,
		inactive_tab = {
			bg_color = const.colors.base01,
			fg_color = const.colors.base01,
			intensity = "Half",
		},
		inactive_tab_hover = {
			bg_color = const.colors.base02,
			fg_color = const.colors.base02,
			italic = false,
		},
	},
}
M.disable_default_key_bindings = true
M.font = font.font
M.font_size = font.font_size
M.hide_tab_bar_if_only_one_tab = true
M.hyperlink_rules = Wezterm.default_hyperlink_rules()
M.key_tables = keys.key_tables
M.keys = keys.keys
M.leader = keys.leader
M.macos_window_background_blur = 20
M.send_composed_key_when_right_alt_is_pressed = false
M.show_new_tab_button_in_tab_bar = false
M.switch_to_last_active_tab_when_closing_tab = true
M.tab_max_width = 25
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
	regex = [[[\"]?([%w%d]{1}[-%w%d]+)(/){1}([-%w%d%.]+)[\"]?]],
})

return M
