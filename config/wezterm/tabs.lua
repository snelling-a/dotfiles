local wezterm = require("wezterm")
local colors = require("const").colors
local nerdfonts = wezterm.nerdfonts

local function get_basename(s)
	return s:gsub("(.*[/\\])(.*)", "%2")
end

local function get_process(pane)
	local title = pane.title or "zsh"

	if title:match("Copy mode:") then
		return nerdfonts.oct_copy
	end

	local icon = require("const").process_icons[title]

	local fallback = {
		{
			Foreground = {
				Color = colors.foreground,
			},
		},
		{
			Text = ("[%s]"):format(title),
		},
	}

	return wezterm.format(icon or fallback)
end

local function get_current_working_dir(tab)
	local current_dir = (tab.current_working_dir or {}).path or ""
	local HOME_DIR = os.getenv("HOME")

	return current_dir == HOME_DIR and nerdfonts.md_tilde or (" %s"):format(get_basename(current_dir))
end

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, _max_width)
	local zoomed = tab.active_pane.is_zoomed and wezterm.pad_left(nerdfonts.md_magnify, 2) or ""

	return wezterm.format({
		{
			Text = " " .. get_process(tab.active_pane),
		},
		{
			Foreground = {
				Color = colors.foreground,
			},
		},
		{
			Text = get_current_working_dir(tab.active_pane),
		},
		"ResetAttributes",
		{
			Text = zoomed,
		},
		{
			Text = " ▕",
		},
	})
end)
