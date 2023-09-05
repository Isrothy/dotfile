return {
	{
		"andymass/vim-matchup",
		event = { "BufReadPost", "BufNewFile" },
		enabled = false,
		config = function()
			vim.g.matchup_matchparen_offscreen = {
				method = "status_manual",
			}
			vim.g.matchup_motion_override_Npercent = 0
		end,
	},
	{
		"utilyre/sentiment.nvim",
		enabled = true,
		version = "*",
		-- event = "VeryLazy", -- keep for lazy loading
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- config
		},
		init = function()
			-- `matchparen.vim` needs to be disabled manually in case of lazy loading
			vim.g.loaded_matchparen = 1
		end,
	},
}
