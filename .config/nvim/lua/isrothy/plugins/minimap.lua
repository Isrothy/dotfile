return {
	"gorbit99/codewindow.nvim",
	enabled = false,
	event = { "BufRead", "BufNewFile" },
	config = function()
		local codewindow = require("codewindow")
		local config = {
			active_in_terminals = false, -- Should the minimap activate for terminal buffers
			auto_enable = true, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
			exclude_filetypes = {
				"alpha",
				"aerial",
				"neo-tree",
			}, -- Choose certain filetypes to not show minimap on
			max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
			max_lines = nil, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
			minimap_width = 20, -- The width of the text part of the minimap
			use_lsp = true, -- Use the builtin LSP to show errors and warnings
			use_treesitter = true, -- Use nvim-treesitter to highlight the code
			use_git = true, -- Show small dots to indicate git additions and deletions
			width_multiplier = 4, -- How many characters one dot represents
			z_index = 1, -- The z-index the floating window will be on
			show_cursor = true, -- Show the cursor position in the minimap
			window_border = "none", -- The border style of the floating window (accepts all usual options)
		}
		codewindow.setup(config)
		-- config = require("codewindow.config").setup(config)
		-- vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave", "BufWipeout", "WinClosed", "WinLeave", "BufWinEnter" }, {
		-- 	callback = function()
		-- 		local filetype = vim.bo.filetype
		-- 		local should_open = true
		-- 		if type(config.auto_enable) == "boolean" then
		-- 			should_open = config.auto_enable
		-- 		else
		-- 			for _, v in ipairs(config.auto_enable) do
		-- 				if v == filetype then
		-- 					should_open = true
		-- 				end
		-- 			end
		-- 		end
		--
		-- 		if should_open then
		-- 			vim.defer_fn(require("codewindow").open_minimap, 0)
		-- 		end
		-- 	end,
		-- })
	end,
}
