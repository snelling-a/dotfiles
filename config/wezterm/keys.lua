local wezterm = require("wezterm")
local act = wezterm.action
local Keys = {}
local tab_keys = {}
for i = 1, 8 do
	table.insert(tab_keys, {
		key = tostring(i),
		mods = "SUPER",
		action = act.ActivateTab(i - 1),
	})
	table.insert(tab_keys, {
		key = "F" .. tostring(i),
		action = act.ActivateTab(i - 1),
	})
end
Keys.keys = {
	{ key = "+", mods = "SUPER|SHIFT", action = act.IncreaseFontSize },
	{ key = "-", mods = "SUPER|SHIFT", action = act.DecreaseFontSize },
	{ key = "0", mods = "SUPER", action = act.ResetFontSize },
	{ key = "DownArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "LeftArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "Space", mods = "LEADER", action = act.RotatePanes("Clockwise") },
	{ key = "Space", mods = "LEADER|SHIFT", action = act.RotatePanes("CounterClockwise") },
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "UpArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "b", mods = "CTRL|SHIFT", action = act.EmitEvent("toggle-opacity") },
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
	{ key = "e", mods = "CTRL|SHIFT", action = act.EmitEvent("toggle-ligature") },
	{ key = "f", mods = "SUPER", action = act.Search({ CaseInSensitiveString = "" }) },
	{ key = "h", mods = "CTRL|SHIFT", action = act.Search({ Regex = "[a-f0-9]{6,}" }) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "h", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "j", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "k", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{
		key = "k",
		mods = "SUPER",
		action = act.Multiple({
			act.ClearScrollback("ScrollbackAndViewport"),
			act.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
	{ key = "l", mods = "ALT", action = act.ShowLauncher },
	{ key = "l", mods = "ALT|SHIFT", action = act.ShowDebugOverlay },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "l", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "m", mods = "CMD", action = act.DisableDefaultAssignment },
	{ key = "q", mods = "LEADER", action = act.PaneSelect({ mode = "SwapWithActive" }) },
	{ key = "q", mods = "SUPER", action = act.QuitApplication },
	{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
	{ key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "x", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	-- KEY TABLES
	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

	table.unpack(tab_keys),
}

local resize_pane = {
	{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "Escape", action = "PopKeyTable" },
	{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
}

local copy_mode_remap = {
	{ key = "b", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
	{ key = "h", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
	{ key = "l", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
	{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
	{ key = "y", mods = "NONE", action = act.CopyTo("ClipboardAndPrimarySelection") },
}

local copy_mode = nil
if wezterm.gui then
	copy_mode = wezterm.gui.default_key_tables().copy_mode
end

for key, _ in ipairs(copy_mode_remap) do
	table.insert(copy_mode, copy_mode_remap[key])
end

Keys.key_tables = {
	copy_mode = copy_mode,
	resize_pane = resize_pane,
}

Keys.disable_default_key_bindings = true

Keys.leader = { key = "a", mods = "CTRL" }

return Keys
