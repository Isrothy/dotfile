return {
	"mvllow/modes.nvim",
	tag = "v0.2.0",
	event = { "BufReadPost", "BufNewFile" },
	enabled = false,
	config = function()
		require("modes").setup({
			colors = {
				copy = "#EBCB8B",
				delete = "#BF616A",
				insert = "#81A1C1",
				visual = "#9745be",
			},

			-- Set opacity for cursorline and number background
			line_opacity = 0.15,

			-- Enable cursor highlights
			set_cursor = true,
			-- Enable cursorline initially, and disable cursorline for inactive windows
			-- or ignored filetypes
			set_cursorline = false,

			-- Enable line number highlights to match cursorline
			set_number = true,

			-- Disable modes highlights in specified filetypes
			-- Please PR commonly ignored filetypes
			ignore_filetypes = {
				-- "NvimTree",
				-- "neo-tree",
				-- "TelescopePrompt",
			},
		})
	end,
}
