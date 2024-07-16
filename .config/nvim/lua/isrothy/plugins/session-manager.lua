return {
	{
		"olimorris/persisted.nvim",
		lazy = false, -- make sure the plugin is always loaded at startup
		config = {
			autosave = true,
			use_git_branch = true,
			silent = true,
			should_autosave = function()
				-- do not autosave if the alpha dashboard is the current filetype
				if vim.bo.filetype == "alpha" then
					return false
				end
				return true
			end,
			on_autoload_no_session = function()
				vim.notify("No existing session to load.", vim.log.levels.WARN)
			end,
		},
	},
	{
		"folke/persistence.nvim",
		event = { "BufReadPre", "BufNewFile" },
		enabled = false,
		opts = {
			dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
		},
		keys = {
			{
				"<leader>ps",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>pl",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>pd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},
}
