local function is_neominimap(arg)
	return vim.bo[arg.buf].filetype == "neominimap"
end

local function is_not_neominimap(arg)
	return not is_neominimap(arg)
end

return {
	"luukvbaal/statuscol.nvim",
	event = { "BufReadPre", "BufNewFile" },
	branch = "0.10",
	enabled = true,
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
					},
					condition = { is_not_neominimap },
				},
				{
					text = {
						builtin.lnumfunc,
						" ",
						builtin.foldfunc,
					},
					condition = { is_not_neominimap },
				},
				{
					sign = {
						namespace = { "gitsigns_" },
					},
					condition = { is_not_neominimap },
				},
				{
					sign = {
						namespace = { "neominimap_search" },
						maxwidth = 1,
						colwidth = 1,
					},
					condition = { is_neominimap },
				},
				{
					sign = {
						namespace = { "neominimap_git" },
						maxwidth = 1,
						colwidth = 1,
					},
					condition = { is_neominimap },
				},
			},
		}
	end,
}
