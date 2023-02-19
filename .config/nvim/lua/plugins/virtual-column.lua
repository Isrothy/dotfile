return {
	{
		"lukas-reineke/virt-column.nvim",
		-- event = "VeryLazy",
		-- event = { "BufNewFile", "BufReadPre" },
		enabled = true,
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
