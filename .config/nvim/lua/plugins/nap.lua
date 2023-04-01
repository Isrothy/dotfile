return {
	"liangxianzhe/nap.nvim",
	keys = { "[", "]" },
	lazy = false,
	enabled = false,
	config = function()
		local nap = require("nap")
		nap.setup({
			next_prefix = "]",
			prev_prefix = "[",
			next_repeat = "<cr>",
			prev_repeat = "<c-cr>",
		})
		nap.nap(
			"d",
			"lua vim.diagnostic.goto_next({float={border = 'rounded'}})",
			"lua vim.diagnostic.goto_prev({float={border = 'rounded'}})",
			"Next diagnostic",
			"Previous diagnostic"
		)
		nap.nap("b", "BufferLineCycleNext", "BufferLineCyclePrev", "Next buffer", "Previous buffer")
		nap.nap(
			"B",
			"lua require('bufferline').go_to_buffer(-1, false)",
			"lua require('bufferline').go_to_buffer(1, false)",
			"Last buffer",
			"First buffer"
		)
	end,
}
