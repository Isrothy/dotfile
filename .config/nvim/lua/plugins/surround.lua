local M = {
	"kylechui/nvim-surround",
	version = "",
}

M.keys = {
	{ "ds", mode = "n" },
	{ "cs", mode = "n" },
	{ "gs", mode = "n" },
	{ "gss", mode = "n" },
	{ "gS", mode = "n" },
	{ "gSS", mode = "n" },
	{ "<c-s>", mode = "v" },
	{ "g<c-s>", mode = "v" },
	{ "<c-g>s", mode = "i" },
	{ "<c-g>S", mode = "i" },
}

M.config = function()
	require("nvim-surround").setup({
		keymaps = {
			insert = "<c-g>s",
			insert_line = "<c-g>S",
			normal = "gs",
			normal_cur = "gss",
			normal_line = "gS",
			normal_cur_line = "gSS",
			visual = "<c-s>",
			visual_line = "g<c-s>",
			delete = "ds",
			change = "cs",
		},
	})
end

return M
