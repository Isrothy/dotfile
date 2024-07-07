return {
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		lazy = true,
		version = "0.3.*",
		-- version = "0.1.*",
		build = function()
			require("typst-preview").update()
		end,
		opts = {
			debug = false,
			get_root = function(path_of_main_file)
				return vim.fn.fnamemodify(path_of_main_file, ":p:h")
			end,
		},
	},
}
