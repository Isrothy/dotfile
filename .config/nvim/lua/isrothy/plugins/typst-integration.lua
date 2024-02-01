return {
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		lazy = true,
		-- version = "0.1.*",
		build = function()
			require("typst-preview").update()
		end,
		opts = {
			debug = false,
			get_root = function(bufnr)
				return vim.api.nvim_buf_get_name(bufnr):match("(.*/)")
			end,
		},
	},
}
