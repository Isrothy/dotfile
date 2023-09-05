local map = vim.keymap.set

local yanky = {
	"gbprod/yanky.nvim",
	dependencies = {
		{
			"kkharji/sqlite.lua",
			enabled = not jit.os:find("Windows"),
		},
	},
	opts = function()
		local mapping = require("yanky.telescope.mapping")
		local mappings = mapping.get_defaults()
		mappings.i["<c-p>"] = nil
		return {
			highlight = { timer = 200 },
			ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
			picker = {
				telescope = {
					use_default_mappings = false,
					mappings = mappings,
				},
			},
		}
	end,
	keys = {
		{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
		{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
		{ "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
		{ "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
		{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
		{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
		{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
		{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
		{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
		{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
		{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
		{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
		{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
		{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
	},
}

local substitute = {
	"gbprod/substitute.nvim",
	init = function()
		map(
			"n",
			"gr",
			"<cmd>lua require('substitute').operator()<cr>",
			{ noremap = true, silent = true, desc = "substitute" }
		)
		map(
			"n",
			"grr",
			"<cmd>lua require('substitute').line()<cr>",
			{ noremap = true, silent = true, desc = "substitute line" }
		)
		map(
			"n",
			"gR",
			"<cmd>lua require('substitute').eol()<cr>",
			{ noremap = true, silent = true, desc = "substitute eol" }
		)
		map(
			"x",
			"gr",
			"<cmd>lua require('substitute').visual()<cr>",
			{ noremap = true, silent = true, desc = "substitute visual" }
		)

		map(
			"n",
			"gx",
			"<cmd>lua require('substitute.exchange').operator()<cr>",
			{ noremap = true, silent = true, desc = "exchange" }
		)
		map(
			"n",
			"gxx",
			"<cmd>lua require('substitute.exchange').line()<cr>",
			{ noremap = true, silent = true, desc = "exchange line" }
		)
		map(
			"x",
			"gx",
			"<cmd>lua require('substitute.exchange').visual()<cr>",
			{ noremap = true, silent = true, desc = "exchange visual" }
		)
		map(
			"n",
			"gxc",
			"<cmd>lua require('substitute.exchange').cancel()<cr>",
			{ noremap = true, silent = true, desc = "cancel exchange" }
		)
	end,
	opts = {
		on_substitute = function(event)
			require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
		end,
		yank_substituted_text = false,
		highlight_substituted_text = {
			enabled = true,
			timer = 500,
		},
		range = {
			prefix = "gr",
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
	},
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
	opts = {
		set_keymaps = true,
		preserve_visual_selection = true,
	},
}

local dial = {
	"monaqa/dial.nvim",
	enabled = true,
	keys = {
		{ "<C-a>", mode = "n", desc = "Increment" },
		{ "<C-x>", mode = "n", desc = "Decrement" },
		{ "<C-a>", mode = "v", desc = "Increment" },
		{ "<C-x>", mode = "v", desc = "Decrement" },
		{ "g<C-a>", mode = "v", desc = "G increment" },
		{ "g<C-x>", mode = "v", desc = "G decrement" },
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

		map("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
		map("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
		map("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
		map("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
		map("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
		map("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
	end,
}

local mini_move = {
	"echasnovski/mini.move",
	keys = {
		{ "<M-left>", mode = { "n", "x" }, desc = "Move left" },
		{ "<M-right>", mode = { "n", "x" }, desc = "Move right" },
		{ "<M-up>", mode = { "n", "x" }, desc = "Move up" },
		{ "<M-down>", mode = { "n", "x" }, desc = "Move down" },
	},
	opts = {
		mappings = {
			-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
			left = "<M-left>",
			right = "<M-right>",
			down = "<M-down>",
			up = "<M-up>",

			-- Move current line in Normal mode
			line_left = "<M-left>",
			line_right = "<M-right>",
			line_down = "<M-down>",
			line_up = "<M-up>",
		},
	},
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
	opts = {
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
	},
}

return {
	yanky,
	substitute,
	stay_in_place,
	dial,
	mini_move,
	surround,
}
