return {
	{
		"monkoose/matchparen.nvim",
		enabled = false,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("matchparen").setup({
				on_startup = true, -- Should it be enabled by default
				hl_group = "MatchParen", -- highlight group for matched characters
				augroup_name = "matchparen", -- almost no reason to touch this unless there is already augroup with such name
			})
		end,
	},
	{
		"andymass/vim-matchup",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
			vim.g.matchup_motion_override_Npercent = 0
		end,
	},
}
