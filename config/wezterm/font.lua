local wezterm = require("wezterm")

local Font = {}

Font.font = wezterm.font_with_fallback({
	{
		family = "Iosevka Term SS15",
	},
	{
		family = "Symbols Nerd Font Mono",
	},
})

Font.font_size = 16.0

return Font
