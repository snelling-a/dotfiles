local wezterm = require("wezterm")

local color_scheme = "Default Dark (base16)"
local default_colors = wezterm.color.get_builtin_schemes()[color_scheme]
local nerdfonts = wezterm.nerdfonts

local Constants = {}

function Constants.pad_right(string)
	return wezterm.pad_right(string, 3)
end

Constants.colors = {
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

Constants.process_icons = {
	["bash"] = {
		{
			Foreground = {
				Color = Constants.colors.bright_black,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.cod_terminal_bash),
		},
	},
	["bat"] = {
		{
			Foreground = {
				Color = Constants.colors.bright_black,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.md_bat),
		},
	},
	["btm"] = {
		{
			Foreground = {
				Color = Constants.colors.magenta,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.cod_pie_chart) .. " ",
		},
	},
	["cargo"] = {
		{
			Foreground = {
				Color = Constants.colors.red,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.dev_rust),
		},
	},
	["curl"] = {
		{
			Foreground = {
				Color = Constants.colors.cyan,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.oct_download),
		},
	},
	["docker"] = {
		{
			Foreground = {
				Color = Constants.colors.blue,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.dev_docker),
		},
	},
	["gh"] = {
		{
			Foreground = {
				Color = Constants.colors.grey,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.dev_github_badge),
		},
	},
	["git"] = {
		{
			Foreground = {
				Color = Constants.colors.red,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.dev_git),
		},
	},
	["go"] = {
		{
			Foreground = {
				Color = Constants.colors.cyan,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.dev_go),
		},
	},
	["lazygit"] = {
		{
			Foreground = {
				Color = Constants.colors.red,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.dev_git),
		},
	},
	["lf"] = {
		{
			Foreground = {
				Color = Constants.colors.blue,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.cod_list_tree),
		},
	},
	["lua"] = {
		{
			Foreground = {
				Color = Constants.colors.blue,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.seti_lua),
		},
	},
	["node"] = {
		{
			Foreground = {
				Color = Constants.colors.green,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.md_nodejs),
		},
	},
	["nvim"] = {
		{
			Foreground = {
				Color = Constants.colors.green,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.custom_vim),
		},
	},
	["ruby"] = {
		{
			Foreground = {
				Color = Constants.colors.red,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.dev_ruby),
		},
	},
	["tig"] = {
		{
			Foreground = {
				Color = Constants.colors.red,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.dev_git),
		},
	},
	["tmux"] = {
		{
			Foreground = {
				Color = Constants.colors.bright_green,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.cod_terminal_tmux),
		},
	},
	["vim"] = {
		{
			Foreground = {
				Color = Constants.colors.green,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.dev_vim),
		},
	},
	["wget"] = {
		{
			Foreground = {
				Color = Constants.colors.cyan,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.oct_download),
		},
	},
	["yarn"] = {
		{
			Foreground = {
				Color = Constants.colors.cyan,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.seti_yarn),
		},
	},
	["zsh"] = {
		{
			Foreground = {
				Color = Constants.colors.red,
			},
		},
		{
			Text = Constants.pad_right(nerdfonts.dev_terminal),
		},
	},
}

return Constants
