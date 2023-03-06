return {
	"Isrothy/toolwindow.nvim",
	enabled = false,
	init = function()
		vim.keymap.set(
			{ "n", "x", "t" },
			"<F5>",
			":lua require('toolwindow').open_window('term', nil)<CR>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			{ "n", "x", "t" },
			"<F6>",
			":lua require('toolwindow').open_window('todo', nil)<CR>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			{ "n", "x", "t" },
			"<F7>",
			":lua require('toolwindow').open_window('trouble', nil)<CR>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			{ "n", "x", "t" },
			"<F8>",
			":lua require('toolwindow').close()<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
