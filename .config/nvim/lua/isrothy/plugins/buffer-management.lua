return {
	{
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout" },
		enabled = true,
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
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		opts = {
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
		},
		keys = {
			{
				"<leader>H",
				function()
					require("harpoon"):list():append()
				end,
				desc = "Harpoon file",
			},
			{
				"<leader>h",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon quick menu",
			},
			{
				"<leader>1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Harpoon to file 1",
			},
			{
				"<leader>2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Harpoon to file 2",
			},
			{
				"<leader>3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon to file 3",
			},
			{
				"<leader>4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Harpoon to file 4",
			},
			{
				"<leader>5",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "Harpoon to file 5",
			},
			{
				"<leader>6",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "Harpoon to file 6",
			},
			{
				"<leader>7",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "Harpoon to file 7",
			},
			{
				"<leader>8",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "Harpoon to file 8",
			},
			{
				"<leader>9",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "Harpoon to file 9",
			},
		},
	},
}
