local M = {
	"kylechui/nvim-surround",
	version = "*",
}

M.keys = {
	{ "ds", mode = "n" },
	{ "cs", mode = "n" },
	{ "ys", mode = "n" },
	{ "yss", mode = "n" },
	{ "yS", mode = "n" },
	{ "ySS", mode = "n" },
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
			normal = "ys",
			normal_cur = "yss",
			normal_line = "yS",
			normal_cur_line = "ySS",
			visual = "<c-s>",
			visual_line = "g<c-s>",
			delete = "ds",
			change = "cs",
		},
	})
end

return M
