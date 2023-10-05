return {
	{
		"Darazaki/indent-o-matic",
		event = { "BufReadPre", "BufNewFile" },
		enabled = true,
		opts = {
			-- The values indicated here are the defaults

			-- Number of lines without indentation before giving up (use -1 for infinite)
			max_lines = -1,

			-- Space indentations that should be detected
			standard_widths = { 2, 4, 8 },

			-- Skip multi-line comments and strings (more accurate detection but less performant)
			skip_multiline = true,
		},
	},
	{

		"tenxsoydev/tabs-vs-spaces.nvim",
		event = { 'BufReadPost, "BufNewFile' },
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
		-- branch = "v3",
		main = "ibl",
		-- event = { "BufReadPre", "BufNewFile" },
		-- opts = {
		-- 	char = "▎",
		-- 	char_blankline = "▎",
		-- 	context_char = "▎",
		-- 	char_priority = 12,
		-- 	-- space_char_blankline = " ",
		-- 	use_treesitter = true,
		-- 	use_treesitter_scope = false,
		-- 	show_current_context = true,
		-- 	show_current_context_start = true,
		-- 	show_first_indent_level = true,
		-- 	show_current_context_start_on_current_line = true,
		-- 	viewport_buffer = 10000,
		-- 	context_patterns = {
		-- 		"class",
		-- 		"struct",
		-- 		"enum",
		-- 		"^func",
		-- 		"method",
		-- 		"^if",
		-- 		"while",
		-- 		"for",
		-- 		"with",
		-- 		"try",
		-- 		"except",
		-- 		"arguments",
		-- 		"argument_list",
		-- 		"object",
		-- 		"dictionary",
		-- 		"element",
		-- 		"rule_set",
		-- 		"array",
		-- 		"table",
		-- 		"tuple",
		-- 		"do_block",
		-- 		"do_statement",
		-- 		"switch_statement",
		-- 		"case_statement",
		-- 	},
		-- },
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
					-- highlight = { "Whitespace", "NonText" },
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
}
