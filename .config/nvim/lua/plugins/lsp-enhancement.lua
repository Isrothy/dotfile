local lightbulb = {
	"kosayoda/nvim-lightbulb",
	event = { "LspAttach" },
	opts = {
		sign = {
			enabled = true,
			-- Text to show in the sign column.
			-- Must be between 1-2 characters.
			text = "💡",
			-- Highlight group to highlight the sign column text.
			hl = "LightBulbSign",
		},
		-- 6. Content line.
		line = {
			enabled = true,
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

local inlay_hint = {
	"lvimuser/lsp-inlayhints.nvim",
	event = { "LspAttach" },
	branch = "anticonceal",
	enabled = true,
	opts = {
		enabled_at_startup = true,
		debug_mode = false,
	},
	init = function()
		vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
		vim.api.nvim_create_autocmd("LspAttach", {
			group = "LspAttach_inlayhints",
			callback = function(args)
				if not (args.data and args.data.client_id) then
					return
				end
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				require("lsp-inlayhints").on_attach(client, bufnr)
			end,
		})
	end,
}

local pretty_hover = {
	"Fildo7525/pretty_hover",
	enabled = false,
	otps = {
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
	},
}

return {
	lightbulb,
	inc_rename,
	neo_dim,
	illuminate,
	trouble,
	lsp_lens,
	inlay_hint,
	pretty_hover,
}
