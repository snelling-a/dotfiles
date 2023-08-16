local wezterm = require("wezterm")

local function get_overrides(window)
	local nerdfonts = wezterm.nerdfonts
	local function pad_right(string)
		return wezterm.pad_right(string, 5)
	end

	local overrides = window:get_config_overrides() or {}
	local ligature, leader, blur = overrides.harfbuzz_features, overrides.leader, overrides.window_background_opacity

	local lead_sign = leader and pad_right(nerdfonts.md_apple_keyboard_command) or ""
	local lig_sign = ligature and pad_right(nerdfonts.fae_equal_bigger) or ""
	local blur_sign = blur and pad_right(nerdfonts.md_blur_off) or ""

	return wezterm.format({
		{
			Text = blur_sign,
		},
		{
			Text = lig_sign,
		},
		{
			Text = lead_sign,
		},
	})
end

wezterm.on("update-right-status", function(window)
	local const = require("const")

	window:set_right_status(wezterm.format({
		{
			Background = {
				Color = const.colors.background,
			},
		},
		{
			Text = get_overrides(window),
		},
	}))
end)
