---@class Wezterm.builtin_scheme
---@field ansi table<string>,
---@field background string,
---@field brights table<string>,
---@field cursor_bg string,
---@field cursor_border string,
---@field cursor_fg string,
---@field foreground string,
---@field indexed table<integer,string>,
---@field selection_bg string,
---@field selection_fg string,

local function scheme_for_appearance()
	local appearance = Wezterm.gui and Wezterm.gui.get_appearance() or "Dark"

	return "Default " .. appearance .. " (base16)"
end

local M = {}

M.color_scheme = scheme_for_appearance()
---@type Wezterm.builtin_scheme
local default_colors = Wezterm.color.get_builtin_schemes()[M.color_scheme]

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
---@alias Wezterm.text {Text:string}

---@param color string
---@param text string
---@return table<Color,Wezterm.text>
local function get_process_icon(color, text)
	return {
		{
			Foreground = { Color = color },
		},
		{ Text = Wezterm.pad_right(text, 3) },
	}
end

M.process_icons = {
	bash = get_process_icon(M.colors.base03, Wezterm.nerdfonts.cod_terminal_bash),
	bat = get_process_icon(M.colors.base00, Wezterm.nerdfonts.md_bat),
	btm = get_process_icon(M.colors.base0E, Wezterm.nerdfonts.md_chart_bar_stacked),
	cargo = get_process_icon(M.colors.base08, Wezterm.nerdfonts.dev_rust),
	colima = get_process_icon(M.colors.base0D, Wezterm.nerdfonts.dev_docker),
	curl = get_process_icon(M.colors.base0C, Wezterm.nerdfonts.oct_download),
	deno = get_process_icon(M.colors.base0B, " "),
	docker = get_process_icon(M.colors.base0D, Wezterm.nerdfonts.dev_docker),
	gh = get_process_icon(M.colors.base05, Wezterm.nerdfonts.oct_mark_github),
	git = get_process_icon(M.colors.base08, Wezterm.nerdfonts.dev_git),
	glow = get_process_icon(M.colors.base0D, Wezterm.nerdfonts.dev_markdown),
	go = get_process_icon(M.colors.base0C, Wezterm.nerdfonts.dev_go),
	lazygit = get_process_icon(M.colors.base08, Wezterm.nerdfonts.dev_git),
	lf = get_process_icon(M.colors.base0D, Wezterm.nerdfonts.md_file_tree),
	lua = get_process_icon(M.colors.base0D, Wezterm.nerdfonts.md_language_lua),
	node = get_process_icon(M.colors.base0B, Wezterm.nerdfonts.md_nodejs),
	nvim = get_process_icon(M.colors.base0D, Wezterm.nerdfonts.custom_neovim),
	onefetch = get_process_icon(M.colors.base08, Wezterm.nerdfonts.dev_git),
	ruby = get_process_icon(M.colors.base08, Wezterm.nerdfonts.dev_ruby),
	spotify_player = get_process_icon(M.colors.base0B, Wezterm.nerdfonts.md_spotify),
	tig = get_process_icon(M.colors.base08, Wezterm.nerdfonts.dev_git),
	tmux = get_process_icon(M.colors.base0B, Wezterm.nerdfonts.cod_terminal_tmux),
	vim = get_process_icon(M.colors.base0B, Wezterm.nerdfonts.dev_vim),
	wget = get_process_icon(M.colors.base0C, Wezterm.nerdfonts.oct_download),
	yarn = get_process_icon(M.colors.base0C, Wezterm.nerdfonts.seti_yarn),
	yazi = get_process_icon(M.colors.base0D, Wezterm.nerdfonts.md_file_tree),
	zsh = get_process_icon(M.colors.base08, Wezterm.nerdfonts.dev_terminal),
}

return M
