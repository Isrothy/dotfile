local lightbulb = {
	"kosayoda/nvim-lightbulb",
	event = { "LspAttach" },
	opts = {
		-- Priority of the lightbulb for all handlers except float.
		priority = 10,

		-- Whether or not to hide the lightbulb when the buffer is not focused.
		-- Only works if configured during NvimLightbulb.setup
		hide_in_unfocused_buffer = true,

		-- Whether or not to link the highlight groups automatically.
		-- Default highlight group links:
		--   LightBulbSign -> DiagnosticSignInfo
		--   LightBulbFloatWin -> DiagnosticFloatingInfo
		--   LightBulbVirtualText -> DiagnosticVirtualTextInfo
		--   LightBulbNumber -> DiagnosticSignInfo
		--   LightBulbLine -> CursorLine
		-- Only works if configured during NvimLightbulb.setup
		link_highlights = true,

		-- Perform full validation of configuration.
		-- Available options: "auto", "always", "never"
		--   "auto" only performs full validation in NvimLightbulb.setup.
		--   "always" performs full validation in NvimLightbulb.update_lightbulb as well.
		--   "never" disables config validation.
		validate_config = "auto",

		-- Code action kinds to observe.
		-- To match all code actions, set to `nil`.
		-- Otherwise, set to a table of kinds.
		-- Example: { "quickfix", "refactor.rewrite" }
		-- See: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#codeActionKind
		action_kinds = nil,

		-- Configuration for various handlers:
		-- 1. Sign column.
		sign = {
			enabled = true,
			-- Text to show in the sign column.
			-- Must be between 1-2 characters.
			text = "💡",
			-- Highlight group to highlight the sign column text.
			hl = "LightBulbSign",
		},

		-- 2. Virtual text.
		virtual_text = {
			enabled = false,
			-- Text to show in the virt_text.
			text = "💡",
			-- Position of virtual text given to |nvim_buf_set_extmark|.
			-- Can be a number representing a fixed column (see `virt_text_pos`).
			-- Can be a string representing a position (see `virt_text_win_col`).
			pos = "eol",
			-- Highlight group to highlight the virtual text.
			hl = "LightBulbVirtualText",
			-- How to combine other highlights with text highlight.
			-- See `hl_mode` of |nvim_buf_set_extmark|.
			hl_mode = "combine",
		},

		-- 3. Floating window.
		float = {
			enabled = false,
			-- Text to show in the floating window.
			text = "💡",
			-- Highlight group to highlight the floating window.
			hl = "LightBulbFloatWin",
			-- Window options.
			-- See |vim.lsp.util.open_floating_preview| and |nvim_open_win|.
			-- Note that some options may be overridden by |open_floating_preview|.
			win_opts = {
				focusable = false,
			},
		},

		-- 4. Status text.
		-- When enabled, will allow using |NvimLightbulb.get_status_text|
		-- to retrieve the configured text.
		status_text = {
			enabled = false,
			-- Text to set if a lightbulb is available.
			text = "💡",
			-- Text to set if a lightbulb is unavailable.
			text_unavailable = "",
		},

		-- 5. Number column.
		number = {
			enabled = false,
			-- Highlight group to highlight the number column if there is a lightbulb.
			hl = "LightBulbNumber",
		},

		-- 6. Content line.
		line = {
			enabled = false,
			-- Highlight group to highlight the line if there is a lightbulb.
			hl = "LightBulbLine",
		},

		-- Autocmd configuration.
		-- If enabled, automatically defines an autocmd to show the lightbulb.
		-- If disabled, you will have to manually call |NvimLightbulb.update_lightbulb|.
		-- Only works if configured during NvimLightbulb.setup
		autocmd = {
			-- Whether or not to enable autocmd creation.
			enabled = true,
			-- See |updatetime|.
			-- Set to a negative value to avoid setting the updatetime.
			updatetime = 200,
			-- See |nvim_create_autocmd|.
			events = { "CursorHold", "CursorHoldI" },
			-- See |nvim_create_autocmd| and |autocmd-pattern|.
			pattern = { "*" },
		},

		-- Scenarios to not show a lightbulb.
		ignore = {
			-- LSP client names to ignore.
			-- Example: {"null-ls", "lua_ls"}
			clients = {},
			-- Filetypes to ignore.
			-- Example: {"neo-tree", "lua"}
			ft = {},
			-- Ignore code actions without a `kind` like refactor.rewrite, quickfix.
			actions_without_kind = false,
		},
	},
}

local inc_rename = {
	"smjonas/inc-rename.nvim",
	enabled = true,
	event = { "LspAttach" },
	opts = {},
}

local neo_dim = {
	"zbirenbaum/neodim",
	event = { "LspAttach" },
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

local illuminate = {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		delay = 200,
		large_file_cutoff = 2000,
		large_file_overrides = {
			providers = {
				"lsp",
				-- "treesitter",
				-- "regex",
			},
		},
	},
	config = function(_, opts)
		require("illuminate").configure(opts)

		local function map(key, dir, buffer)
			vim.keymap.set("n", key, function()
				require("illuminate")["goto_" .. dir .. "_reference"](false)
			end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
		end

		map("]]", "next")
		map("[[", "prev")

		-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				local buffer = vim.api.nvim_get_current_buf()
				map("]]", "next", buffer)
				map("[[", "prev", buffer)
			end,
		})
	end,
	keys = {
		{ "]]", desc = "Next Reference" },
		{ "[[", desc = "Prev Reference" },
	},
}

local trouble = {
	"folke/trouble.nvim",
	enabled = true,
	cmd = {
		"TroubleToggle",
		"Trouble",
		"TroubleRefresh",
		"TroubleClose",
	},
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		-- { "<F5>", "<cmd>TroubleClose<cr>", noremap = true },
		-- { "<F6>", "<cmd>Trouble workspace_diagnostics<cr>", noremap = true },
		{ "<leader>xx", "<cmd>TroubleToggle<cr>", noremap = true },
		{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", noremap = true },
		{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", noremap = true },
		{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>", noremap = true },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", noremap = true },
		{ "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", noremap = true },
	},
	opts = {
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
	},
}

local lsp_lens = {
	"VidocqH/lsp-lens.nvim",
	event = { "LspAttach" },
	enabled = true,
	opts = {
		enable = true,
		include_declaration = false, -- Reference include declaration
		sections = { -- Enable / Disable specific request
			definition = false,
			references = true,
			implementation = true,
		},
		ignore_filetype = {},
	},
}

return {
	lightbulb,
	inc_rename,
	neo_dim,
	illuminate,
	trouble,
	lsp_lens,
}
