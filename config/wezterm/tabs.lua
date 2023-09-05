local wezterm = require("wezterm")
local colors = require("const").colors
local nerdfonts = wezterm.nerdfonts

local function get_basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function get_process(tab)
	if string.match(tab.active_pane.title, "Copy mode:") then
		return nerdfonts.oct_copy
	end

	local process = get_basename(tab.active_pane.foreground_process_name)
	local icon = require("const").process_icons[process]

	local fallback = {
		{
			Foreground = {
				Color = colors.foreground,
			},
		},
		{
			Text = string.format("[%s]", process or "zsh"),
		},
	}

	return wezterm.format(icon or fallback)
end

local function get_current_working_dir(tab)
	local current_dir = (tab.active_pane.current_working_dir or {}).path
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and nerdfonts.md_tilde or string.format(" %s", get_basename(current_dir))
end

---@diagnostic disable-next-line: unused-local
wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, _max_width)
	local zoomed = tab.active_pane.is_zoomed and wezterm.pad_left(nerdfonts.md_magnify, 3) or ""

	return wezterm.format({
		{
			Text = " " .. get_process(tab),
		},
		{
			Foreground = {
				Color = colors.foreground,
			},
		},
		{
			Text = get_current_working_dir(tab),
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
