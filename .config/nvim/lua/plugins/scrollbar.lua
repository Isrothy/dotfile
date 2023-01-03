local M = {
	"petertriho/nvim-scrollbar",
	event = {"BufReadPost", "BufNewFile"},
	enabled = false,
}

M.config = function()
	require("scrollbar").setup({
		show = true,
		show_in_active_only = false,
		set_highlights = true,
		folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
		max_lines = false, -- disables if no. of lines in buffer exceeds this
		hide_if_all_visible = true, -- Hides everything if all lines are visible
		throttle_ms = 30,
		handle = {
			text = " ",
			color = nil,
			cterm = nil,
			highlight = "CursorColumn",
			hide_if_all_visible = true, -- Hides handle if all lines are visible
		},
		marks = {
			Cursor = {
				text = "•",
				priority = 0,
				color = nil,
				cterm = nil,
				highlight = "Normal",
			},
			Search = {
				text = { "-", "=" },
				priority = 1,
				color = nil,
				cterm = nil,
				highlight = "Search",
			},
			Error = {
				text = { "-", "=" },
				priority = 2,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticVirtualTextError",
			},
			Warn = {
				text = { "-", "=" },
				priority = 3,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticVirtualTextWarn",
			},
			Info = {
				text = { "-", "=" },
				priority = 4,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticVirtualTextInfo",
			},
			Hint = {
				text = { "-", "=" },
				priority = 5,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticVirtualTextHint",
			},
			Misc = {
				text = { "-", "=" },
				priority = 6,
				color = nil,
				cterm = nil,
				highlight = "Normal",
			},
			GitAdd = {
				text = "┆",
				priority = 7,
				color = nil,
				cterm = nil,
				highlight = "GitSignsAdd",
			},
			GitChange = {
				text = "┆",
				priority = 7,
				color = nil,
				cterm = nil,
				highlight = "GitSignsChange",
			},
			GitDelete = {
				text = "▁",
				priority = 7,
				color = nil,
				cterm = nil,
				highlight = "GitSignsDelete",
			},
		},
		excluded_buftypes = {
			"terminal",
		},
		excluded_filetypes = {
			"prompt",
			"TelescopePrompt",
			"noice",
		},
		autocmd = {
			render = {
				"BufWinEnter",
				"TabEnter",
				"TermEnter",
				"WinEnter",
				"CmdwinLeave",
				"TextChanged",
				"VimResized",
				"WinScrolled",
			},
			clear = {
				"BufWinLeave",
				"TabLeave",
				"TermLeave",
				"WinLeave",
			},
		},
		handlers = {
			cursor = true,
			diagnostic = true,
			gitsigns = true, -- Requires gitsigns
			handle = true,
			search = true, -- Requires hlslens
		},
	})

	require("scrollbar.handlers").register("marksmarks", function(bufnr)
		local excluded_marks = ""
		local marks = vim.fn.getmarklist(bufnr)
		local out = {}
		table.insert(out, { line = 0, text = "" }) -- ensure at least one dummy element in return list to prevent errors when there is no valid mark

		for _, markObj in pairs(marks) do
			local mark = markObj.mark:sub(2, 2)
			local isLetter = mark:lower() ~= mark:upper()
			if isLetter and not (excluded_marks:find(mark)) then
				table.insert(out, {
					line = markObj.pos[2],
					text = mark,
					type = "Misc",
					level = 6,
				})
			end
		end
		return out
	end)
end

return M
