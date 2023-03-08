local wezterm = require("wezterm")

local color_scheme = "Default Dark (base16)"
local default_colors = wezterm.color.get_builtin_schemes()[color_scheme]

return {
	color_scheme = color_scheme,
	default_colors = default_colors,
}
