return {
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
