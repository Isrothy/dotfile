return {
	{
		"lukas-reineke/virt-column.nvim",
		-- event = "VeryLazy",
		-- event = { "BufNewFile", "BufReadPre" },
		enabled = false,
		lazy = false,
		config = function()
			require("virt-column").setup()
		end,
	},
	{
		"xiyaowong/virtcolumn.nvim",
		enabled = false,
		lazy = false,
		event = { "BufNewFile", "BufReadPre" },
	},
}
