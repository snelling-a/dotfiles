local wezterm = require("wezterm")
local act = wezterm.action

---@param key string
---@param action function|string?
---@param mods string? "LEADER" | "CTRL" | "SHIFT" | "ALT" | "SUPER" | "CMD"
---@return table
local function get_key(key, action, mods)
	return {
		action = action,
		key = key,
		mods = mods,
	}
end

local M = {}

local tab_keys = {}

for i = 1, 8 do
	table.insert(tab_keys, get_key(tostring(i), act.ActivateTab(i - 1), "SUPER"))
end

M.keys = {
	get_key(
		"!",
		wezterm.action_callback(function(_win, pane)
			pane:move_to_new_tab()
		end),
		"LEADER|SHIFT"
	),
	get_key("+", act.IncreaseFontSize, "SUPER|SHIFT"),
	get_key("-", act.DecreaseFontSize, "SUPER|SHIFT"),
	get_key("0", act.ResetFontSize, "SUPER"),
	get_key("DownArrow", act.AdjustPaneSize({ "Down", 5 }), "LEADER"),
	get_key("LeftArrow", act.AdjustPaneSize({ "Left", 5 }), "LEADER"),
	get_key("RightArrow", act.AdjustPaneSize({ "Right", 5 }), "LEADER"),
	get_key("Space", act.RotatePanes("Clockwise"), "LEADER"),
	get_key("Space", act.RotatePanes("CounterClockwise"), "LEADER|SHIFT"),
	get_key("Tab", act.ActivateTabRelative(-1), "CTRL|SHIFT"),
	get_key("Tab", act.ActivateTabRelative(1), "CTRL"),
	get_key("UpArrow", act.AdjustPaneSize({ "Up", 5 }), "LEADER"),
	get_key("[", act.ActivateCopyMode, "LEADER"),
	get_key("a", act.EmitEvent("toggle-leader"), "CTRL|SHIFT"),
	get_key("b", act.EmitEvent("toggle-opacity"), "CTRL|SHIFT"),
	get_key("c", act.CopyTo("Clipboard"), "SUPER"),
	get_key("c", act.SpawnTab("CurrentPaneDomain"), "LEADER"),
	get_key("e", act.EmitEvent("toggle-ligature"), "CTRL|SHIFT"),
	get_key("f", act.Search({ CaseInSensitiveString = "" }), "SUPER"),
	get_key("h", act.ActivatePaneDirection("Left"), "LEADER"),
	get_key("h", act.Search({ Regex = "[a-f0-9]{6,}" }), "CTRL|SHIFT"),
	get_key("j", act.ActivatePaneDirection("Down"), "LEADER"),
	get_key("k", act.ActivatePaneDirection("Up"), "LEADER"),
	get_key(
		"k",
		act.Multiple({ act.ClearScrollback("ScrollbackAndViewport"), act.SendKey(get_key("L", nil, "CTRL")) }),
		"SUPER"
	),
	get_key("l", act.ActivatePaneDirection("Right"), "LEADER"),
	get_key("l", act.ShowDebugOverlay, "SUPER|SHIFT"),
	get_key("l", act.ShowLauncher, "SUPER"),
	get_key("m", act.DisableDefaultAssignment, "CMD"),
	get_key("n", act.SpawnWindow, "SUPER"),
	get_key("q", act.PaneSelect({ mode = "SwapWithActive" }), "LEADER"),
	get_key("q", act.QuitApplication, "SUPER"),
	get_key("s", act.SplitVertical({ domain = "CurrentPaneDomain" }), "LEADER"),
	get_key("t", act.SpawnTab("CurrentPaneDomain"), "SUPER"),
	get_key("v", act.PasteFrom("Clipboard"), "SUPER"),
	get_key("v", act.SplitHorizontal({ domain = "CurrentPaneDomain" }), "LEADER"),
	get_key("w", act.CloseCurrentTab({ confirm = true }), "SUPER"),
	get_key("x", act.CloseCurrentPane({ confirm = true }), "LEADER"),
	get_key("x", act.CloseCurrentTab({ confirm = true }), "LEADER|SHIFT"),
	get_key("z", act.TogglePaneZoomState, "LEADER"),
	get_key("{", act.MoveTabRelative(-1), "SHIFT|ALT"),
	get_key("}", act.MoveTabRelative(1), "SHIFT|ALT"),

	-- KEY TABLES
	get_key("r", act.ActivateKeyTable({ name = "resize_pane", one_shot = false }), "LEADER"),

	table.unpack(tab_keys),
}

local resize_pane = {
	get_key("DownArrow", act.AdjustPaneSize({ "Down", 1 }), nil),
	get_key("Escape", "PopKeyTable", nil),
	get_key("h", act.AdjustPaneSize({ "Left", 1 }), nil),
	get_key("j", act.AdjustPaneSize({ "Down", 1 }), nil),
	get_key("k", act.AdjustPaneSize({ "Up", 1 }), nil),
	get_key("l", act.AdjustPaneSize({ "Right", 1 }), nil),
	get_key("LeftArrow", act.AdjustPaneSize({ "Left", 1 }), nil),
	get_key("RightArrow", act.AdjustPaneSize({ "Right", 1 }), nil),
	get_key("UpArrow", act.AdjustPaneSize({ "Up", 1 }), nil),
}

local copy_mode_remap = {
	get_key("b", act.CopyMode("MoveBackwardWord"), "SHIFT"),
	get_key("h", act.CopyMode("MoveToStartOfLineContent"), "SHIFT"),
	get_key("l", act.CopyMode("MoveToEndOfLineContent"), "SHIFT"),
	get_key("w", act.CopyMode("MoveForwardWord"), "NONE"),
	get_key("y", act.CopyTo("ClipboardAndPrimarySelection"), "NONE"),
}

local copy_mode = nil
if wezterm.gui then
	copy_mode = wezterm.gui.default_key_tables().copy_mode
end

for key, _ in ipairs(copy_mode_remap) do
	table.insert(copy_mode or {}, copy_mode_remap[key])
end

M.key_tables = {
	copy_mode = copy_mode,
	resize_pane = resize_pane,
}

M.leader = {
	key = "a",
	mods = "CTRL",
}

return M
