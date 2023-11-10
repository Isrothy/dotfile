return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	opts = {
		allow_different_key = true,
		disabled_filetypes = {
			"qf",
			"netrw",
			"NvimTree",
			"neo-tree",
			"lazy",
			"mason",
			"terminal",
			"toggleterm",
		},
	},
}
