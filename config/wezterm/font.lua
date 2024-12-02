local M = {}

---@type table
M.font = Wezterm.font_with_fallback({
	{ family = "Iosevka Term SS15" },
	{ family = "Symbols Nerd Font Mono" },
})

M.font_size = 16.0

return M
