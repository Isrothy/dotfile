return {
	{
		"folke/which-key.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"echasnovski/mini.ai",
			-- "numToStr/Comment.nvim",
			-- "kylechui/nvim-surround",
			-- "gbprod/yanky.nvim",
			-- "gbprod/substitute.nvim",
		},
		event = "VeryLazy",
		enabled = true,

		config = function()
			local custom_textobjects = require("plugins.text-objects").custom_textobjects
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

			require("which-key").setup({
				plugins = {
					marks = true, -- shows a list of your marks on ' and `
					registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
					spelling = {
						enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
						suggestions = 20, -- how many suggestions should be shown in the list?
					},
					-- the presets plugin, adds help for a bunch of default keybindings in Neovim
					-- No actual key bindings are created
					presets = {
						operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
						motions = true, -- adds help for motions
						text_objects = true, -- help for text objects triggered after entering an operator
						windows = true, -- default bindings on <c-w>
						nav = true, -- misc bindings to work with windows
						z = true, -- bindings for folds, spelling and others prefixed with z
						g = true, -- bindings for prefixed with g
					},
				},
				-- add operators that will trigger motion and text object completion
				-- to enable all native operators, set the preset / operators plugin above
				operators = {
					gc = "Comments",
					gb = "Comments blockwise",
					s = "Substitute",
				},
				key_labels = {
					-- override the label used to display some keys. It doesn't effect WK in any other way.
					-- For example:
					["<space>"] = "SPC",
					["<cr>"] = "CR",
					["<tab>"] = "TAB",
				},
				icons = {
					breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
					separator = "➜", -- symbol used between a key and it's label
					group = "+", -- symbol prepended to a group
				},
				popup_mappings = {
					scroll_down = "<c-d>", -- binding to scroll down inside the popup
					scroll_up = "<c-u>", -- binding to scroll up inside the popup
				},
				window = {
					border = "rounded", -- none, single, double, shadow
					position = "bottom", -- bottom, top
					margin = { 1, 1, 1, 1 }, -- extra window margin [top, right, bottom, left]
					padding = { 1, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
					winblend = 20,
				},
				layout = {
					height = { min = 4, max = 25 }, -- min and max height of the columns
					width = { min = 20, max = 50 }, -- min and max width of the columns
					spacing = 3, -- spacing between columns
					align = "left", -- align columns left, center or right
				},
				ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
				-- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
				hidden = {},
				show_help = true, -- show help message on the command line when the popup is visible
				show_keys = true, -- show the currently pressed key and its label as a message in the command line
				triggers = "auto", -- automatically setup triggers
				-- triggers = {"<leader>"} -- or specify a list manually
				triggers_nowait = {
					-- marks
					"`",
					"'",
					"g`",
					"g'",
					-- registers
					'"',
					"<c-r>",
					-- spelling
					"z=",
				},
				triggers_blacklist = {
					-- list of mode / prefixes that should never be hooked by WhichKey
					-- this is mostly relevant for key maps that start with a native binding
					-- most people should not need to change this
					-- i = { "j", "k" },
					-- v = { "j", "k" },
				},
				disable = {
					buftypes = {},
					filetypes = { "TelescopePrompt" },
				},
			})

			local wk = require("which-key")
			wk.register({
				["<c-d>"] = "Lsp goto declaration",
				D = "Lsp goto type defination",
				d = "Lsp foto defination",
				i = "Lsp goto implentation",
				r = "Lsp goto reference",
				f = "Folder preview",
				l = "Leap forward",
				L = "Leap backward",
			}, {
				prefix = "g",
			})

			wk.register({
				["<leader><leader>"] = {
					name = "Telescope",
				},
			})

			wk.register({
				ca = "Lsp code action",
				cr = "Run code",
				rn = "Lsp rename",
				f = "Lsp format",
				q = "Diagnostics to quickfix",
				d = "Float diagnostic window",
				w = {
					a = "Lsp add work space",
					r = "Lsp remove work space",
					l = "Lsp watch work space",
					p = "Pick a windpw",
				},
				a = "Swap next parameter",
				A = "Swap previous parameter",
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
		end,
	},
	{
		"Cassin01/wf.nvim",
		event = "VeryLazy",
		-- lazy = false,
		enabled = false,
		config = function()
			require("wf").setup({
				theme = "space",
			})
			local which_key = require("wf.builtin.which_key")
			local register = require("wf.builtin.register")
			-- local bookmark = require("wf.builtin.bookmark")
			local buffer = require("wf.builtin.buffer")
			local mark = require("wf.builtin.mark")

			-- Register
			vim.keymap.set(
				"n",
				"<leader>wr",
				-- register(opts?: table) -> function
				-- opts?: option
				register(),
				{ noremap = true, silent = true, desc = "[wf.nvim] register" }
			)

			-- Bookmark
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<Space>wbo",
			-- 	-- bookmark(bookmark_dirs: table, opts?: table) -> function
			-- 	-- bookmark_dirs: directory or file paths
			-- 	-- opts?: option
			-- 	bookmark({
			-- 		nvim = "~/.config/nvim",
			-- 		zsh = "~/.zshrc",
			-- 	})({ noremap = true, silent = true, desc = "[wf.nvim] bookmark" })
			-- )

			-- Buffer
			vim.keymap.set(
				"n",
				"<leader>wbu",
				-- buffer(opts?: table) -> function
				-- opts?: option
				buffer(),
				{ noremap = true, silent = true, desc = "[wf.nvim] buffer" }
			)

			-- Mark
			vim.keymap.set(
				"n",
				"'",
				-- mark(opts?: table) -> function
				-- opts?: option
				mark(),
				{ nowait = true, noremap = true, silent = true, desc = "[wf.nvim] mark" }
			)

			-- Which Key
			vim.keymap.set(
				"n",
				"<leader>",
				-- mark(opts?: table) -> function
				-- opts?: option
				which_key({ text_insert_in_advance = "<Leader>" }),
				{ noremap = true, silent = true, desc = "[wf.nvim] which-key /" }
			)
		end,
	},
}
