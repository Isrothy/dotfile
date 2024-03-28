return {
	{ "keith/swift.vim", ft = { "swift" } },
	{ "udalov/kotlin-vim", ft = { "kotlin" } },
	{ "fladson/vim-kitty", ft = { "kitty" } },
	{ "kaarmu/typst.vim", ft = { "typst" } },
	{ "mtdl9/vim-log-highlighting", ft = { "log" } },
	{
		"https://github.com/apple/pkl-neovim",
		event = "BufReadPre *.pkl",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		build = function()
			vim.cmd("TSInstall! pkl")
		end,
	},
}
