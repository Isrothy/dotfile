---@module 'neominimap.config.meta'
return {
	{
		dir = "~/neominimap.nvim",
		-- "Isrothy/neominimap.nvim",
		lazy = false,
		enabled = true,
		keys = {
			{ "<leader>nt", "<cmd>Neominimap toggle<cr>", desc = "Toggle minimap" },
			{ "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable minimap" },
			{ "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable minimap" },
			{ "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
			{ "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
			{ "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Focus on minimap" },
			{ "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
			{ "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
			{ "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
			{ "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },
			{ "<leader>nwt", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
			{ "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
			{ "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
			{ "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
			{ "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },
		},
		init = function()
			vim.opt.wrap = false
			vim.opt.sidescrolloff = 36
			---@type Neominimap.UserConfig
			vim.g.neominimap = {
				auto_enable = true,
				log_level = vim.log.levels.OFF,
				exclude_filetypes = {
					"qf",
					"neo-tree",
					"help",
				},
				buf_filter = function(bufnr)
					local line_cnt = vim.api.nvim_buf_line_count(bufnr)
					return line_cnt < 4096 and not vim.b[bufnr].large_buf
				end,
				minimap_width = 23,
				x_multiplier = 4,
				sync_cursor = true,
				diagnostic = {
					enabled = true,
					severity = vim.diagnostic.severity.HINT,
					mode = "line",
				},
				git = {
					enabled = true,
				},
				treesitter = {
					enabled = true,
				},
				z_index = 1,
				-- window_border = "single",
				window_border = { "" },

				winopt = {
					signcolumn = "yes:1",
				},
			}
		end,
	},
	{
		"echasnovski/mini.map",
		version = "*",
		lazy = false,
		enabled = false,
		-- No need to copy this inside `setup()`. Will be used automatically.
		config = function()
			require("mini.map").setup({
				-- Highlight integrations (none by default)
				integrations = nil,

				-- Symbols used to display data
				symbols = {
					-- Encode symbols. See `:h MiniMap.config` for specification and
					-- `:h MiniMap.gen_encode_symbols` for pre-built ones.
					-- Default: solid blocks with 3x2 resolution.
					encode = nil,

					-- Scrollbar parts for view and line. Use empty string to disable any.
					scroll_line = "█",
					scroll_view = "┃",
				},

				-- Window options
				window = {
					-- Whether window is focusable in normal way (with `wincmd` or mouse)
					focusable = false,
					-- Side to stick ('left' or 'right')
					side = "right",
					-- Whether to show count of multiple integration highlights
					show_integration_count = true,
					-- Total width
					width = 10,
					-- Z-index
					zindex = 10,
				},
			})
		end,
	},
	{
		"gorbit99/codewindow.nvim",
		-- dir = "~/codewindow.nvim",
		lazy = false,
		enabled = false,
		init = function()
			vim.opt.sidescrolloff = 36
			vim.g.codewindow = {
				auto_enable = true,
				exclude_filetypes = {
					"qf",
					"help",
				},
				minimap_width = 20,
				use_lsp = true,
				use_treesitter = true,
				use_git = true,
				width_multiplier = 4,
				z_index = 1,
				show_cursor = true,
				screen_bounds = "background",
				window_border = "none",
				-- window_border = { "", "", "", "", "", "", "", "" },
				relative = "win",
				events = {
					"LspAttach",
					"BufEnter",
					"BufNewFile",
					"BufRead",
					"TextChanged",
					"InsertLeave",
					"DiagnosticChanged",
					"FileWritePost",
				},
			}
		end,
		opts = {},
	},
}
