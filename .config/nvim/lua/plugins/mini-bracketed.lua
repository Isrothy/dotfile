return {
	"echasnovski/mini.bracketed",
	event = { "BufReadPre", "BufNewFile" },
	-- event = "VeryLazy",
	config = function()
		require("mini.bracketed").setup({
			buffer = { suffix = "", options = {} },
			comment = { suffix = "k", options = {} },
			conflict = { suffix = "x", options = {} },
			diagnostic = {
				suffix = "d",
				options = {
					severity = vim.diagnostic.severity.ERROR,
				},
			},
			file = { suffix = "f", options = {} },
			indent = { suffix = "i", options = {} },
			jump = { suffix = "j", options = {} },
			location = { suffix = "l", options = {} },
			oldfile = { suffix = "o", options = {} },
			quickfix = { suffix = "q", options = {} },
			treesitter = { suffix = "t", options = {} },
			undo = { suffix = "u", options = {} },
			window = { suffix = "w", options = {} },
			yank = { suffix = "y", options = {} },
		})
	end,
}
