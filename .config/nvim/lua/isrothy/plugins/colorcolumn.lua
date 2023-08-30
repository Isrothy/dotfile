return {
	"fmbarina/multicolumn.nvim",
	enabled = true,
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
				scope = "file",
				rulers = { 121 },
				full_column = true,
			},
			python = {
				scope = "window",
				rulers = { 80 },
			},
			c = {
				scope = "window",
				rulers = { 101 },
				always_on = true,
			},
			cpp = {
				scope = "window",
				rulers = { 101 },
				always_on = true,
			},
		},
		line_limit = 0,
		exclude_floating = true,
		exclude_ft = { "markdown", "help", "netrw" },
	},
}
