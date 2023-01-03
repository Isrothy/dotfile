local M = {
	"akinsho/bufferline.nvim",
	version = "v3.*",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = "kyazdani42/nvim-web-devicons",
}

M.config = function()
	require("bufferline").setup({
		options = {
			mode = "buffers", -- set to "tabs" to only show tabpages instead
			-- numbers = function(opts)
			-- 	return string.format("%s|%s", opts.id, opts.raise(opts.ordinal))
			-- end,
			indicator = {
				icon = "▎", -- this should be omitted if indicator style is not 'icon'
				-- style = "underline"
				style = "icon",
			},
			modified_icon = "●",
			left_trunc_marker = "",
			right_trunc_marker = "",
			max_name_length = 18,
			max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
			truncate_names = true,
			tab_size = 18,

			diagnostics = nil,
			-- diagnostics = "nvim_lsp",
			diagnostics_update_in_insert = true,

			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local s = ""
				for e, n in pairs(diagnostics_dict) do
					local sym = e == "error" and "  "
						or (e == "warning" and "  " or (e == "hint" and "  " or "  "))
					s = s .. sym .. n
				end
				return s
			end,

			color_icons = true,
			show_buffer_icons = true,
			show_buffer_close_icons = false,
			show_buffer_default_icon = true,
			show_close_icon = false,
			show_tab_indicators = true,
			show_duplicate_prefix = false,

			separator_style = "thin",
			-- separator_style = "slant",
			enforce_regular_tabs = false,
			always_show_bufferline = true,
		},
		highlights = require("nord.plugins.bufferline").akinsho(),
	})

	vim.keymap.set({ "n" }, "<M-h>", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<M-l>", "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true })
	for i = 1, 9 do
		vim.keymap.set(
			"n",
			string.format("<leader>%d", i),
			string.format("<cmd>BufferLineGoToBuffer %d<cr>", i, { noremap = true, silent = true })
		)
	end
	vim.keymap.set("n", "<leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>", { noremap = true, silent = true })
end

return M
