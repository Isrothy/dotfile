return {
	"luukvbaal/statuscol.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.number = true
		vim.opt.relativenumber = true
	end,
	opts = function()
		local builtin = require("statuscol.builtin")
		return {
			setopt = true,
			relculright = true,
			-- thousands = "'",
			ft_ignore = {
				"aerial",
				"neo-tree",
				"undotree",
			},
			segments = {
				{
					text = {
						builtin.foldfunc,
					},
				},
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
					sign = {
						name = { "GitSign*" },
						maxwidth = 1,
						colwidth = 1,
					},
				},
			},
		}
	end,
}
