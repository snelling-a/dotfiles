local wezterm = require("wezterm")

local color_scheme = "Default Dark (base16)"
local default_colors = wezterm.color.get_builtin_schemes()[color_scheme]
local nerdfonts = wezterm.nerdfonts

local M = {}

function M.pad_right(string)
	return wezterm.pad_right(string, 3)
end

M.colors = {
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

local function get_process_icon(color, text)
	return {
		{
			Foreground = {
				Color = color,
			},
		},
		{
			Text = M.pad_right(text),
		},
	}
end

M.process_icons = {
	bash = get_process_icon(M.colors.bright_black, nerdfonts.cod_terminal_bash),
	bat = get_process_icon(M.colors.bright_black, nerdfonts.md_bat),
	btm = get_process_icon(M.colors.magenta, nerdfonts.cod_pie_chart),
	cargo = get_process_icon(M.colors.red, nerdfonts.dev_rust),
	colima = get_process_icon(M.colors.blue, nerdfonts.dev_docker),
	curl = get_process_icon(M.colors.cyan, nerdfonts.oct_download),
	docker = get_process_icon(M.colors.blue, nerdfonts.dev_docker),
	gh = get_process_icon(M.colors.grey, nerdfonts.dev_github_badge),
	git = get_process_icon(M.colors.red, nerdfonts.dev_git),
	go = get_process_icon(M.colors.cyan, nerdfonts.dev_go),
	lazygit = get_process_icon(M.colors.red, nerdfonts.dev_git),
	lf = get_process_icon(M.colors.blue, nerdfonts.cod_list_tree),
	lua = get_process_icon(M.colors.blue, nerdfonts.seti_lua),
	node = get_process_icon(M.colors.green, nerdfonts.md_nodejs),
	nvim = get_process_icon(M.colors.green, nerdfonts.custom_vim),
	onefetch = get_process_icon(M.colors.red, nerdfonts.dev_git),
	ruby = get_process_icon(M.colors.red, nerdfonts.dev_ruby),
	spotify_player = get_process_icon(M.colors.green, nerdfonts.md_spotify),
	tig = get_process_icon(M.colors.red, nerdfonts.dev_git),
	tmux = get_process_icon(M.colors.bright_green, nerdfonts.cod_terminal_tmux),
	vim = get_process_icon(M.colors.green, nerdfonts.dev_vim),
	wget = get_process_icon(M.colors.cyan, nerdfonts.oct_download),
	yarn = get_process_icon(M.colors.cyan, nerdfonts.seti_yarn),
	zsh = get_process_icon(M.colors.red, nerdfonts.dev_terminal),
}

return M
