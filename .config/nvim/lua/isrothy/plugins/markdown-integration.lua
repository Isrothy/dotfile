return {
	{
		"iamcco/markdown-preview.nvim",
		-- build = "cd app && npm install",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		build = function() vim.fn["mkdp#util#install"]() end,
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
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		ft = { "markdown" },
		enabled = false,
		opts = {
			auto_load = false, -- whether to automatically load preview when
			-- entering another markdown buffer
			close_on_bdelete = true, -- close preview window on buffer delete

			syntax = true, -- enable syntax highlighting, affects performance

			theme = "dark", -- 'dark' or 'light'

			update_on_change = true,

			app = "browser", -- 'webview', 'browser', string or a table of strings
			-- explained below

			filetype = { "markdown" }, -- list of filetypes to recognize as markdown

			-- relevant if update_on_change is true
			throttle_at = 200000, -- start throttling when file exceeds this
			-- amount of bytes in size
			throttle_time = "auto", -- minimum amount of time in milliseconds
			-- that has to pass before starting new render
		},
		config = function(_, opts)
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
			require("peek").setup(opts)
		end,
	},
}
