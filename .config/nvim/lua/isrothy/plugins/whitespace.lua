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
