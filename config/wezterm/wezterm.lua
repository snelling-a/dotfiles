local font = require("font")
local keys = require("keys")


local hyperlink_rules = {
	{ regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b", format = "$0" },
	{ regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b", format = "$0" },
	{ regex = [[\bfile://\S*\b]], format = "$0" },
	{ regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = "$0" },
}

return {
	adjust_window_size_when_changing_font_size = false,
	audible_bell = "Disabled",
	automatically_reload_config = true,
	disable_default_key_bindings = keys.disable_default_key_bindings,
	font = font.font,
	font_rules = font.font_rules,
	font_size = font.font_size,
	hyperlink_rules = hyperlink_rules,
	key_tables = keys.key_tables,
	keys = keys.keys,
	leader = keys.leader,
	underline_position = -8,
	use_fancy_tab_bar = false,
	window_decorations = "RESIZE",
	window_padding = { bottom = 0, left = 0, right = 0, top = 0 },
}
