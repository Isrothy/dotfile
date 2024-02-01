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
					text = { builtin.lnumfunc, " " },
				},
				{
					text = {
						builtin.foldfunc,
					},
				},
				{
					sign = {
						-- name = { "GitSign*" },
						namespace = { "gitsigns_extmark_signs_" },
						maxwidth = 1,
						colwidth = 1,
					},
				},
			},
		}
	end,
}
