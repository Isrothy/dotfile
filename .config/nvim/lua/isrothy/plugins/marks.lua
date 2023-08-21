return {
	"chentoast/marks.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		-- whether to map keybinds or not. default true
		default_mappings = true,
		-- which builtin marks to show. default {}
		builtin_marks = { ".", "<", ">", "^" },
		-- whether movements cycle back to the beginning/end of buffer. default true
		cyclic = true,
		-- whether the shada file is updated after modifying uppercase marks. default false
		force_write_shada = false,
		-- how often (in ms) to redraw signs/recompute mark positions.
		-- higher values will have better performance but may cause visual lag,
		-- while lower values may cause performance penalties. default 150.
		refresh_interval = 250,
		-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
		-- marks, and bookmarks.
		-- can be either a table with all/none of the keys, or a single number, in which case
		-- the priority applies to all marks.
		-- default 10.
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		-- disables mark tracking for specific filetypes. default {}
		excluded_filetypes = {
			"",
			"lspinfo",
			"null-ls-info",
			"notify",
			"noice",
			"help",
			"registers",
			"toggleterm",
			"dap-repl",
			"dapui_watches",
			"dapui_stacks",
			"dapui_breakpoints",
			"dapui_scopes",
			"dapui_colsole",
			"ssr",
		},
	},
}
