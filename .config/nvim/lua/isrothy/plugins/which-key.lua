return {
	{
		"folke/which-key.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"echasnovski/mini.ai",
		},
		event = "VeryLazy",
		opts = {
			plugins = {
				presets = {
					operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
			-- operators = { gc = "Comments" },
			window = {
				border = "rounded", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 1, 1, 1 }, -- extra window margin [top, right, bottom, left]
				padding = { 1, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
				winblend = 20,
			},
			ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
			hidden = {},
			triggers_blacklist = {},
			disable = {
				buftypes = {},
				filetypes = { "TelescopePrompt" },
			},
		},
		config = function(_, opts)
			local custom_textobjects = require("isrothy.plugins.text-objects").custom_textobjects
			local objects = require("which-key.plugins.presets").objects
			local motions = require("which-key.plugins.presets").motions
			objects["an"] = { name = "around next" }
			objects["in"] = { name = "inside next" }
			objects["al"] = { name = "around last" }
			objects["il"] = { name = "inside last" }
			for k, v in pairs(custom_textobjects) do
				local cat = function(t)
					if type(t) == "table" then
						return table.concat(t, ", ")
					else
						return t
					end
				end

				objects["a" .. k] = cat(v.a)
				objects["an" .. k] = cat(v.a)
				objects["al" .. k] = cat(v.a)
				objects["i" .. k] = cat(v.i)
				objects["in" .. k] = cat(v.i)
				objects["il" .. k] = cat(v.i)
				motions["g[" .. k] = cat(v.a)
				motions["g]" .. k] = cat(v.a)
			end

			objects["ih"] = { name = "inside hunk" }

			require("which-key").setup(opts)

			local wk = require("which-key")

			wk.register({
				["<leader><leader>"] = {
					name = "Telescope",
				},
			})
			wk.register({
				["<leader>d"] = {
					name = "Dap",
				},
			})
			wk.register({
				["<leader>x"] = {
					name = "Trouble",
				},
			})
			wk.register({
				["<leader>p"] = {
					name = "Presistence",
				},
			})

			wk.register({
				ca = "Lsp code action",
				cr = "Run code",
				rn = "Lsp rename",
				f = "Lsp format",
				qd = "Diagnostics to quickfix",
				cd = "Float diagnostic window",
				w = {
					a = "Lsp add work space",
					r = "Lsp remove work space",
					l = "Lsp watch work space",
					p = "Pick a window",
				},
				g = {
					D = "Lsp buf declaration",
					d = "Lsp definition",
					i = "Lsp implementation",
					r = "Lsp references",
					t = "Lsp type definition",
				},
			}, {
				prefix = "<leader>",
			})

			wk.register({
				["<leader>h"] = {
					name = "hunk",
					s = "Stage hunk",
					r = "Reset hunk",
					S = "Stage buffer",
					u = "Undo stage buffer",
					R = "Reset buffer",
					p = "Preview Hunk",
					b = "Toggle current blame line",
					d = "Diff",
					D = "Toggle delete",
				},
			})
			wk.register({
				["<leader>r"] = {
					name = "Rename / SearchReplaceSingleBuffer",
					s = "SearchReplaceSingleBuffer [s]elction list",
					o = "[o]pen",
					w = "[w]ord",
					W = "[W]ORD",
					e = "[e]xpr",
					f = "[f]ile",
					b = {
						name = "SearchReplaceMultiBuffer",
						s = "SearchReplaceMultiBuffer [s]elction list",
						o = "[o]pen",
						w = "[w]ord",
						W = "[W]ORD",
						e = "[e]xpr",
						f = "[f]ile",
					},
				},
			})
			wk.register({
				["<leader>b"] = {
					h = "Swap with the left buffer",
					l = "Swap with the right buffer",
					j = "Swap with the bottom buffer",
					k = "Swap with the top buffer",
				},
			})
			wk.register({
				["<leader>i"] = {
					name = "ISwap",
				},
			})
			wk.register({
				["]h"] = "Next hunk",
				["[h"] = "Previous hunk",
				["]c"] = "Next diff",
				["[c"] = "Previous diff",
			})
			wk.register({
				["dm"] = "Delete mark",
				["ds"] = "Delete surrounding",
			})
			wk.register({
				["ga"] = {
					name = "text-case",
					c = { "<cmd>lua require('textcase').current_word('to_camel_case')<CR>", "Convert toCamelCase" },
					d = { "<cmd>lua require('textcase').current_word('to_dashed_case')<CR>", "Convert to-dashed-case" },
					l = { "<cmd>lua require('textcase').current_word('to_lower_case')<CR>", "Convert to lower case" },
					p = { "<cmd>lua require('textcase').current_word('to_pascal_case')<CR>", "Convert ToPascalCase" },
					s = { "<cmd>lua require('textcase').current_word('to_snake_case')<CR>", "Convert to_snake_case" },
					u = { "<cmd>lua require('textcase').current_word('to_upper_case')<CR>", "Convert To UPPER CASE" },
					C = { "<cmd>lua require('textcase').lsp_rename('to_camel_case')<CR>", "LSP rename toCamelCase" },
					D = { "<cmd>lua require('textcase').lsp_rename('to_dashed_case')<CR>", "LSP rename to-dashed-case" },
					L = { "<cmd>lua require('textcase').lsp_rename('to_lower_case')<CR>", "LSP rename to lower case" },
					P = { "<cmd>lua require('textcase').lsp_rename('to_pascal_case')<CR>", "LSP rename ToPascalCase" },
					S = { "<cmd>lua require('textcase').lsp_rename('to_snake_case')<CR>", "LSP rename to_snake_case" },
					U = { "<cmd>lua require('textcase').lsp_rename('to_upper_case')<CR>", "LSP rename To UPPER CASE" },
				},
			})
			wk.register({
				["gao"] = {
					name = "Pending mode operator",
					c = { "<cmd>lua require('textcase').operator('to_camel_case')<CR>", "toCamelCase" },
					d = { "<cmd>lua require('textcase').operator('to_dashed_case')<CR>", "to-dashed-case" },
					l = { "<cmd>lua require('textcase').operator('to_lower_case')<CR>", "to lower case" },
					p = { "<cmd>lua require('textcase').operator('to_pascal_case')<CR>", "ToPascalCase" },
					s = { "<cmd>lua require('textcase').operator('to_snake_case')<CR>", "to_snake_case" },
					u = { "<cmd>lua require('textcase').operator('to_upper_case')<CR>", "To UPPER CASE" },
				},
			}, {
				mode = { "n", "v" },
			})
		end,
	},
}
