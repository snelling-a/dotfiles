--- @sync entry
return {
	entry = function(_, args)
		---@diagnostic disable-next-line: no-unknown
		local current = cx.active.current
		---@type number
		local new = (current.cursor + args[1]) % #current.files
		---@diagnostic disable-next-line: no-unknown
		ya.manager_emit("arrow", { new - current.cursor })
	end,
}
