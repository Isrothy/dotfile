return {
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				options = {
					enabled = true,
					ruler = true,
					showcmd = false,
				},
				twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
				gitsigns = { enabled = true }, -- disables git signs
				tmux = { enabled = false }, -- disables the tmux statusline
				kitty = {
					enabled = false,
					font = "+1", -- font size increment
				},
			},
		},
	},
	{
		"folke/twilight.nvim",
		cmd = {
			"ZenMode",
			"TZAtaraxis",
			"TZMinimalist",
			"TZNarrow",
			"TZFocus",
			"Twilight",
			"TwilightEnable",
			"TwilightDisable",
		},
		opts = {
			dimming = {
				alpha = 0.25, -- amount of dimming
				color = { "Normal", "#ECEFF4" },
				term_bg = "#2E3141", -- if guibg=NONE, this will be used to calculate text color
				inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
			},
		},
	},
}
