local M = {
	"lewis6991/satellite.nvim",
	event = {"BufReadPost", "BufNewFile"},
}
M.config = function()
	require("satellite").setup({
		current_only = false,
		winblend = 0,
		zindex = 40,
		excluded_filetypes = {
			"prompt",
			"TelescopePrompt",
			-- "neo-tree",
			"alpha",
			"dashboard",
		},
		width = 2,
		handlers = {
			search = {
				enable = true,
			},
			diagnostic = {
				enable = true,
			},
			gitsigns = {
				enable = true,
			},
			marks = {
				enable = false,
				show_builtins = true, -- shows the builtin marks like [ ] < >
			},
		},
	})
end
return M
