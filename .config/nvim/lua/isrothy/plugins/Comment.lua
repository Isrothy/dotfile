return {
	"numToStr/Comment.nvim",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			lazy = true,
			opts = {
				enable_autocmd = false,
				config = {
					css = "/* %s */",
					javascript = {
						__default = "// %s",
						jsx_element = "{/* %s */}",
						jsx_fragment = "{/* %s */}",
						jsx_attribute = "// %s",
						comment = "// %s",
					},
					typescript = { __default = "// %s", __multiline = "/* %s */" },
				},

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
