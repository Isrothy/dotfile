return {
	{
		"mbbill/undotree",
		init = function()
			vim.g.undotree_WindowLayout = 4
			vim.g.undotree_SplitWidth = 32
			vim.g.undotree_HelpLine = 0
		end,
		cmd = "UndotreeToggle",
	},
	{
		"tzachar/highlight-undo.nvim",
		keys = { { "u" }, { "<C-r>" } },
		opts = {
			duration = 300,
			undo = {
				hlgroup = "HighlightUndo",
				mode = "n",
				lhs = "u",
				map = "undo",
				opts = {},
			},
			redo = {
				hlgroup = "HighlightUndo",
				mode = "n",
				lhs = "<C-r>",
				map = "redo",
				opts = {},
			},
			highlight_for_count = true,
		},
	},
	{
		"kevinhwang91/nvim-fundo",
		dependencies = "kevinhwang91/promise-async",
		build = function()
			require("fundo").install()
		end,
		event = "VeryLazy",
	},
}
