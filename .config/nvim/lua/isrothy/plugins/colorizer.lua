return {
	"brenoprata10/nvim-highlight-colors",
	event = { "BufReadPost", "BufNewFile" },
	init = function()
		vim.opt.termguicolors = true
	end,
	opts = {
		render = "background",
	},
}
