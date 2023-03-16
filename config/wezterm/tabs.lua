local wezterm = require("wezterm")
local process_icons = require("const").process_icons
local colors = require("const").colors

local function basename(s) return string.gsub(s, "(.*[/\\])(.*)", "%2") end

local function get_process(title)
	if title == "" then
		title = "zsh"
	end

	return wezterm.format(
		process_icons[title]
			or { { Foreground = { Color = colors.foreground } }, { Text = string.format("[%s]", title) } }
	)
end

wezterm.on("format-tab-title", function(tab, tabs, _panes, _config, _hover, _max_width)
	local tab_index = tab.tab_index + 1
	local index_string = tostring(tab_index)
	if #tabs > 1 then
		index_string = string.format("[%d/%d] ", tab_index, #tabs)
	end

	local title = basename(tab.active_pane.foreground_process_name)

	if tab.is_active and string.match(tab.active_pane.title, "Copy mode:") ~= nil then
		return tab_index .. " " .. "Copy mode..."
	end

	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "󰍉"
	end

	return wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Text = string.format(" %s", index_string) },
		"ResetAttributes",
		{ Text = get_process(title) },
		{ Text = string.format(" %s%s", title, zoomed) },
		{ Foreground = { Color = colors.foreground } },
		{ Text = " ▕" },
	})
end)
