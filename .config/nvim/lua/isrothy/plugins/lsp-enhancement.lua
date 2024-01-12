local lightbulb = {
	"kosayoda/nvim-lightbulb",
	event = { "LspAttach" },
	opts = {
		priority = 10,
		hide_in_unfocused_buffer = true,
		link_highlights = true,
		validate_config = "auto",
		action_kinds = nil,
		sign = {
			enabled = true,
			text = "💡",
			hl = "LightBulbSign",
		},
		virtual_text = { enabled = false },
		float = { enabled = false },
		status_text = { enabled = false },
		number = { enabled = false },
		line = { enabled = false },
		autocmd = {
			enabled = true,
			updatetime = 200,
			events = { "CursorHold", "CursorHoldI" },
			pattern = { "*" },
		},

		ignore = {
			clients = {},
			ft = {},
			actions_without_kind = false,
		},
	},
}

local actions_preview = {
	"aznhe21/actions-preview.nvim",
	opts = {
		diff = {
			ctxlen = 3,
		},
		backend = { "telescope", "nui" },
		telescope = {
			sorting_strategy = "ascending",
			layout_strategy = "vertical",
			layout_config = {
				width = 0.8,
				height = 0.9,
				prompt_position = "top",
				preview_cutoff = 20,
				preview_height = function(_, _, max_lines)
					return max_lines - 15
				end,
			},
		},
	},
}

local inc_rename = {
	"smjonas/inc-rename.nvim",
	event = { "LspAttach" },
	opts = { cmd_name = "IncRename" },
}

local neo_dim = {
	"zbirenbaum/neodim",
	branch = "v2",
	enabled = false,
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
		filetypes_denylist = {
			"dirbuf",
			"dirvish",
			"fugitive",
			"toggleterm",
			"neo-tree",
			"aerial",
		},
	},
	config = function(_, opts)
		require("illuminate").configure(opts)

		local function map(key, dir, buffer)
			vim.keymap.set("n", key, function()
				require("illuminate")["goto_" .. dir .. "_reference"](true)
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
		{ "<leader>xx", "<cmd>TroubleToggle<cr>", noremap = true, desc = "Trouble toggle" },
		{
			"<leader>xw",
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			noremap = true,
			desc = "Trouble workspace diagnostics",
		},
		{
			"<leader>xd",
			"<cmd>TroubleToggle document_diagnostics<cr>",
			noremap = true,
			desc = "Trouble document diagnostics",
		},
		{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>", noremap = true, desc = "Trouble loclist" },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", noremap = true, desc = "Trouble quickfix" },
		{ "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", noremap = true, desc = "Trouble lsp references" },
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
	enabled = false,
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
	actions_preview,
	inc_rename,
	neo_dim,
	illuminate,
	trouble,
	lsp_lens,
}
