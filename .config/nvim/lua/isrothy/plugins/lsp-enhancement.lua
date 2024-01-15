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
	enabled = true,
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
			"text",
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
		{ "]]", desc = "Next reference" },
		{ "[[", desc = "Prev reference" },
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
		fold_open = "",
		fold_closed = "",
		action_keys = {
			open_split = { "<c-s>" },
			open_vsplit = { "<c-v>" },
			open_tab = { "<c-t>" },
		},
		use_diagnostic_signs = true,
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
			definition = true,
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
