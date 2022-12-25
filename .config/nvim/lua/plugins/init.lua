return {
	{
		"onsails/lspkind-nvim",
		dependencies = "famiu/bufdelete.nvim",
	},
	{
		"p00f/nvim-ts-rainbow",
		event = "BufReadPost",
	},
	--- context comment
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
	---entire object
	{
		"kana/vim-textobj-entire",
		event = "BufReadPost",
		dependencies = {
			{ "kana/vim-textobj-user" },
		},
	},
	--- targe object
	{
		"wellle/targets.vim",
		event = "BufReadPost",
	},
	--- treesitter object
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "BufReadPost",
	},
	{
		"kiyoon/treesitter-indent-object.nvim",
		init = function()
			vim.keymap.set(
				{ "x", "o" },
				"ai",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>"
			)
			vim.keymap.set(
				{ "x", "o" },
				"aI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>"
			)
			vim.keymap.set(
				{ "x", "o" },
				"ii",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>"
			)
			vim.keymap.set(
				{ "x", "o" },
				"iI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>"
			)
		end,
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
