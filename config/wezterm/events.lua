local wezterm = require("wezterm")

wezterm.on("toggle-ligature", function(window, _pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.harfbuzz_features then
		overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	else
		overrides.harfbuzz_features = nil
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-opacity", function(window, _pane)
	local overrides = window:get_config_overrides() or {}

	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-leader", function(window, _pane)
	wezterm.log_info("toggling the leader")
	local overrides = window:get_config_overrides() or {}
	if not overrides.leader then
		overrides.leader = { key = "s", mods = "SUPER" }
	else
		overrides.leader = nil
	end

	window:set_config_overrides(overrides)
end)
