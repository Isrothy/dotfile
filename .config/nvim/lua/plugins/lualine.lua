local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	enabled = true,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"Isrothy/lualine-diagnostic-message",
		"meuter/lualine-so-fancy.nvim",
	},
}

M.config = function()
	local function tab_size()
		return (vim.bo.expandtab and "SP" or "TAB") .. vim.bo.tabstop
	end

	--- Trailing whitespaces
	local function trailing_whitespace()
		local space = vim.fn.search([[\s\+$]], "nwc")
		return space ~= 0 and "TW:" .. space or ""
	end

	--- Mixed indent
	local function mixed_indent()
		local space_pat = [[\v^ +]]
		local tab_pat = [[\v^\t+]]
		local space_indent = vim.fn.search(space_pat, "nwc")
		local tab_indent = vim.fn.search(tab_pat, "nwc")
		local mixed = (space_indent > 0 and tab_indent > 0)
		local mixed_same_line
		if not mixed then
			mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
			mixed = mixed_same_line > 0
		end
		if not mixed then
			return ""
		end
		if mixed_same_line ~= nil and mixed_same_line > 0 then
			return "MI:" .. mixed_same_line
		end
		local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
		local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
		if space_indent_cnt > tab_indent_cnt then
			return "MI:" .. tab_indent
		else
			return "MI:" .. space_indent
		end
	end

	---- Truncating components in smaller window
	local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
		return function(str)
			local win_width = vim.fn.winwidth(0)
			if hide_width and win_width < hide_width then
				return ""
			elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
				return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
			end
			return str
		end
	end

	--- Using external source for diff
	local function diff_source()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed,
			}
		end
	end

	local function codeiumIcon()
		return "{…}"
	end

	local c = require("nord.colors").palette

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "nord",
			-- component_separators = { left = '╲', right = '╱' },
			component_separators = "",
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {
					"neo-tree",
					"aerial",
					"packer",
					"alpha",
					"dap-repl",
					"dapui_watches",
					"dapui_stacks",
					"dapui_breakpoints",
					"dapui_scopes",
					"dapui_colsoles",
					-- "toggleterm",
					-- "BufTerm",
					"",
				},
			},
			always_divide_middle = true,
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				{ "fancy_mode", width = 6 },
				-- { require("recorder").recordingStatus },
				-- { require("recorder").displaySlots },
				{
					"fancy_macro",
					icon = { "⏺" },
				},
				{
					require("noice").api.statusline.command.get,
					cond = require("noice").api.statusline.command.has,
				},
			},
			lualine_b = {
				{
					"b:gitsigns_head",
					icon = "",
				},
				{
					"diff",
					source = diff_source,
					colored = true,
				},
			},
			lualine_c = {
				{
					"filename",
					file_status = true,
					newfile_status = true,
					symbols = {
						modified = "[+]", -- Text to show when the file is modified.
						readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
						unnamed = "[UNNAMED]", -- Text to show for unnamed buffers.
						newfile = "[New]",
					},
					fmt = trunc(90, 30, 50),
					path = 1,
				},
				{
					"diagnostic-message",
					icons = {
						error = " ",
						warn = " ",
						hint = " ",
						info = " ",
					},
				},
			},
			lualine_x = {
				-- mixed_indent,
				-- trailing_whitespace,
				tab_size,
				"encoding",
				{
					"fileformat",
					icons_enabled = true,
					symbols = {
						unix = "LF",
						dos = "CRLF",
						mac = "CR",
					},
				},
			},
			lualine_y = {
				"fancy_filetype",
				"fancy_lsp_servers",
				codeiumIcon,
				"%3{codeium#GetStatusString()}",
			},
			lualine_z = {
				{
					"fancy_searchcount",
					icon = { "󰱽", color = { fg = c.snow_storm.origin } },
				},
				"location",
				"filesize",
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"aerial",
					-- The separator to be used to separate symbols in status line.
					sep = " ❯ ",
					-- The number of symbols to render top-down. In order to render only 'N' last
					-- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
					-- be used in order to render only current symbol.
					depth = nil,
					-- When 'dense' mode is on, icons are not rendered near their symbols. Only
					-- a single icon that represents the kind of current symbol is rendered at
					-- the beginning of status line.
					dense = false,
					-- The separator to be used to separate symbols in dense mode.
					dense_sep = ".",

					colored = true,
				},
			},
			lualine_x = {
				{
					"diagnostics",
					update_in_insert = true,
					symbols = {
						error = " ",
						warn = " ",
						hint = " ",
						info = " ",
					},
				},
				-- "fancy_diagnostics"
			},
			lualine_y = {
				{ "filetype", icon_only = true },
				{ "filename", fmt = trunc(90, 30, 50), path = 1 },
			},
			lualine_z = {},
		},

		inactive_winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {
				{ "filetype", icon_only = true },
				{ "filename", fmt = trunc(90, 30, 50), path = 1 },
			},
			lualine_z = {},
		},
		tabline = {},
		extensions = {
			"aerial",
			"toggleterm",
			"neo-tree",
			"quickfix",
		},
	})
end

return {
	M,
}
