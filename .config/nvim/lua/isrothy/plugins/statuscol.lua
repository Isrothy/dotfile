return {
	"luukvbaal/statuscol.nvim",
	event = { "BufReadPre", "BufNewFile" },
	branch = "0.10",
	init = function()
		vim.opt.number = true
		vim.opt.relativenumber = true
	end,
	opts = function()
		local builtin = require("statuscol.builtin")
		return {
			setopt = true,
			relculright = true,
			ft_ignore = {
				"aerial",
				"neo-tree",
				"undotree",
			},
			bt_ignore = {
				"terminal",
				"nofile"
			},
			segments = {
				{
					sign = {
						namespace = { ".*" },
						name = { ".*" },
						maxwidth = 1,
						colwidth = 2,
					},
				},
				{
					text = {
						builtin.lnumfunc,
						" ",
						builtin.foldfunc,
					},
				},
				{
					sign = {
						-- name = { "GitSign*" },
						--
						--
						--
						namespace = { "gitsigns_" },
						maxwidth = 1,
						colwidth = 2,
					},
				},
			},
		}
	end,
}
