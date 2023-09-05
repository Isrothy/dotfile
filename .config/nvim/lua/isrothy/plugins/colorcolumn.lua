return {
	"fmbarina/multicolumn.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		start = "enabled",
		base_set = {
			scope = "window",
			rulers = {},
			to_line_end = false,
			full_column = true,
			always_on = true,
		},
		sets = {
			lua = {
				rulers = { 121 },
			},
			python = {
				rulers = { 80 },
			},
			c = {
				rulers = { 101 },
			},
			cpp = {
				rulers = { 101 },
			},
		},
		line_limit = 0,
		exclude_floating = true,
		exclude_ft = { "markdown", "help", "netrw" },
	},
}
