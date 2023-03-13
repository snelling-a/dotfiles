local wezterm = require("wezterm")

wezterm.on("toggle-ligature", function(window, _pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.harfbuzz_features then
		-- If we haven't overridden it yet, then override with ligatures disabled
		overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	else
		-- else we did already, and we should disable out override now
		overrides.harfbuzz_features = nil
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-opacity", function(window, _pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.5
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

local function notifier(opts)
	if opts.window == nil then
		return
	end

	opts = opts or {}
	local title = opts.title or "wezterm"
	local message = opts.message or ""
	local timeout = opts.timeout or 4000
	local window = opts.window

	window:toast_notification(title, message, nil, timeout)
end

wezterm.on(
	"window-config-reloaded",
	function(window)
		notifier({ title = "wezterm", message = "configuration reloaded!", window = window, timeout = 4000 })
	end
)
