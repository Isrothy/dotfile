return {
	"numToStr/Comment.nvim",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			lazy = true,
			opts = {
				enable_autocmd = false,
			},
		},
	},
	keys = {
		{ "gc", mode = { "n", "v" } },
		{ "gb", mode = { "n", "v" } },
		"gcc",
		"gbc",
		"gcA",
		"gcO",
		"gco",
	},
	--opts = {
	--	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	-- },
	config = function()
		require("Comment").setup({
			pre_hook = function()
				return vim.bo.commentstring
			end,
		})
	end,
}
