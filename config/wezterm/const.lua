local wezterm = require("wezterm")

local color_scheme = "Default Dark (base16)"
local default_colors = wezterm.color.get_builtin_schemes()[color_scheme]
local nerdfonts = wezterm.nerdfonts

local M = {}

--- @type table<string,string>
M.colors = {
	base00 = default_colors.ansi[1], -- #181818 default background
	base01 = default_colors.indexed[18], --#282828 lighter background
	base02 = default_colors.indexed[19], --#383838 selection background
	base03 = default_colors.brights[1], -- #585858 comments, invisibles, line highlighting, etc.
	base04 = default_colors.indexed[20], -- #b8b8b8 dark foreground (status bars)
	base05 = default_colors.ansi[8], -- #d8d8d8 default foreground, caret, delimiters, operators, etc.
	base06 = default_colors.indexed[21], -- #e8e8e8 light foreground (status bars)
	base07 = default_colors.brights[8], -- #f8f8f8 light background (status bars)
	base08 = default_colors.ansi[2], -- #ab4642 variables, XML tags, markup link text, markup lists, diff deleted
	base09 = default_colors.indexed[16], -- #dc9656 integers, boolean, constants, XML attributes, markup link url
	base0A = default_colors.ansi[4], -- #f7ca88 classes, markup bold, search text background
	base0B = default_colors.ansi[3], -- #a1b56c strings, inherited class, markup code, diff inserted
	base0C = default_colors.ansi[7], -- #86c1b9 support, regular expressions, escape characters, markup quotes
	base0D = default_colors.ansi[5], -- #7cafc2 functions, methods, attribute IDs, headings
	base0E = default_colors.ansi[6], -- #ba8baf keywords, storage, selector, markup italic, diff changed
	base0F = default_colors.indexed[17], -- #a16946 deprecated, opening/closing embedded language tags, e.g. <?php ?>
}

local function get_process_icon(color, text)
	return {
		{
			Foreground = {
				Color = color,
			},
		},
		{
			Text = wezterm.pad_right(text, 3),
		},
	}
end

M.process_icons = {
	bash = get_process_icon(M.colors.base03, nerdfonts.cod_terminal_bash),
	bat = get_process_icon(M.colors.base03, nerdfonts.md_bat),
	btm = get_process_icon(M.colors.base0E, nerdfonts.cod_pie_chart),
	cargo = get_process_icon(M.colors.base08, nerdfonts.dev_rust),
	colima = get_process_icon(M.colors.base0D, nerdfonts.dev_docker),
	curl = get_process_icon(M.colors.base0C, nerdfonts.oct_download),
	docker = get_process_icon(M.colors.base0D, nerdfonts.dev_docker),
	gh = get_process_icon(M.colors.base05, nerdfonts.dev_github_badge),
	git = get_process_icon(M.colors.base08, nerdfonts.dev_git),
	go = get_process_icon(M.colors.base0C, nerdfonts.dev_go),
	lazygit = get_process_icon(M.colors.base08, nerdfonts.dev_git),
	lf = get_process_icon(M.colors.base0D, nerdfonts.cod_list_tree),
	lua = get_process_icon(M.colors.base0D, nerdfonts.seti_lua),
	node = get_process_icon(M.colors.base0B, nerdfonts.md_nodejs),
	nvim = get_process_icon(M.colors.base0B, nerdfonts.custom_vim),
	onefetch = get_process_icon(M.colors.base08, nerdfonts.dev_git),
	ruby = get_process_icon(M.colors.base08, nerdfonts.dev_ruby),
	spotify_player = get_process_icon(M.colors.base0B, nerdfonts.md_spotify),
	tig = get_process_icon(M.colors.base08, nerdfonts.dev_git),
	tmux = get_process_icon(M.colors.base0B, nerdfonts.cod_terminal_tmux),
	vim = get_process_icon(M.colors.base0B, nerdfonts.dev_vim),
	wget = get_process_icon(M.colors.base0C, nerdfonts.oct_download),
	yarn = get_process_icon(M.colors.base0C, nerdfonts.seti_yarn),
	zsh = get_process_icon(M.colors.base08, nerdfonts.dev_terminal),
}

return M
