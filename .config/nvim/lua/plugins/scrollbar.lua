return {
	{
		"dstein64/nvim-scrollview",
		event = { "BufReadPost", "BufNewFile" },
		enabled = false,
		opts = {
			excluded_filetypes = {},
			current_only = false,
			winblend = 25,
			-- base = "buffer",
			-- column = 80,
		},
	},
	{
		"lewis6991/satellite.nvim",
		event = { "BufReadPost", "BufNewFile" },
		otps = {
			current_only = false,
			winblend = 20,
			zindex = 40,
			excluded_filetypes = {
				"",
				"prompt",
				"TelescopePrompt",
				"noice",
			},
			width = 2,
			handlers = {
				search = {
					enable = true,
				},
				diagnostic = {
					enable = true,
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
					enable = false,
					show_builtins = false, -- shows the builtin marks like [ ] < >
				},
			},
		},
	},
}
