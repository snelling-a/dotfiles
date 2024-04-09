local wezterm = require("wezterm")

local M = {}

M.font = wezterm.font_with_fallback({
	{ family = "Iosevka Term SS15" },
	{ family = "Symbols Nerd Font Mono" },
	{ family = "termicons" },
})

M.font_size = 16.0

return M
