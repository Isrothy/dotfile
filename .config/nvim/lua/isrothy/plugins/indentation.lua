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
		"echasnovski/mini.indentscope",
		enabled = false,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- No need to copy this inside `setup()`. Will be used automatically.
			-- Draw options
			draw = {
				-- Delay (in ms) between event and start of drawing scope indicator
				delay = 0,
				-- Symbol priority. Increase to display on top of more symbols.
				priority = 2,
			},

			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Textobjects
				object_scope = "",
				object_scope_with_border = "",

				-- Motions (jump to respective border line; if not present - body line)
				goto_top = "",
				goto_bottom = "",
			},

			-- Options which control scope computation
			options = {
				-- Type of scope's border: which line(s) with smaller indent to
				-- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
				border = "both",

				-- Whether to use cursor column when computing reference indent.
				-- Useful to see incremental scopes with horizontal cursor movements.
				indent_at_cursor = true,

				-- Whether to first check input line to be a border of adjacent scope.
				-- Use it if you want to place cursor on function header to get scope of
				-- its body.
				try_as_border = false,
			},

			-- Which character to use for drawing scope indicator
			symbol = "▎",
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			char = "▎",
			char_blankline = "▎",
			context_char = "▎",
			char_priority = 12,
			-- space_char_blankline = " ",
			use_treesitter = true,
			use_treesitter_scope = false,
			show_current_context = true,
			show_current_context_start = true,
			show_first_indent_level = true,
			show_current_context_start_on_current_line = true,
			viewport_buffer = 10000,
			context_patterns = {
				"class",
				"struct",
				"enum",
				"^func",
				"method",
				"^if",
				"while",
				"for",
				"with",
				"try",
				"except",
				"arguments",
				"argument_list",
				"object",
				"dictionary",
				"element",
				"rule_set",
				"array",
				"table",
				"tuple",
				"do_block",
				"do_statement",
				"switch_statement",
				"case_statement",
			},
		},
		init = function()
			vim.opt.list = true
		end,
	},
}
