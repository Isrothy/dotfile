return {
	{
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout" },
		init = function()
			vim.keymap.set(
				"n",
				"<leader>bd",
				"<cmd>Bdelete<CR>",
				{ noremap = true, silent = true, desc = "Delete buffer" }
			)
			vim.keymap.set(
				"n",
				"<leader>bw",
				"<cmd>Bwipeout<CR>",
				{ noremap = true, silent = true, desc = "Wipeout buffer" }
			)
		end,
	},
	{
		"stevearc/stickybuf.nvim",
		-- event = "BufWinEnter",
		enabled = false,
		config = function()
			require("stickybuf").setup({})
		end,
	},
}
