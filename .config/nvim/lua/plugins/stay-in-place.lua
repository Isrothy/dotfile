return {
	"gbprod/stay-in-place.nvim",
	keys = {
		{ ">", mode = { "n", "x" } },
		{ "<", mode = { "n", "x" } },
		{ "=", mode = { "n", "x" } },
		{ ">>", mode = { "n" } },
		{ "<<", mode = { "n" } },
		{ "==", mode = { "n" } },
	},
	config = function()
		require("stay-in-place").setup({
			set_keymaps = true,
			preserve_visual_selection = true,
		})
	end,
}
