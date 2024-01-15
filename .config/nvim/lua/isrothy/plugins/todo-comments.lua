local M = {
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = "nvim-lua/plenary.nvim",
}

M.opts = {
	sign_priority = 30,
	merge_keywords = true,
	highlight = {
		exclude = { "qf" },
	},
	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#BF616A" },
		warning = { "DiagnosticWarn", "WarningMsg", "#EBCB8B" },
		info = { "DiagnosticInfo", "#5E81AC" },
		hint = { "DiagnosticHint", "#81A1C1" },
		default = { "Identifier", "#8FBCBB" },
		test = { "Identifier", "#A3BE8C" },
	},
}

M.config = function(_, opts)
	require("todo-comments").setup(opts)

	vim.keymap.set("n", "]t", function()
		require("todo-comments").jump_next()
	end, {
		desc = "Next todo comment",
	})

	vim.keymap.set("n", "[t", function()
		require("todo-comments").jump_prev()
	end, {
		desc = "Previous todo comment",
	})
	vim.keymap.set("n", "<leader>qt", "<cmd>TodoQuickFix<cr>", { desc = "Quickfix todolist" })
end

return M
