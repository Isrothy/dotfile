return {
	"mbbill/undotree",
	init = function()
		vim.g.undotree_WindowLayout = 4
		vim.g.undotree_SplitWidth = 32
		vim.g.undotree_HelpLine = 0
	end,
	cmd = "UndotreeToggle",
}
