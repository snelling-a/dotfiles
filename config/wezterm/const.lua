local wezterm = require("wezterm")

local color_scheme = "Default Dark (base16)"
local default_colors = wezterm.color.get_builtin_schemes()[color_scheme]
local icons = wezterm.nerdfonts

local Constants = {
	color_scheme = color_scheme,
	default_colors = default_colors,
}

function Constants.pad_right(string) return string.format("%s ", string) end

local colors = {
	background = default_colors.background, -- #181818
	black = default_colors.ansi[1], --#181818
	blue = default_colors.ansi[5], --#7cafc2
	bright_black = default_colors.brights[1], --#585858
	bright_blue = default_colors.brights[5], --#7cafc2
	bright_cyan = default_colors.brights[7], --#86c1b9
	bright_green = default_colors.brights[3], --#a1b56c
	bright_grey = default_colors.brights[8], --#d8d8d8
	bright_magenta = default_colors.brights[6], --#ba8baf
	bright_red = default_colors.brights[2], --#ab4642
	bright_yellow = default_colors.brights[4], --#f7ca88
	brown = default_colors.indexed[17], -- #a16946
	cyan = default_colors.ansi[7], --#86c1b9
	foreground = default_colors.foreground, -- #d8d8d8
	green = default_colors.ansi[3], --#a1b56c
	grey = default_colors.ansi[8], --#d8d8d8
	magenta = default_colors.ansi[6], --#ba8baf
	orange = default_colors.indexed[16], -- #dc9656
	red = default_colors.ansi[2], --#ab4642
	yellow = default_colors.ansi[4], --#f7ca88
}

Constants.colors = colors

Constants.process_icons = {
	["bash"] = {
		{ Foreground = { Color = colors.bright_black } },
		{ Text = Constants.pad_right(icons.cod_terminal_bash) },
	},
	["bat"] = { { Foreground = { Color = colors.bright_black } }, { Text = Constants.pad_right("󰭟") } },
	["btm"] = { { Foreground = { Color = colors.magenta } }, { Text = Constants.pad_right(icons.cod_pie_chart) .. " " } },
	["cargo"] = { { Foreground = { Color = colors.red } }, { Text = Constants.pad_right(icons.dev_rust) } },
	["curl"] = { { Foreground = { Color = colors.cyan } }, { Text = Constants.pad_right(icons.oct_download) } },
	["docker"] = { { Foreground = { Color = colors.blue } }, { Text = Constants.pad_right(icons.dev_docker) } },
	["gh"] = { { Foreground = { Color = colors.grey } }, { Text = Constants.pad_right(icons.dev_github_badge) } },
	["git"] = { { Foreground = { Color = colors.red } }, { Text = Constants.pad_right(icons.dev_git) } },
	["go"] = { { Foreground = { Color = colors.cyan } }, { Text = Constants.pad_right(icons.dev_go) } },
	["lazygit"] = { { Foreground = { Color = colors.red } }, { Text = Constants.pad_right(icons.dev_git) } },
	["lf"] = { { Foreground = { Color = colors.blue } }, { Text = Constants.pad_right(icons.cod_list_tree) } },
	["lua"] = { { Foreground = { Color = colors.blue } }, { Text = Constants.pad_right(icons.seti_lua) } },
	["node"] = { { Foreground = { Color = colors.green } }, { Text = Constants.pad_right("󰎙") } },
	["nvim"] = { { Foreground = { Color = colors.green } }, { Text = Constants.pad_right(icons.custom_vim) } },
	["ruby"] = { { Foreground = { Color = colors.red } }, { Text = Constants.pad_right(icons.dev_ruby) } },
	["tig"] = { { Foreground = { Color = colors.red } }, { Text = Constants.pad_right(icons.dev_git) } },
	["tmux"] = {
		{ Foreground = { Color = colors.bright_green } },
		{ Text = Constants.pad_right(icons.cod_terminal_tmux) },
	},
	["vim"] = { { Foreground = { Color = colors.green } }, { Text = Constants.pad_right(icons.dev_vim) } },
	["wget"] = { { Foreground = { Color = colors.cyan } }, { Text = Constants.pad_right(icons.oct_download) } },
	["yarn"] = { { Foreground = { Color = colors.cyan } }, { Text = Constants.pad_right(icons.seti_yarn) } },
	["zsh"] = { { Foreground = { Color = colors.red } }, { Text = Constants.pad_right(icons.dev_terminal) } },
}

Constants.heart_icons = { full = icons.oct_heart_fill, half_full = "󰛞 ", empty = icons.cod_heart }

Constants.battery_icons = {
	charging = icons.fa_bolt,
	discharging = "󰁹",
	unknown = "󰂑",
	full = "󰂅 ",
}

Constants.override_icons = { blur = "󰂷 ", leader = "󰘳 ", ligature = icons.fae_equal_bigger }

return Constants
