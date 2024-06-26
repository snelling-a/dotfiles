local wezterm = require("wezterm")
local nerdfonts = wezterm.nerdfonts

local function scheme_for_appearance()
	local appearance = wezterm.gui and wezterm.gui.get_appearance() or "Dark"

	return "Default " .. appearance .. " (base16)"
end

local M = {}

M.color_scheme = scheme_for_appearance()
local default_colors = wezterm.color.get_builtin_schemes()[M.color_scheme]

--- @type table<string,string>
M.colors = {
	base00 = default_colors.ansi[1], -- default background
	base01 = default_colors.indexed[18], -- lighter background
	base02 = default_colors.indexed[19], -- selection background
	base03 = default_colors.brights[1], -- comments, invisibles, line highlighting, etc.
	base04 = default_colors.indexed[20], -- dark foreground (status bars)
	base05 = default_colors.ansi[8], -- default foreground, caret, delimiters, operators, etc.
	base06 = default_colors.indexed[21], -- light foreground (status bars)
	base07 = default_colors.brights[8], -- light background (status bars)
	base08 = default_colors.ansi[2], -- variables, XML tags, markup link text, markup lists, diff deleted
	base09 = default_colors.indexed[16], -- integers, boolean, constants, XML attributes, markup link url
	base0A = default_colors.ansi[4], -- classes, markup bold, search text background
	base0B = default_colors.ansi[3], -- strings, inherited class, markup code, diff inserted
	base0C = default_colors.ansi[7], -- support, regular expressions, escape characters, markup quotes
	base0D = default_colors.ansi[5], -- functions, methods, attribute IDs, headings
	base0E = default_colors.ansi[6], -- keywords, storage, selector, markup italic, diff changed
	base0F = default_colors.indexed[17], -- deprecated, opening/closing embedded language tags, e.g. <?php ?>
}

---@alias Color {Foreground:{Color:string}}
---@alias Text {Text:string}
---@param color string
---@param text string
---@return table<Color,Text>
local function get_process_icon(color, text)
	return {
		{
			Foreground = { Color = color },
		},
		{ Text = wezterm.pad_right(text, 3) },
	}
end

M.process_icons = {
	bash = get_process_icon(M.colors.base03, nerdfonts.cod_terminal_bash),
	bat = get_process_icon(M.colors.base00, nerdfonts.md_bat),
	btm = get_process_icon(M.colors.base0E, nerdfonts.md_chart_bar_stacked),
	cargo = get_process_icon(M.colors.base08, nerdfonts.dev_rust),
	colima = get_process_icon(M.colors.base0D, nerdfonts.dev_docker),
	curl = get_process_icon(M.colors.base0C, nerdfonts.oct_download),
	docker = get_process_icon(M.colors.base0D, nerdfonts.dev_docker),
	gh = get_process_icon(M.colors.base05, nerdfonts.oct_mark_github),
	git = get_process_icon(M.colors.base08, nerdfonts.dev_git),
	glow = get_process_icon(M.colors.base0D, nerdfonts.dev_markdown),
	go = get_process_icon(M.colors.base0C, nerdfonts.dev_go),
	lazygit = get_process_icon(M.colors.base08, nerdfonts.dev_git),
	lf = get_process_icon(M.colors.base0D, nerdfonts.md_file_tree),
	lua = get_process_icon(M.colors.base0D, nerdfonts.md_language_lua),
	node = get_process_icon(M.colors.base0B, nerdfonts.dev_nodejs_small),
	nvim = get_process_icon(M.colors.base0D, nerdfonts.custom_neovim),
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
