local M = {
	"tversteeg/registers.nvim",
	enabled = false,
	event = "VeryLazy",
}

M.config = function()
	local registers = require("registers")
	registers.setup({
		show = '*+"-/_=#%.0123456789abcdefghijklmnopqrstuvwxyz:',
		show_empty = false,
		register_user_command = true,
		system_clipboard = true,
		trim_whitespace = true,
		hide_only_whitespace = true,
		show_register_types = false,

		bind_keys = {
			normal = registers.show_window({ mode = "motion" }),
			visual = registers.show_window({ mode = "motion" }),
			insert = registers.show_window({ mode = "insert" }),
			registers = registers.apply_register({ delay = 0.1 }),
			return_key = registers.apply_register(),
			escape = registers.close_window(),
			ctrl_n = registers.move_cursor_down(),
			ctrl_p = registers.move_cursor_up(),
			ctrl_j = registers.move_cursor_down(),
			ctrl_k = registers.move_cursor_up(),
		},

		symbols = {
			newline = "⏎",
			space = " ",
			tab = "·",
			register_type_charwise = "ᶜ",
			register_type_linewise = "ˡ",
			register_type_blockwise = "ᵇ",
		},

		window = {
			max_width = 100,
			highlight_cursorline = true,
			-- border = "rounded",
			border = {
				{ "", "FloatBorder" },
				{ "", "FloatBorder" },
				{ "", "FloatBorder" },
				{ " ", "FloatBorder" },
				{ "", "FloatBorder" },
				{ "", "FloatBorder" },
				{ "", "FloatBorder" },
				{ " ", "FloatBorder" },
			},
			transparency = 0,
		},

		sign_highlights = {
			cursorline = "Visual",
			selection = "Constant",
			default = "Function",
			unnamed = "Statement",
			read_only = "Type",
			expression = "Exception",
			black_hole = "Error",
			alternate_buffer = "Operator",
			last_search = "Tag",
			delete = "Special",
			yank = "Delimiter",
			history = "Number",
			named = "Todo",
		},
	})
end

return M
