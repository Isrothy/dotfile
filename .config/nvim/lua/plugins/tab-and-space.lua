return {
	{
		"echasnovski/mini.trailspace",
		enabled = true,
		event = { "BufReadPost", "BufNewFile" },
		init = function()
			vim.api.nvim_create_user_command("MiniTrailspace", "lua MiniTrailspace.trim()", {})
			vim.api.nvim_create_user_command("MiniTrailspaceLastlines", "lua MiniTrailspace.trim_last_lines()", {})
		end,
		config = function()
			require("mini.trailspace").setup({
				only_in_normal_buffers = true,
			})
		end,
	},
	{
		"Darazaki/indent-o-matic",
		event = { "BufReadPre", "BufNewFile" },
		enabled = true,
		config = function()
			require("indent-o-matic").setup({
				-- The values indicated here are the defaults

				-- Number of lines without indentation before giving up (use -1 for infinite)
				max_lines = -1,

				-- Space indentations that should be detected
				standard_widths = { 2, 4, 8 },

				-- Skip multi-line comments and strings (more accurate detection but less performant)
				skip_multiline = true,
			})
		end,
	},
	{
		"tenxsoydev/tabs-vs-spaces.nvim",
		event = { 'BufReadPost, "BufNewFile' },
		config = function()
			require("tabs-vs-spaces").setup({
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
			})
		end,
	},
}
