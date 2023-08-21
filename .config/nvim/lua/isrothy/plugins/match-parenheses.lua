return {
	{
		"andymass/vim-matchup",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		config = function()
			vim.g.matchup_matchparen_offscreen = {
				method = "status_manual",
			}
			vim.g.matchup_motion_override_Npercent = 0
		end,
	},
}
