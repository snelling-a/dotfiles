--- @sync entry
return {
	entry = function(_, job)
		---@diagnostic disable-next-line: no-unknown
		local current = cx.active.current
		---@type number
		local new = (current.cursor + job.args[1]) % #current.files
		---@diagnostic disable-next-line: no-unknown
		ya.manager_emit("arrow", { new - current.cursor })
	end,
}
