return {
	"gorbit99/codewindow.nvim",
	event = "BufReadPre",
	config = function()
		local codewindow = require("codewindow")
		codewindow.setup({
			active_in_terminals = false, -- Should the minimap activate for terminal buffers
			auto_enable = true, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
			exclude_filetypes = {
				"qf",
				"help",
			},
			minimap_width = 20, -- The width of the text part of the minimap
			width_multiplier = 4, -- How many characters one dot represents
			z_index = 1, -- The z-index the floating window will be on
			show_cursor = true, -- Show the cursor position in the minimap
			screen_bounds = "background", -- How the visible area is displayed, "lines": lines above and below, "background": background color
			window_border = "none", -- The border style of the floating window (accepts all usual options)
		})
		codewindow.apply_default_keybinds()
	end,
}
