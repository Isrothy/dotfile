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
		branch = "v3",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
			require("ibl").setup({
				indent = {
					char = "▎",
					tab_char = "▎",
					char_blankline = "▎",
					context_char = "▎",
					priority = 12,
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
				},
				-- context_patterns = {
				-- 	"class",
				-- 	"struct",
				-- 	"enum",
				-- 	"^func",
				-- 	"method",
				-- 	"^if",
				-- 	"while",
				-- 	"for",
				-- 	"with",
				-- 	"try",
				-- 	"except",
				-- 	"arguments",
				-- 	"argument_list",
				-- 	"object",
				-- 	"dictionary",
				-- 	"element",
				-- 	"rule_set",
				-- 	"array",
				-- 	"table",
				-- 	"tuple",
				-- 	"do_block",
				-- 	"do_statement",
				-- 	"switch_statement",
				-- 	"case_statement",
				-- },
			})
		end,
		init = function()
			vim.opt.list = true
		end,
	},
}
