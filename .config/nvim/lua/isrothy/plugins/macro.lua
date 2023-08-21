return {
	{
		"ecthelionvi/NeoComposer.nvim",
		event = "VeryLazy",
		enabled = false,
		dependencies = { "kkharji/sqlite.lua" },
		config = function()
			local c = require("nord.colors").palette
			require("NeoComposer").setup({
				notify = true,
				delay_timer = "150",
				colors = {
					bg = c.polar_night.brighter,
					fg = c.aurora.orange,
					red = c.aurora.red,
					blue = c.frost.artic_ocean,
					green = c.aurora.green,
				},
				keymaps = {
					play_macro = "Q",
					yank_macro = "yq",
					stop_macro = "cq",
					toggle_record = "q",
					cycle_next = "<c-n>",
					cycle_prev = "<c-p>",
					toggle_macro_menu = "<m-q>",
				},
			})
			require("telescope").load_extension("macros")
		end,
	},
}
