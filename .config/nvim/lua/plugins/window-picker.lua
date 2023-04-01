local M = {
	"s1n7ax/nvim-window-picker",
	version = "v1.*",
	enabled = true,
}

M.keys = {
	{
		"<leader>wp",
		function()
			local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
			vim.api.nvim_set_current_win(picked_window_id)
		end,
		{ desc = "Pick a window" },
		mode = "n",
	},
}

M.config = function()
	local c = require("nord.colors").palette
	require("window-picker").setup({
		autoselect_one = true,
		include_current = false,
		filter_rules = {
			-- filter using buffer options
			bo = {
				-- if the file type is one of following, the window will be ignored
				filetype = {
					"neo-tree",
					"neo-tree-popup",
					"notify",
					"quickfix",
					"aerial",
				},

				-- if the buffer type is one of following, the window will be ignored
				buftype = {
					"terminal",
					"aerial",
				},
			},
		},
		other_win_hl_color = c.frost.ice,
	})
end
return M
