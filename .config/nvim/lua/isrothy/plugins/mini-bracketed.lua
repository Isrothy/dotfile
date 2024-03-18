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

local keys = {
	{
		"]e",
		"<cmd>lua MiniBracketed.diagnostic('forward',{ severity = vim.diagnostic.severity.ERROR })<cr>",
		desc = "error forward",
	},
	{
		"[e",
		"<cmd>lua MiniBracketed.diagnostic('backward',{ severity = vim.diagnostic.severity.ERROR })<cr>",
		desc = "error backword",
	},
	{
		"]E",
		"<cmd>lua MiniBracketed.diagnostic('last',{ severity = vim.diagnostic.severity.ERROR })<cr>",
		desc = "error last",
	},
	{
		"[E",
		"<cmd>lua MiniBracketed.diagnostic('first',{ severity = vim.diagnostic.severity.ERROR })<cr>",
		desc = "error first",
	},
	{
		"]w",
		"<cmd>lua MiniBracketed.diagnostic('forward',{ severity = vim.diagnostic.severity.WARN })<cr>",
		desc = "warn forward",
	},
	{
		"[w",
		"<cmd>lua MiniBracketed.diagnostic('backward',{ severity = vim.diagnostic.severity.WARN })<cr>",
		desc = "warn backword",
	},
	{
		"]W",
		"<cmd>lua MiniBracketed.diagnostic('last',{ severity = vim.diagnostic.severity.WARN })<cr>",
		desc = "warn last",
	},
	{
		"[W",
		"<cmd>lua MiniBracketed.diagnostic('first',{ severity = vim.diagnostic.severity.WARN })<cr>",
		desc = "warn first",
	},
}

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
