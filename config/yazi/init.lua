local function module_exists(name)
	if package.loaded[name] then
		return true
	else
		---@diagnostic disable-next-line: no-unknown
		local status, _ = pcall(require, name)
		return status
	end
end

if not module_exists("starship") then
	os.execute("ya pack -i")
end

require("full-border"):setup()
require("git"):setup()
require("starship"):setup()

---@diagnostic disable-next-line: no-unknown
function Status:name()
	---@type table
	local h = self._tab.current.hovered
	if not h then
		---@type {Line: fun(arg: table|string)}
		---@diagnostic disable-next-line: no-unknown
		return ui.Line({})
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end
	---@diagnostic disable-next-line: no-unknown
	return ui.Line(" " .. h.name .. linked)
end
