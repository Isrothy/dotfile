local lightbulb = {
	"kosayoda/nvim-lightbulb",
	enabled = true,
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
	enabled = true,
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
	enabled = true,
	event = { "LspAttach" },
	opts = { cmd_name = "IncRename" },
}

local illuminate = {
	"RRethy/vim-illuminate",
	enabled = true,
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
			"TelescopePrompt",
			"aerial",
			"dirbuf",
			"dirvish",
			"fugitive",
			"neo-tree",
			"text",
			"toggleterm",
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

return {
	lightbulb,
	actions_preview,
	illuminate,
	inc_rename,
	trouble,
}
