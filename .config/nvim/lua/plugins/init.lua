return {
	{
		"p00f/nvim-ts-rainbow",
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
					config = {
						css = "/* %s */",
						javascript = {
							__default = "// %s",
							jsx_element = "{/* %s */}",
							jsx_fragment = "{/* %s */}",
							jsx_attribute = "// %s",
							comment = "// %s",
						},
						typescript = {
							__default = "// %s",
							__multiline = "/* %s */",
						},
					},
				},
			})
		end,
	},
	-- auto tag ----
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
	},

	{
		"samjwill/nvim-unception",
		event = "TermOpen",
	},

	{
		"keith/swift.vim",
		ft = { "swift" },
	},
	{
		"udalov/kotlin-vim",
		ft = { "kotlin" },
	},
	{
		"fladson/vim-kitty",
		ft = { "kitty" },
	},
}
