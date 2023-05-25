local const = require("const")
local icons = require("const")
local wezterm = require("wezterm")

local pad_right = const.pad_right

local function make_heart_string(number)
	local percent = number * 10
	local diff = 10 - percent
	local full_hearts, empty_hearts, half_heart =
		pad_right(icons.heart_icons.full), pad_right(icons.heart_icons.empty), ""

	if math.floor(percent) % 10 == 5 or math.ceil(percent) % 10 == 5 then
		full_hearts = string.rep(full_hearts, math.floor(percent))
		empty_hearts = string.rep(empty_hearts, math.floor(diff))
		half_heart = icons.heart_icons.half_full
	elseif percent % 10 > 5 then
		full_hearts = string.rep(full_hearts, math.ceil(percent))
		empty_hearts = string.rep(empty_hearts, math.floor(diff))
	elseif percent % 10 < 5 then
		full_hearts = string.rep(full_hearts, math.floor(percent))
		empty_hearts = string.rep(empty_hearts, math.ceil(diff))
	end

	return wezterm.format({
		{ Foreground = { Color = const.colors.red } },
		{ Text = string.format("%s%s", full_hearts, half_heart) },
		{ Foreground = { Color = const.colors.bright_black } },
		{ Text = empty_hearts },
	})
end

local function get_charging_status(state)
	local charging_status, charging_status_color = icons.battery_icons.unknown, const.colors.red

	if state == "Full" then
		charging_status, charging_status_color = icons.battery_icons.full, const.colors.green
	elseif state == "Charging" then
		charging_status, charging_status_color = icons.battery_icons.charging, const.colors.yellow
	elseif state == "Discharging" then
		charging_status, charging_status_color = icons.battery_icons.discharging, const.colors.bright_black
	end

	return wezterm.format({ { Foreground = { Color = charging_status_color } }, { Text = pad_right(charging_status) } })
end

local function get_battery_number(number)
	local text = tostring(math.floor(number * 100)) .. "%"

	return wezterm.format({ { Attribute = { Intensity = "Bold" } }, { Text = text } })
end

local function get_overrides(window)
	local overrides = window:get_config_overrides() or {}
	local ligature, leader, blur = overrides.harfbuzz_features, overrides.leader, overrides.window_background_opacity

	local lead_sign = leader and pad_right(icons.override_icons.leader) or ""
	local lig_sign = ligature and pad_right(icons.override_icons.ligature) or ""
	local blur_sign = blur and pad_right(icons.override_icons.blur) or ""

	return wezterm.format({
		{ Text = blur_sign },
		{ Text = lig_sign },
		{ Text = lead_sign },
	})
end

wezterm.on("update-right-status", function(window)
	local date = wezterm.strftime(" %a %d %b %Y %H:%M")
	local hearts, battery_number, charging_status

	for _, batt in ipairs(wezterm.battery_info()) do
		charging_status = get_charging_status(batt.state)

		if batt.state == "Full" then
			battery_number, hearts = "", ""
		else
			battery_number = get_battery_number(batt.state_of_charge)
			hearts = pad_right(make_heart_string(batt.state_of_charge))
		end
	end

	window:set_right_status(wezterm.format({
		{ Text = get_overrides(window) },
		{ Text = pad_right(charging_status) },
		{ Text = hearts },
		{ Text = battery_number },
		{ Text = pad_right(date) },
	}))
end)
