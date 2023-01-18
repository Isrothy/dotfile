return {
	"echasnovski/mini.move",
	keys = {
		{ "<M-j>", mode = { "n", "x" } },
		{ "<M-k>", mode = { "n", "x" } },
		{ "<M-h>", mode = { "n", "x" } },
		{ "<M-l>", mode = { "n", "x" } },
	},
	config = function()
		require("mini.move").setup({
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "<M-h>",
				right = "<M-l>",
				down = "<M-j>",
				up = "<M-k>",

				-- Move current line in Normal mode
				line_left = "<M-h>",
				line_right = "<M-l>",
				line_down = "<M-j>",
				line_up = "<M-k>",
			},
		})
	end,
}
