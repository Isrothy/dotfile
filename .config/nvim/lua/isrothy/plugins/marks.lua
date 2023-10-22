return {
	"chentoast/marks.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
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
