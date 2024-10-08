local wezterm = require("wezterm")
---@type table<string, string>
local colors = require("const").colors
---@type table<string>
local nerdfonts = wezterm.nerdfonts

local function get_process(pane)
	local title = pane.title or "zsh"

	if title:match("Copy mode:") then
		return nerdfonts.oct_copy
	end

	---@type string
	local icon = require("const").process_icons[title]

	local fallback = {
		{
			Foreground = { Color = colors.base04 },
		},
		{ Text = ("[%s]"):format(title) },
	}

	local color = icon and icon[1].Foreground.Color or fallback[1].Foreground.Color
	return color, wezterm.format(icon or fallback)
end

local function get_current_working_dir(tab)
	local current_dir = (tab.current_working_dir or {}).path or ""
	local HOME_DIR = os.getenv("HOME") .. "/"

	return current_dir == HOME_DIR and nerdfonts.md_tilde or current_dir:gsub(HOME_DIR .. "(.*)/", "%1")
end

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, _max_width)
	local zoomed = tab.active_pane.is_zoomed and wezterm.pad_left(nerdfonts.md_magnify, 2) .. " " or ""
	local color, process = get_process(tab.active_pane)

	return wezterm.format({
		{ Text = " " .. process },
		{
			Foreground = { Color = color },
		},
		{ Text = get_current_working_dir(tab.active_pane) },
		{ Foreground = { Color = colors.base04 } },
		{ Text = zoomed },
		"ResetAttributes",
		{ Text = " ▕" },
	})
end)
