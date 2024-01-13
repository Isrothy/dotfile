return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	opts = {
		map_bs = true,
		map_c_h = true,
		check_ts = true,
		map_c_w = true,
		enable_check_bracket_line = true,
		ignored_next_char = "[%w%.]",
		disable_filetype = {
			"TelescopePrompt",
			"spectre_panel",
		},
		fast_wrap = {
			map = "<M-e>",
			chars = { "{", "[", "(", '"', "'" },
			pattern = [=[[%'%"%>%]%)%}%,]]=],
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			manual_position = true,
			highlight = "Search",
			highlight_grey = "Comment",
		},
	},
	config = function(_, opts)
		require("nvim-autopairs").setup(opts)
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
