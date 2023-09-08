return {
	{
		"dstein64/nvim-scrollview",
		event = { "BufReadPost", "BufNewFile" },
		enabled = false,
		opts = {
			excluded_filetypes = {
				"",
				"prompt",
				"TelescopePrompt",
				"noice",
			},
			current_only = false,
			column = 1,
			winblend = 25,
			signs_on_startup = {
				"marks",
				"diagnostics",
				"folds",
				"search",
			},
			signs_column = -1,
			diagnostics_error_symbol = "-",
			diagnostics_hint_symbol = "-",
			diagnostics_info_symbol = "-",
			diagnostics_warn_symbol = "-",
			-- signs_max_per_row = 1,
			-- base = "buffer",
			-- column = 80,
		},
	},
	{
		"lewis6991/satellite.nvim",
		event = { "BufReadPost", "BufNewFile" },
		enabled = true,
		opts = {
			current_only = false,
			winblend = 0,
			zindex = 40,
			excluded_filetypes = {
				"",
				"prompt",
				"TelescopePrompt",
				"noice",
				-- "neo-tree",
			},
			width = 2,
			handlers = {
				cursor = {
					enable = false,
				},
				search = {
					enable = true,
				},
				diagnostic = {
					enable = true,
					signs = { "-", "=", "≡" },
				},
				gitsigns = {
					enable = true,
					signs = { -- can only be a single character (multibyte is okay)
						add = "│",
						change = "│",
						delete = "-",
					},
				},
				marks = {
					enable = true,
					show_builtins = false, -- shows the builtin marks like [ ] < >
				},
			},
		},
	},
}
