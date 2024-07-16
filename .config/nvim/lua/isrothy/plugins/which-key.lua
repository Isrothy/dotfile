return {
	{
		"folke/which-key.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"echasnovski/mini.ai",
		},
		event = "VeryLazy",
		enable = true,
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		sort = { "local", "order", "group", "alphanum", "mod", "lower", "icase" },
		opts = {
			win = {
				row = -1,
				border = "solid",
				padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
				title = true,
				title_pos = "center",
				zindex = 1000,
				-- Additional vim.wo and vim.bo options
				bo = {},
				wo = {
					-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
				},
			},
		},
		config = function(_, opts)
			require("which-key").setup(opts)

			local wk = require("which-key")

			wk.add({
				{ "<leader>f", group = "Telescope" },
			})
			wk.add({
				{ "<leader>d", group = "Dap" },
			})
			wk.add({
				{ "<leader>x", group = "Trouble" },
			})
			wk.add({
				{ "<leader>p", group = "Presistence" },
			})

			wk.add({
				{ "<leader>wp", desc = "Pick a window" },
			})

			wk.add({
				{ "<leader>gh", desc = "Hunk" },
			})
			wk.add({
				{ "<leader>r", group = "Replace / SearchReplaceSingleBuffer" },
				{ "<leader>rs", desc = "SearchReplaceSingleBuffer [s]elction list" },
				{ "<leader>ro", desc = "[o]pen" },
				{ "<leader>rw", desc = "[w]ord" },
				{ "<leader>rW", desc = "[W]ORD" },
				{ "<leader>re", desc = "[e]xpr" },
				{ "<leader>rf", desc = "[f]ile" },

				{ "<leader>rb", group = "SearchReplaceMultiBuffer" },
				{ "<leader>rbs", desc = "SearchReplaceMultiBuffer [s]elction list" },
				{ "<leader>rbo", desc = "[o]pen" },
				{ "<leader>rbw", desc = "[w]ord" },
				{ "<leader>rbW", desc = "[W]ORD" },
				{ "<leader>rbe", desc = "[e]xpr" },
				{ "<leader>rbf", desc = "[f]ile" },
			})

			wk.add({
				{ "<leader>bs", group = "Buffer swap" },
			})

			wk.add({
				{ "<leader>i", group = "ISwap" },
				{ "<leader>t", group = "Neotest" },
				{ "<leader>h", group = "Harpoon" },
				{ "<leader>k", group = "Git conflict" },
			})

			wk.add({
				{ "ga", group = "TextCase" },
				{
					"gac",
					"<cmd>lua require('textcase').operator('to_camel_case')<CR>",
					name = "Convert toCamelCase",
				},
				{
					"gad",
					"<cmd>lua require('textcase').operator('to_dashed_case')<CR>",
					name = "Convert to-dashed-case",
				},
				{
					"gal",
					"<cmd>lua require('textcase').operator('to_lower_case')<CR>",
					name = "Convert to lower case",
				},
				{
					"gap",
					"<cmd>lua require('textcase').operator('to_pascal_case')<CR>",
					name = "Convert ToPascalCase",
				},
				{
					"gas",
					"<cmd>lua require('textcase').operator('to_snake_case')<CR>",
					name = "Convert to_snake_case",
				},
				{
					"gau",
					"<cmd>lua require('textcase').operator('to_upper_case')<CR>",
					name = "Convert To UPPER CASE",
				},
				{
					"gaC",
					"<cmd>lua require('textcase').lsp_rename('to_camel_case')<CR>",
					name = "Rename toCamelCase",
				},
				{
					"gaD",
					"<cmd>lua require('textcase').lsp_rename('to_dashed_case')<CR>",
					name = "Rename to-dashed-case",
				},
				{
					"gaL",
					"<cmd>lua require('textcase').lsp_rename('to_lower_case')<CR>",
					name = "Rename to lower case",
				},
				{
					"gaP",
					"<cmd>lua require('textcase').lsp_rename('to_pascal_case')<CR>",
					name = "Rename ToPascalCase",
				},
				{
					"gaS",
					"<cmd>lua require('textcase').lsp_rename('to_snake_case')<CR>",
					name = "Rename to_snake_case",
				},
				{
					"gaU",
					"<cmd>lua require('textcase').lsp_rename('to_upper_case')<CR>",
					name = "Rename To UPPER CASE",
				},
				{ "gao", group = "Pending mode operator" },
				{
					"gaoc",
					"<cmd>lua require('textcase').operator('to_camel_case')<CR>",
					name = "toCamelCase",
					mode = { "n", "v" },
				},
				{
					"gaod",
					"<cmd>lua require('textcase').operator('to_dashed_case')<CR>",
					name = "to-dashed-case",
					mode = { "n", "v" },
				},
				{
					"gaol",
					"<cmd>lua require('textcase').operator('to_lower_case')<CR>",
					name = "to lower case",
					mode = { "n", "v" },
				},
				{
					"gaop",
					"<cmd>lua require('textcase').operator('to_pascal_case')<CR>",
					name = "ToPascalCase",
					mode = { "n", "v" },
				},
				{
					"gaos",
					"<cmd>lua require('textcase').operator('to_snake_case')<CR>",
					name = "to_snake_case",
					mode = { "n", "v" },
				},
				{
					"gaou",
					"<cmd>lua require('textcase').operator('to_upper_case')<CR>",
					name = "To UPPER CASE",
					mode = { "n", "v" },
				},
			})
		end,
	},
}
