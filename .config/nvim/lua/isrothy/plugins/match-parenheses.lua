return {
	{
		"andymass/vim-matchup",
		event = { "BufReadPost", "BufNewFile" },
		enabled = true,
		init = function()
			vim.g.loaded_matchparen = 1
			vim.g.matchup_motion_override_Npercent = 0
			vim.g.matchup_matchparen_fallback = 0
			vim.g.matchup_matchparen_deferred = 1
			vim.g.matchup_matchparen_offscreen = {
				method = "status_manual",
			}
			vim.g.matchup_matchparen_deferred = 1
			vim.g.matchup_matchparen_hi_surround_always = 1
			vim.g.matchup_motion_override_Npercent = 1
		end,
	},
	{
		"utilyre/sentiment.nvim",
		enabled = false,
		version = "*",
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
