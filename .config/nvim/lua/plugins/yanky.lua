return {
	"gbprod/yanky.nvim",
	enabled = true,
	event = "VeryLazy",
	config = function()
		local utils = require("yanky.utils")
		local mapping = require("yanky.telescope.mapping")
		require("yanky").setup({
			ring = {
				history_length = 128,
				storage = "shada",
				sync_with_numbered_registers = true,
				cancel_event = "update",
			},
			picker = {
				select = {
					action = require("yanky.picker").actions.set_register("+"), -- nil to use default put action
				},
				telescope = {
					mappings = {
						default = mapping.put("p"),
						i = {
							-- ["<c-p>"] = mapping.put("p"),
							-- ["<c-k>"] = mapping.put("P"),
							["<c-x>"] = mapping.delete(),
							["<c-r>"] = mapping.set_register(utils.get_default_register()),
						},
						n = {
							p = mapping.put("p"),
							P = mapping.put("P"),
							d = mapping.delete(),
							r = mapping.set_register(utils.get_default_register()),
						},
					}, -- nil to use default mappings
				},
			},
			system_clipboard = {
				sync_with_ring = false,
			},
			highlight = {
				on_put = true,
				on_yank = true,
				timer = 250,
			},
			preserve_cursor_position = {
				enabled = true,
			},
		})
		vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
		vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
		vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
		vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

		vim.keymap.set("n", "<M-n>", "<Plug>(YankyCycleForward)")
		vim.keymap.set("n", "<M-p>", "<Plug>(YankyCycleBackward)")

		vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

		vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
		vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
		vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
		vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

		vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
		vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
		vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
		vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

		vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
		vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
		require("telescope").load_extension("yank_history")
	end,
}
