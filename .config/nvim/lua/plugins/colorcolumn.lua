return {
	{
		"m4xshen/smartcolumn.nvim",
		event = { "BufRead", "BufNewFile" },
		enabled = false,
		config = function()
			require("smartcolumn").setup({
				colorcolumn = "",
				disabled_filetypes = { "help", "text", "markdown" },
				custom_colorcolumn = {
					c = "101",
					cpp = "101",
					java = "101",
					javascript = "101",
					javascriptreact = "101",
					kotlin = "101",
					lua = "121",
					typescript = "101",
					typescriptreact = "101",
					rust = "101",
				},
				scope = "file",
			})
		end,
	},
	{
		"Bekaboo/deadcolumn.nvim",
		lazy = false,
		enabled = false,
	},
}
