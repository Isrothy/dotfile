local opts = {
	buffer = { suffix = "", options = {} },
	comment = { suffix = "k", options = {} },
	conflict = { suffix = "x", options = {} },
	diagnostic = { suffix = "d", options = {} },
	file = { suffix = "f", options = {} },
	indent = { suffix = "i", options = {} },
	jump = { suffix = "j", options = {} },
	location = { suffix = "l", options = {} },
	oldfile = { suffix = "o", options = {} },
	quickfix = { suffix = "q", options = {} },
	treesitter = { suffix = "", options = {} },
	undo = { suffix = "" },
	window = { suffix = "", options = {} },
	yank = { suffix = "y", options = {} },
}

local keys = {}

for k, v in pairs(opts) do
	local m = string.upper(k:sub(1, 1)) .. k:sub(2)
	local s = v.suffix
	if s ~= "" then
		table.insert(keys, { "]" .. s, desc = m .. " forward" })
		table.insert(keys, { "[" .. s, desc = m .. " backword" })
		table.insert(keys, { "]" .. string.upper(s), desc = m .. " last" })
		table.insert(keys, { "[" .. string.upper(s), desc = m .. " first" })
	end
end

return {
	"echasnovski/mini.bracketed",
	enabled = true,
	keys = keys,
	opts = opts,
}
