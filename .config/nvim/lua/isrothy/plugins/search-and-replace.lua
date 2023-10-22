return {
	{
		"roobert/search-replace.nvim",
		cmd = {
			"SearchReplaceSingleBufferOpen",
			"SearchReplaceMultiBufferOpen",

			"SearchReplaceSingleBufferCWord",
			"SearchReplaceSingleBufferCWORD",
			"SearchReplaceSingleBufferCExpr",
			"SearchReplaceSingleBufferCFile",

			"SearchReplaceMultiBufferCWord",
			"SearchReplaceMultiBufferCWORD",
			"SearchReplaceMultiBufferCExpr",
			"SearchReplaceMultiBufferCFile",

			"SearchReplaceSingleBufferSelections",
			"SearchReplaceMultiBufferSelections",

			"SearchReplaceSingleBufferWithinBlock",

			"SearchReplaceVisualSelection",
			"SearchReplaceVisualSelectionCWord",
			"SearchReplaceVisualSelectionCWORD",
			"SearchReplaceVisualSelectionCExpr",
			"SearchReplaceVisualSelectionCFile",
		},
		keys = {
			{ "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>" },
			{ "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>" },
			{ "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>" },
			{ "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>" },
			{ "<leader>rf", "<CMD>SearchReplaceSingleBufferFile<CR>" },

			{ "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>" },
			{ "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>" },
			{ "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>" },
			{ "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWORD<CR>" },
			{ "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>" },
			{ "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>" },

			{ "<C-r>", [[<CMD>SearchReplaceSingleBufferVisualSelection<CR>]], mode = "v" },
			{ "<C-b>", [[<CMD>SearchReplaceWithinVisualSelectionCWord<CR>]], mode = "v" },
		},
		opts = {
			default_replace_single_buffer_options = "gcI",
			default_replace_multi_buffer_options = "egcI",
		},
	},
	{
		"chrisgrieser/nvim-alt-substitute",
		opts = true,
		-- lazy-loading with `cmd =` does not work well with incremental preview
		event = "CmdlineEnter",
	},
}
