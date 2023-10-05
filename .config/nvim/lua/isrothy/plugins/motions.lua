return {
	{
		"folke/flash.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "n", "o", "x" },
				function()
					-- show labeled treesitter nodes around the search matches
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
		},
		opts = {},
	},
	{
		"Aasim-A/scrollEOF.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = { -- The pattern used for the internal autocmd to determine
			-- where to run scrollEOF. See https://neovim.io/doc/user/autocmd.html#autocmd-pattern
			pattern = "*",
			-- Whether or not scrollEOF should be enabled in insert mode
			insert_mode = true,
			-- List of filetypes to disable scrollEOF for.
			disabled_filetypes = {},
			-- List of modes to disable scrollEOF for. see https://neovim.io/doc/user/builtin.html#mode() for available modes.
			disabled_modes = {},
		},
	},
}
