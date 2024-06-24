return {
	{
		dir = "~/neominimap.nvim",
		lazy = false,
		enabled = false,
		init = function()
			vim.opt.sidescrolloff = 36
			vim.g.neominimap = {
				auto_enable = true,
				debug = false,
				log_path = "/Users/jiangjoshua/neominimap.log",
				exclude_filetypes = {
					"qf",
					"help",
					"neo-tree",
				},
				minimap_width = 20,
				use_lsp = false,
				use_treesitter = false,
				use_git = false,
				width_multiplier = 4,
				z_index = 1,
				show_cursor = true,
				window_border = "none",
			}
		end,
		opts = {},
	},
	{
		-- "gorbit99/codewindow.nvim",
		dir = "~/codewindow.nvim",
		lazy = false,
		enabled = false,
		init = function()
			vim.opt.sidescrolloff = 36
			vim.g.codewindow = {
				auto_enable = true,
				exclude_filetypes = {
					"qf",
					"help",
				},
				minimap_width = 20,
				use_lsp = true,
				use_treesitter = true,
				use_git = true,
				width_multiplier = 4,
				z_index = 1,
				show_cursor = true,
				screen_bounds = "background",
				window_border = "none",
				-- window_border = { "", "", "", "", "", "", "", "" },
				relative = "win",
				events = {
					"LspAttach",
					"BufEnter",
					"BufNewFile",
					"BufRead",
					"TextChanged",
					"InsertLeave",
					"DiagnosticChanged",
					"FileWritePost",
				},
			}
		end,
		opts = {},
	},
}
