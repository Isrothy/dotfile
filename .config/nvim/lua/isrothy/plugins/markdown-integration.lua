return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		config = function()
			local home = os.getenv("HOME")
			vim.g.mkdp_markdown_css = home .. "/.config/nvim/style/markdown.css"
			vim.g.mkdp_highlight_css = home .. "/.config/nvim/style/highlight.css"
			vim.g.mkdp_theme = "dark"
			vim.g.mkdp_auto_close = 1
		end,
	},
	{
		{
			"Kicamon/markdown-table-mode.nvim",
			ft = { "markdown" },
			config = function()
				require("markdown-table-mode").setup()
			end,
		},
	},
}
