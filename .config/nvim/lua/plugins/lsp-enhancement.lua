local lightbulb = {
	"kosayoda/nvim-lightbulb",
	event = { "LspAttach" },
	config = function()
		require("nvim-lightbulb").setup({
			-- LSP client names to ignore
			-- Example: {"sumneko_lua", "null-ls"}
			ignore = {},
			sign = {
				enabled = true,
				-- Priority of the gutter sign
				priority = 10,
			},
			float = {
				enabled = false,
				-- Text to show in the popup float
				text = "💡",
				-- Available keys for window options:
				-- - height     of floating window
				-- - width      of floating window
				-- - wrap_at    character to wrap at for computing height
				-- - max_width  maximal width of floating window
				-- - max_height maximal height of floating window
				-- - pad_left   number of columns to pad contents at left
				-- - pad_right  number of columns to pad contents at right
				-- - pad_top    number of lines to pad contents at top
				-- - pad_bottom number of lines to pad contents at bottom
				-- - offset_x   x-axis offset of the floating window
				-- - offset_y   y-axis offset of the floating window
				-- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
				-- - winblend   transparency of the window (0-100)
				win_opts = {
					border = "none",
					winblend = 100,
				},
			},
			virtual_text = {
				enabled = false,
				-- Text to show at virtual text
				text = "💡",
				-- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
				hl_mode = "combine",
			},
			status_text = {
				enabled = false,
				-- Text to provide when code actions are available
				text = "💡 ",
				-- Text to provide when no actions are available
				text_unavailable = "",
			},
			autocmd = {
				enabled = true,
				-- see :help autocmd-pattern
				pattern = { "*" },
				-- see :help autocmd-events
				events = { "CursorHold", "CursorHoldI" },
				-- events = { "WinEnter", "CursorMoved", "CursorMovedI" },
			},
		})

		-- vim.fn.sign_define("LightBulbSign", { text = "💡", texthl = "", linehl = "", numhl = "" })
		-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		-- 	callback = function()
		-- 		require("nvim-lightbulb").update_lightbulb()
		-- 	end,
		-- })
	end,
}

local actionHint = {
	"roobert/statusline-action-hints.nvim",
	enabled = false,
	config = function()
		require("statusline-action-hints").setup({
			definition_identifier = "gd",
			template = "%s ref:%s",
		})
	end,
}

local inc_rename = {
	"smjonas/inc-rename.nvim",
	enabled = true,
	-- keys = {
	-- 	{
	-- 		"<leader>rn",
	-- 		function()
	-- 			return ":IncRename " .. vim.fn.expand("<cword>")
	-- 		end,
	-- 		expr = true,
	-- 	},
	-- },
	config = function()
		require("inc_rename").setup()
	end,
}

local neo_dim = {
	"zbirenbaum/neodim",
	event = { "LspAttach" },
	enabled = true,
	config = function()
		local c = require("nord.colors").palette
		require("neodim").setup({
			alpha = 0.5,
			blend_color = c.polar_night.origin,
			update_in_insert = {
				enable = true,
				delay = 100,
			},
			hide = {
				virtual_text = false,
				signs = false,
				underline = false,
			},
		})
	end,
}

local trouble = {
	"folke/trouble.nvim",
	cmd = {
		"TroubleToggle",
		"Trouble",
		"TroubleRefresh",
		"TroubleClose",
	},
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ "<F5>", "<cmd>TroubleClose<cr>", noremap = true },
		{ "<F6>", "<cmd>Trouble workspace_diagnostics<cr>", noremap = true },
		{ "<leader>xx", "<cmd>TroubleToggle<cr>", noremap = true },
		{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", noremap = true },
		{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", noremap = true },
		{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>", noremap = true },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", noremap = true },
		{ "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", noremap = true },
	},
	config = function()
		require("trouble").setup({
			position = "bottom", -- position of the list can be: bottom, top, left, right
			height = 10, -- height of the trouble list when position is top or bottom
			width = 50, -- width of the list when position is left or right
			icons = true, -- use devicons for filenames
			mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
			fold_open = "", -- icon used for open folds
			fold_closed = "", -- icon used for closed folds
			group = true, -- group results by file
			padding = true, -- add an extra new line on top of the list
			action_keys = { -- key mappings for actions in the trouble list
				-- map to {} to remove a mapping, for example:
				-- close = {},
				close = "q", -- close the list
				cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
				refresh = "r", -- manually refresh
				jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
				open_split = { "<c-x>" }, -- open buffer in new split
				open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
				open_tab = { "<c-t>" }, -- open buffer in new tab
				jump_close = { "o" }, -- jump to the diagnostic and close the list
				toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
				toggle_preview = "P", -- toggle auto_preview
				hover = "gh", -- opens a small popup with the full multiline message
				preview = "p", -- preview the diagnostic location
				close_folds = { "zM", "zm" }, -- close all folds
				open_folds = { "zR", "zr" }, -- open all folds
				toggle_fold = { "zA", "za" }, -- toggle fold of current file
				previous = "k", -- preview item
				next = "j", -- next item
			},
			indent_lines = true, -- add an indent guide below the fold icons
			auto_open = false, -- automatically open the list when you have diagnostics
			auto_close = false, -- automatically close the list when you have no diagnostics
			auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
			auto_fold = false, -- automatically fold a file trouble list at creation
			auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
			signs = {
				-- icons / text used for a diagnostic
				error = " ",
				warning = " ",
				hint = " ",
				information = " ",
				other = " ",
			},
			use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
		})
	end,
}

local lsp_lens = {
	"VidocqH/lsp-lens.nvim",
	event = { "LspAttach" },
	config = function()
		require("lsp-lens").setup({
			enable = true,
			include_declaration = false, -- Reference include declaration
			sections = { -- Enable / Disable specific request
				definition = false,
				references = true,
				implementation = true,
			},
			ignore_filetype = {},
		})
	end,
}

local pretty_hover = {
	"Fildo7525/pretty_hover",
	config = function()
		require("pretty_hover").setup({
			line = {
				"@brief",
			},
			word = {
				"@param",
				"@tparam",
				"@see",
			},
			header = {
				"@class",
			},
			stylers = {
				line = "**",
				word = "`",
				header = "###",
			},
			border = "rounded",
		})
	end,
}

return {
	lightbulb,
	inc_rename,
	neo_dim,
	trouble,
	-- lsp_lens,
	pretty_hover,
}
