return {
	"gorbit99/codewindow.nvim",
	event = { "BufReadPost", "BufNewFile" },
	enabled = false,
	config = function()
		local codewindow = require("codewindow")
		codewindow.setup({
			active_in_terminals = false,
			auto_enable = true,
			exclude_filetypes = {
				"qf",
				"help",
			},
			minimap_width = 20,
			use_lsp = true,
			use_treesitter = true,
			use_git = true,
			width_multiplier = 4,
			z_index = 1,
			show_cursor = true,
			screen_bounds = "background",
			window_border = "rounded",
			events = {
				"LspAttach",
				"BufEnter",
				"BufNewFile",
				"BufRead",
				"TextChanged",
				"InsertLeave",
				"DiagnosticChanged",
				"FileWritePost",
			},
		})
		codewindow.apply_default_keybinds()
	end,
}
