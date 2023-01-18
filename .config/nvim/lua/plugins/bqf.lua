local M = {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	-- enabled = false,
	-- lazy = false,
	-- event = "QuickFixCmdPre",
	-- event = "VeryLazy",
	config = function()
		require("bqf").setup({
			auto_enable = true,
			magic_window = true,
			-- auto_resize_height = true,
		})
	end,
}

return M
