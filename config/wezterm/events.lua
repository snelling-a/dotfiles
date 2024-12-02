local function toggle_override(window, override, params)
	---@type table<string, table>
	local overrides = window:get_config_overrides() or {}

	if not overrides[override] then
		overrides[override] = params
	else
		overrides[override] = nil
	end

	window:set_config_overrides(overrides)
end

Wezterm.on("toggle-ligature", function(window, _)
	toggle_override(window, "harfbuzz_features", {
		"calt=0",
		"clig=0",
		"liga=0",
	})
end)

Wezterm.on("toggle-opacity", function(window, _)
	toggle_override(window, "window_background_opacity", 1)
end)

Wezterm.on("toggle-leader", function(window, _)
	toggle_override(window, "leader", {
		key = "s",
		mods = "SUPER",
	})
end)
