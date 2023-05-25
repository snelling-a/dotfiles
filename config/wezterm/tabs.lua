local wezterm = require("wezterm")
local process_icons = require("const").process_icons
local colors = require("const").colors

local function basename(s) return string.gsub(s, "(.*[/\\])(.*)", "%2") end

local function get_process(t)
	local title = t or "zsh"

	return wezterm.format(
		process_icons[title]
			or { { Foreground = { Color = colors.foreground } }, { Text = string.format("[%s]", title) } }
	)
end

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "  ~" or string.format(" %s", string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, _max_width)
	local tab_index = tab.tab_index + 1

	local title = basename(tab.active_pane.foreground_process_name)

	if tab.is_active and string.match(tab.active_pane.title, "Copy mode:") ~= nil then
		return tab_index .. " " .. "Copy mode..."
	end

	local zoomed = tab.active_pane.is_zoomed and "󰍉" or ""

	return wezterm.format({
		{ Text = " " .. get_process(title) },
		{ Foreground = { Color = colors.foreground } },
		{ Text = get_current_working_dir(tab) },
		"ResetAttributes",
		{ Text = " " .. zoomed },
		{ Text = " ▕" },
	})
end)

return {}
