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
	hyperlink_rules = hyperlink_rules,
	underline_position = -8,
	use_fancy_tab_bar = false,
	window_decorations = "RESIZE",
	window_padding = { bottom = 0, left = 0, right = 0, top = 0 },
}
