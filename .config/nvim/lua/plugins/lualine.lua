local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "kyazdani42/nvim-web-devicons" },
	},
}

M.config = function()
	local utils = require("lualine.utils.utils")
	local highlight = require("lualine.highlight")

	local function tab_size()
		return (vim.bo.expandtab and "SP" or "TAB") .. vim.bo.tabstop
	end

	local diagnostics_message = require("lualine.component"):extend()

	diagnostics_message.default = {
		colors = {
			error = utils.extract_color_from_hllist(
				{ "fg", "sp" },
				{ "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
				"#e32636"
			),
			warn = utils.extract_color_from_hllist(
				{ "fg", "sp" },
				{ "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
				"#ffa500"
			),
			info = utils.extract_color_from_hllist(
				{ "fg", "sp" },
				{ "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
				"#ffffff"
			),
			hint = utils.extract_color_from_hllist(
				{ "fg", "sp" },
				{ "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
				"#273faf"
			),
		},
	}
	function diagnostics_message:init(options)
		diagnostics_message.super:init(options)
		self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
		self.highlights = { error = "", warn = "", info = "", hint = "" }
		self.highlights.error = highlight.create_component_highlight_group(
			{ fg = self.options.colors.error },
			"diagnostics_message_error",
			self.options
		)
		self.highlights.warn = highlight.create_component_highlight_group(
			{ fg = self.options.colors.warn },
			"diagnostics_message_warn",
			self.options
		)
		self.highlights.info = highlight.create_component_highlight_group(
			{ fg = self.options.colors.info },
			"diagnostics_message_info",
			self.options
		)
		self.highlights.hint = highlight.create_component_highlight_group(
			{ fg = self.options.colors.hint },
			"diagnostics_message_hint",
			self.options
		)
	end

	function diagnostics_message:update_status(is_focused)
		local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
		local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
		if #diagnostics > 0 then
			local top = diagnostics[1]
			for _, d in ipairs(diagnostics) do
				if d.severity < top.severity then
					top = d
				end
			end
			local icons = { " ", " ", " ", " " }
			local hl = {
				self.highlights.error,
				self.highlights.warn,
				self.highlights.info,
				self.highlights.hint,
			}
			return highlight.component_format_highlight(hl[top.severity])
				.. icons[top.severity]
				.. " "
				.. utils.stl_escape(top.message)
		else
			return ""
		end
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

	-- --- Changing filename color based on modified status
	-- local custom_fname = require("lualine.components.filename"):extend()
	-- local default_status_colors = { saved = "#D8DEE9", modified = "#EBCB8B" }

	-- function custom_fname:init(options)
	-- 	custom_fname.super.init(self, options)
	-- 	self.status_colors = {
	-- 		saved = highlight.create_component_highlight_group(
	-- 			{ fg = default_status_colors.saved },
	-- 			"filename_status_saved",
	-- 			self.options
	-- 		),
	-- 		modified = highlight.create_component_highlight_group(
	-- 			{ fg = default_status_colors.modified },
	-- 			"filename_status_modified",
	-- 			self.options
	-- 		),
	-- 	}
	-- 	if self.options.color == nil then
	-- 		self.options.color = ""
	-- 	end
	-- end

	-- function custom_fname:update_status()
	-- 	local data = custom_fname.super.update_status(self)
	-- 	data = highlight.component_format_highlight(
	-- 		vim.bo.modified and self.status_colors.modified or self.status_colors.saved
	-- 	) .. data
	-- 	return data
	-- end

	require("lualine").setup({
		options = {
			icons_enabled = true,
			-- theme = myNord,
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
					"toggleterm",
					"",
				},
			},
			always_divide_middle = true,
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				{ "mode" },
				{ require("recorder").recordingStatus },
				{ require("recorder").displaySlots },
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
					-- custom_fname,
					file_status = true,
					newfile_status = true,
					symbols = {
						modified = "[+]", -- Text to show when the file is modified.
						readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
						unnamed = "[UNNAMED]", -- Text to show for unnamed buffers.
						newfile = "[New]",
					},
					fmt = trunc(90, 30, 50),
				},
				{
					diagnostics_message,
					-- colors = {
					-- 	error = "#BF616A",
					-- 	warn = "#EBCB8B",
					-- 	info = "#A3BE8C",
					-- 	hint = "#88C0D0",
					-- },
				},
			},
			lualine_x = {
				mixed_indent,
				trailing_whitespace,
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
			lualine_y = { "filetype" },
			lualine_z = {
				"searchcount",
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
				},
			},
			lualine_y = {
				{ "filetype", icon_only = true },
				{ "filename", fmt = trunc(90, 30, 50) },
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
				{ "filename", fmt = trunc(90, 30, 50) },
			},
			lualine_z = {},
		},
		tabline = {},
		extensions = {
			-- "aerial",
			"toggleterm",
			"neo-tree",
			"quickfix",
		},
	})
end

return M
