local yanky = {
	"gbprod/yanky.nvim",
	event = "VeryLazy",
	config = function()
		local utils = require("yanky.utils")
		local mapping = require("yanky.telescope.mapping")
		require("yanky").setup({
			ring = {
				history_length = 128,
				storage = "shada",
				sync_with_numbered_registers = true,
				cancel_event = "update",
			},
			picker = {
				select = {
					action = require("yanky.picker").actions.set_register("+"), -- nil to use default put action
				},
				telescope = {
					mappings = {
						default = mapping.put("p"),
						i = {
							-- ["<c-p>"] = mapping.put("p"),
							-- ["<c-k>"] = mapping.put("P"),
							["<c-x>"] = mapping.delete(),
							["<c-r>"] = mapping.set_register(utils.get_default_register()),
						},
						n = {
							p = mapping.put("p"),
							P = mapping.put("P"),
							d = mapping.delete(),
							r = mapping.set_register(utils.get_default_register()),
						},
					}, -- nil to use default mappings
				},
			},
			system_clipboard = {
				sync_with_ring = false,
			},
			highlight = {
				on_put = true,
				on_yank = true,
				timer = 250,
			},
			preserve_cursor_position = {
				enabled = true,
			},
		})
		vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
		vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
		vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
		vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

		vim.keymap.set("n", "<M-n>", "<Plug>(YankyCycleForward)")
		vim.keymap.set("n", "<M-p>", "<Plug>(YankyCycleBackward)")

		vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

		vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
		vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
		vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
		vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

		vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
		vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
		vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
		vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

		vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
		vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
		require("telescope").load_extension("yank_history")
	end,
}

local substitute = {
	"gbprod/substitute.nvim",
	event = "VeryLazy",
	init = function()
		vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
		vim.keymap.set("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
		vim.keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
		vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

		vim.keymap.set("n", "sx", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
		vim.keymap.set("n", "sxx", "<cmd>lua require('substitute.exchange').line()<cr>", { noremap = true })
		vim.keymap.set("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", { noremap = true })
		vim.keymap.set("n", "sxc", "<cmd>lua require('substitute.exchange').cancel()<cr>", { noremap = true })
	end,
	config = function()
		require("substitute").setup({
			on_substitute = function(event)
				require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
			end,
			yank_substituted_text = false,
			range = {
				prefix = "s",
				prompt_current_text = false,
				confirm = false,
				complete_word = false,
				motion1 = false,
				motion2 = false,
				suffix = "",
			},
			exchange = {
				motion = false,
				use_esc_to_cancel = true,
			},
		})
	end,
}

local stay_in_place = {
	"gbprod/stay-in-place.nvim",
	keys = {
		{ ">", mode = { "n", "x" } },
		{ "<", mode = { "n", "x" } },
		{ "=", mode = { "n", "x" } },
		{ ">>", mode = { "n" } },
		{ "<<", mode = { "n" } },
		{ "==", mode = { "n" } },
	},
	config = function()
		require("stay-in-place").setup({
			set_keymaps = true,
			preserve_visual_selection = true,
		})
	end,
}

local cutlass = {
	"gbprod/cutlass.nvim",
	event = "VeryLazy",
	enabled = false,
	config = function()
		require("cutlass").setup({
			cut_key = nil,
			override_del = true,
			exclude = {},
		})
	end,
}

local dial = {
	"monaqa/dial.nvim",
	enabled = true,
	keys = {
		{ "<C-a>", mode = "n" },
		{ "<C-x>", mode = "n" },
		{ "<C-a>", mode = "v" },
		{ "<C-x>", mode = "v" },
		{ "g<C-a>", mode = "v" },
		{ "g<C-x>", mode = "v" },
	},
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			-- default augends used when no group name is specified
			default = {
				augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
				augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
				augend.integer.alias.octal,
				augend.integer.alias.binary,
				augend.constant.alias.bool,
				augend.constant.alias.alpha,
				augend.constant.alias.Alpha,
				augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
				augend.constant.new({
					elements = { "and", "or" },
					word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
					cyclic = true, -- "or" is incremented into "and".
				}),
				augend.constant.new({
					elements = { "min", "max" },
					word = true,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { "lower", "upper" },
					word = false,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { "&&", "||" },
					word = false,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { "&", "|" },
					word = false,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { "+", "-" },
					word = false,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { "++", "--" },
					word = false,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { ">>", "<<" },
					word = false,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { ">", "<" },
					word = false,
					cyclic = true,
				}),
				augend.hexcolor.new({
					case = "lower",
				}),
				augend.hexcolor.new({
					case = "upper",
				}),
			},
		})

		vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
		vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
		vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
		vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
		vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
		vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
	end,
}

local mini_move = {
	"echasnovski/mini.move",
	keys = {
		{ "<M-j>", mode = { "n", "x" } },
		{ "<M-k>", mode = { "n", "x" } },
		{ "<M-h>", mode = { "n", "x" } },
		{ "<M-l>", mode = { "n", "x" } },
	},
	config = function()
		require("mini.move").setup({
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "<M-h>",
				right = "<M-l>",
				down = "<M-j>",
				up = "<M-k>",

				-- Move current line in Normal mode
				line_left = "<M-h>",
				line_right = "<M-l>",
				line_down = "<M-j>",
				line_up = "<M-k>",
			},
		})
	end,
}

local surround = {
	"kylechui/nvim-surround",
	keys = {
		{ "ds", mode = "n" },
		{ "cs", mode = "n" },
		{ "gs", mode = "n" },
		{ "gss", mode = "n" },
		{ "gS", mode = "n" },
		{ "gSS", mode = "n" },
		{ "<c-s>", mode = "v" },
		{ "g<c-s>", mode = "v" },
		{ "<c-g>s", mode = "i" },
		{ "<c-g>S", mode = "i" },
	},
	config = function()
		require("nvim-surround").setup({
			keymaps = {
				insert = "<c-g>s",
				insert_line = "<c-g>S",
				normal = "gs",
				normal_cur = "gss",
				normal_line = "gS",
				normal_cur_line = "gSS",
				visual = "<c-s>",
				visual_line = "g<c-s>",
				delete = "ds",
				change = "cs",
			},
			move_cursor = false,
		})
	end,
}

return {
	yanky,
	substitute,
	stay_in_place,
	-- cutlass,
	dial,
	mini_move,
	surround,
}
