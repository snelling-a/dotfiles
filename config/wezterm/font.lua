local wezterm = require("wezterm")

local font = "Iosevka Term SS15"
local icon_font = {
	family = "Symbols Nerd Font Mono",
}

return {
	font = wezterm.font_with_fallback({
		{
			family = font,
			assume_emoji_presentation = false,
		},
		icon_font,
		use_cap_height_to_scale_fallback_fonts = true,
	}),
	font_size = 16.0,
	font_rules = {},
}
