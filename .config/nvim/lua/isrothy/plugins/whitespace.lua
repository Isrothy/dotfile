return {
	{
		"Darazaki/indent-o-matic",
		event = { "BufReadPre", "BufNewFile" },
		enabled = true,
		opts = {
			max_lines = -1,
			standard_widths = { 2, 4, 8 },
			skip_multiline = true,
		},
	},
	{

		"tenxsoydev/tabs-vs-spaces.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = "DiagnosticUnderlineHint",
			ignore = {
				filetypes = {},
				-- Works for normal buffers by default.
				buftypes = {
					"acwrite",
					"help",
					"nofile",
					"nowrite",
					"quickfix",
					"terminal",
					"prompt",
				},
			},
			standartize_on_save = false,
			-- Enable or disable user commands see Readme.md/#Commands for more info.
			user_commands = true,
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
			-- hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup({
				indent = {
					char = "▎",
					tab_char = "▎",
					smart_indent_cap = true,
				},
				whitespace = {
					remove_blankline_trail = false,
				},
				scope = {
					enabled = true,
					show_start = true,
					show_end = true,
					highlight = {
						"RainbowDelimiterRed",
						"RainbowDelimiterYellow",
						"RainbowDelimiterBlue",
						"RainbowDelimiterOrange",
						"RainbowDelimiterGreen",
						"RainbowDelimiterViolet",
						"RainbowDelimiterCyan",
					},
					include = {
						node_type = {
							lua = {
								"chunk",
								"do_statement",
								"while_statement",
								"repeat_statement",
								"if_statement",
								"for_statement",
								"function_declaration",
								"function_definition",
								"table_constructor",
								"assignment_statement",
							},
							typescript = {
								"statement_block",
								"function",
								"arrow_function",
								"function_declaration",
								"method_definition",
								"for_statement",
								"for_in_statement",
								"catch_clause",
								"object_pattern",
								"arguments",
								"switch_case",
								"switch_statement",
								"switch_default",
								"object",
								"object_type",
								"ternary_expression",
							},
						},
					},
				},
			})
		end,
		init = function()
			vim.opt.list = true
		end,
	},
	{
		"echasnovski/mini.trailspace",
		event = { "BufReadPost", "BufNewFile" },
		init = function()
			vim.api.nvim_create_user_command("MiniTrailspace", "lua MiniTrailspace.trim()", {})
			vim.api.nvim_create_user_command("MiniTrailspaceLastlines", "lua MiniTrailspace.trim_last_lines()", {})
		end,
		opts = {
			only_in_normal_buffers = true,
		},
	},
}
