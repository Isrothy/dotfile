return {
	"gbprod/cutlass.nvim",
	event = "VeryLazy",
	enabled = false,
	config = function()
		require("cutlass").setup({
			cut_key = nil,
			override_del = true,
			exclude = {},
		})
	end,
}
