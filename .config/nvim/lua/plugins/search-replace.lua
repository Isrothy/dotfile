local M = {
	"roobert/search-replace.nvim",
	config = function()
		require("search-replace").setup({
			default_replace_single_buffer_options = "gcI",
			default_replace_multi_buffer_options = "egcI",
		})
	end,
}

M.cmd = {
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
}

M.keys = {
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
}

return M
