local M = {
	"akinsho/bufferline.nvim",
	version = "v3.*",
	enabled = true,
	event = { "BufReadPost", "BufNewFile" },
	dependencies = "nvim-tree/nvim-web-devicons",
}

M.config = function()
	require("bufferline").setup({
		options = {
			mode = "buffers", -- set to "tabs" to only show tabpages instead
			-- numbers = "id",
			-- numbers = function(opts)
			-- 	return string.format("%s|%s", opts.ordinal, opts.raise(opts.id))
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
					local sym = e == "error" and " "
						or (e == "warning" and " " or (e == "hint" and " " or " "))
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
			show_duplicate_prefix = true,

			separator_style = "thin",
			-- separator_style = "slant",
			enforce_regular_tabs = false,
			always_show_bufferline = true,
		},
		highlights = require("nord.plugins.bufferline").akinsho(),
	})

	vim.keymap.set({ "n" }, "<s-tab>", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<tab>", "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<M-,>", "<cmd>BufferLineMovePrev<cr>", { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<M-.>", "<cmd>BufferLineMoveNext<cr>", { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<leader>bp", "<cmd>BufferLinePick<cr>", { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<leader>bc", "<cmd>BufferLinePickClose<cr>", { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<leader>br", "<cmd>BufferLineCloseRight<cr>", { noremap = true, silent = true })
	for i = 1, 10 do
		vim.keymap.set(
			"n",
			string.format("<leader>%d", i % 10),
			string.format("<cmd>lua require('bufferline').go_to_buffer(%d, false)<cr>", i),
			{ noremap = true, silent = true, desc = string.format("Go to buffer %d", i) }
		)
	end
	vim.keymap.set(
		"n",
		"<leader>$",
		"<Cmd>lua require('bufferline').go_to_buffer(-1, false)<CR>",
		{ noremap = true, silent = true, desc = string.format("Go to last buffer") }
	)
	vim.keymap.set(
		{ "n" },
		"]b",
		"<cmd>BufferLineCycleNext<cr>",
		{ noremap = true, silent = true, desc = "Buffer forward" }
	)
	vim.keymap.set(
		{ "n" },
		"[b",
		"<cmd>BufferLineCyclePrev<cr>",
		{ noremap = true, silent = true, desc = "Buffer backward" }
	)
	vim.keymap.set(
		{ "n" },
		"]B",
		"<cmd>lua require('bufferline').go_to_buffer(-1, false<cr>)",
		{ noremap = true, silent = true, desc = "Buffer last" }
	)
	vim.keymap.set(
		{ "n" },
		"[B",
		"<cmd>lua require('bufferline').go_to_buffer(1, false)<cr>",
		{ noremap = true, silent = true, desc = "Buffer first" }
	)
end

return M
