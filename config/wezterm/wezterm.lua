local font = require("font")
local keys = require("keys")
local wezterm = require("wezterm")
local colors = require("const").colors

require("events")
require("right-status")
require("tabs")

local Config = {}

if wezterm.config_builder then
	Config = wezterm.config_builder()
end

Config.audible_bell = "Disabled"
Config.color_scheme = "Default Dark (base16)"
Config.colors = {
	visual_bell = colors.background,
}
Config.disable_default_key_bindings = true
Config.font = font.font
Config.font_rules = font.font_rules
Config.font_size = font.font_size
Config.hide_tab_bar_if_only_one_tab = true
Config.hyperlink_rules = wezterm.default_hyperlink_rules()
Config.key_tables = keys.key_tables
Config.keys = keys.keys
Config.leader = keys.leader
Config.macos_window_background_blur = 20
Config.switch_to_last_active_tab_when_closing_tab = true
Config.term = "wezterm"
Config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 70,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 70,
}
Config.window_background_opacity = 0.5
Config.window_close_confirmation = "NeverPrompt"
Config.window_decorations = "RESIZE"
Config.window_frame = {
	font_size = 15,
	active_titlebar_bg = colors.background,
}
Config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- github user/repo
table.insert(Config.hyperlink_rules, {
	regex = [[["'\s]([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["'\s]] .. "]",
	format = "https://www.github.com/$1/$3",
})

return Config
