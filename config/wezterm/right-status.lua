local function get_overrides(window)
	local nerdfonts = Wezterm.nerdfonts

	--- @param str string
	--- @return string
	local function pad_right(str)
		return Wezterm.pad_right(str, 4)
	end

	local overrides = window:get_config_overrides() or {}
	--- @type {calt:number,clig:number,liga:number}?,{key:string,mods:string}?,number?
	local ligature, leader, blur = overrides.harfbuzz_features, overrides.leader, overrides.window_background_opacity

	local leader_sign = leader and pad_right(nerdfonts.md_apple_keyboard_command) or ""
	local ligature_sign = ligature and pad_right(nerdfonts.fae_equal_bigger) or ""
	local blur_sign = blur and pad_right(nerdfonts.md_blur_off) or ""

	return Wezterm.format({
		{ Text = blur_sign },
		{ Text = ligature_sign },
		{ Text = leader_sign },
	})
end

Wezterm.on("update-right-status", function(window)
	window:set_right_status(Wezterm.format({
		{ Text = get_overrides(window) },
	}))
end)
