local colors = require("const").colors

---@param pane table
---@return string
---@return string?
local function get_process(pane)
	local title = pane.title ~= "" and pane.title or "zsh"

	if title:match("Copy mode:") then
		return Wezterm.nerdfonts.oct_copy
	end

	local icon = require("const").process_icons[title]

	local fallback = {
		{
			Foreground = { Color = colors.base04 },
		},
		{ Text = ("[%s]"):format(title) },
	}

	local color = icon and icon[1].Foreground.Color or fallback[1].Foreground.Color
	return color, Wezterm.format(icon or fallback)
end

local function get_current_working_dir(tab)
	local current_dir = (tab.current_working_dir or {}).path or ""
	local home_dir = os.getenv("HOME")
	current_dir = current_dir:gsub("^" .. home_dir, "~"):gsub("work/", ""):gsub("%.worktrees/%w+/", "")

	return current_dir == home_dir and Wezterm.nerdfonts.md_tilde or current_dir:gsub("(.*)/", "%1")
end

Wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, _max_width)
	local zoomed = tab.active_pane.is_zoomed and Wezterm.pad_left(Wezterm.nerdfonts.md_magnify, 2) .. " " or ""
	local color, process = get_process(tab.active_pane)

	return Wezterm.format({
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
