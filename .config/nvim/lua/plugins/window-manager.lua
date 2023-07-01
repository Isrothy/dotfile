local c = require("nord.colors").palette
return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		enabled = false,
		opts = {
			left = {
				{
					title = "Neo-Tree",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					pinned = true,
					size = { height = 0.5 },
					open = "Neotree",
				},
				{
					title = "Neo-Tree Buffers",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "buffers"
					end,
					pinned = true,
					-- open = "Neotree buffers",
					open = "Neotree position=right buffers",
				},
				{
					title = "Neo-Tree Git",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "git_status"
					end,
					pinned = true,
					open = "Neotree position=top git_status",
					-- open = "Neotree git_status",
				},
				"neo-tree",
			},
			bottom = {
				{
					ft = "toggleterm",
					size = { height = 0.32 },
					-- exclude floating windows
					filter = function(buf, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
				{
					ft = "noice",
					size = { height = 0.32 },
					filter = function(buf, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
				{
					ft = "Trouble",
					size = { height = 0.32 },
				},
				{
					ft = "qf",
					title = "QuickFix",
					size = { height = 0.32 },
				},
				{
					ft = "help",
					size = { height = 20 },
					-- don't open help files in edgy that we're editing
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
			},
			right = {
				{
					ft = "aerial",
				},
			},
			top = {},

			options = {
				left = { size = 30 },
				bottom = { size = 10 },
				right = { size = 30 },
				top = { size = 10 },
			},
			-- edgebar animations
			animate = {
				enabled = false,
				fps = 100, -- frames per second
				cps = 120, -- cells per second
				on_begin = function()
					vim.g.minianimate_disable = true
				end,
				on_end = function()
					vim.g.minianimate_disable = false
				end,
				-- Spinner for pinned views that are loading.
				-- if you have noice.nvim installed, you can use any spinner from it, like:
				-- spinner = require("noice.util.spinners").spinners.circleFull,
				spinner = {
					frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
					interval = 80,
				},
			},
			-- enable this to exit Neovim when only edgy windows are left
			exit_when_last = true,
			-- global window options for edgebar windows
			---@type vim.wo
			wo = {
				-- Setting to `true`, will add an edgy winbar.
				-- Setting to `false`, won't set any winbar.
				-- Setting to a string, will set the winbar to that string.
				winbar = true,
				winfixwidth = true,
				winfixheight = false,
				winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
				spell = false,
				signcolumn = "no",
			},
			-- buffer-local keymaps to be added to edgebar buffers.
			-- Existing buffer-local keymaps will never be overridden.
			-- Set to false to disable a builtin.
			---@type table<string, fun(win:Edgy.Window)|false>
			keys = {
				-- close window
				["q"] = function(win)
					win:close()
				end,
				-- hide window
				["<c-q>"] = function(win)
					win:hide()
				end,
				-- close sidebar
				["Q"] = function(win)
					win.view.edgebar:close()
				end,
				-- next open window
				["]w"] = function(win)
					win:next({ visible = true, focus = true })
				end,
				-- previous open window
				["[w"] = function(win)
					win:prev({ visible = true, focus = true })
				end,
				-- next loaded window
				["]W"] = function(win)
					win:next({ pinned = false, focus = true })
				end,
				-- prev loaded window
				["[W"] = function(win)
					win:prev({ pinned = false, focus = true })
				end,
				["<c-.>"] = function(win)
					win:resize("width", 1)
				end,
				-- decrease width
				["<c-,>"] = function(win)
					win:resize("width", -1)
				end,
				-- increase height
				["<c-="] = function(win)
					win:resize("height", 1)
				end,
				-- decrease height
				["<c->"] = function(win)
					win:resize("height", -1)
				end,
				-- reset all custom sizing
				["<c-w>="] = function(win)
					win.view.edgebar:equalize()
				end,
			},
			icons = {
				closed = " ",
				open = " ",
			},
			-- enable this on Neovim <= 0.10.0 to properly fold edgebar windows.
			-- Not needed on a nightly build >= June 5, 2023.
			fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
		},
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		enabled = true,
		keys = {
			{
				"<leader>wp",
				function()
					local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
					vim.api.nvim_set_current_win(picked_window_id)
				end,
				desc = "Pick a window",
				mode = "n",
			},
		},
		opts = {
			autoselect_one = true,
			include_current = false,
			-- hint = "floating-big-letter",
			filter_rules = {
				-- filter using buffer options
				bo = {
					-- if the file type is one of following, the window will be ignored
					filetype = {
						"neo-tree",
						"neo-tree-popup",
						"notify",
						"quickfix",
						"aerial",
						"edgy",
					},

					-- if the buffer type is one of following, the window will be ignored
					buftype = {
						"terminal",
						"aerial",
					},
				},
			},
			other_win_hl_color = c.frost.ice,

			picker_config = {
				statusline_winbar_picker = {
					-- You can change the display string in status bar.
					-- It supports '%' printf style. Such as `return char .. ': %f'` to display
					-- buffer file path. See :h 'stl' for details.
					selection_display = function(char, windowid)
						return "%=" .. char .. "%="
					end,

					-- whether you want to use winbar instead of the statusline
					-- "always" means to always use winbar,
					-- "never" means to never use winbar
					-- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
					use_winbar = "never", -- "always" | "never" | "smart"
				},

				floating_big_letter = {
					-- window picker plugin provides bunch of big letter fonts
					-- fonts will be lazy loaded as they are being requested
					-- additionally, user can pass in a table of fonts in to font
					-- property to use instead

					font = "ansi-shadow", -- ansi-shadow |
				},
			},
			show_prompt = false,
		},
	},
	{
		"mrjones2014/smart-splits.nvim",
		enabled = true,
		keys = {
			{
				"<C-h>",
				"<cmd>lua require('smart-splits').move_cursor_left()<cr>",
				mode = { "n" },
				desc = "Move cursor left",
			},
			{
				"<C-j>",
				"<cmd>lua require('smart-splits').move_cursor_down()<cr>",
				mode = { "n" },
				desc = "Move cursor down",
			},
			{
				"<C-k>",
				"<cmd>lua require('smart-splits').move_cursor_up()<cr>",
				mode = { "n" },
				desc = "Move cursor up",
			},
			{
				"<C-l>",
				"<cmd>lua require('smart-splits').move_cursor_right()<cr>",
				mode = { "n" },
				desc = "Move cursor right",
			},

			{ "<leader>bh", "<cmd> lua require('smart-splits').swap_buf_left() <cr>", desc = "Swap buffers left" },
			{ "<leader>bj", "<cmd> lua require('smart-splits').swap_buf_down() <cr>", desc = "Swap buffers down" },
			{ "<leader>bk", "<cmd> lua require('smart-splits').swap_buf_up() <cr>", desc = "Swap buffers up" },
			{ "<leader>bl", "<cmd> lua require('smart-splits').swap_buf_right() <cr>", desc = "Swap buffers right" },

			{ "<M-h>", "<cmd>lua require('smart-splits').resize_left()<cr>", desc = "Resize left" },
			{ "<M-j>", "<cmd>lua require('smart-splits').resize_down()<cr>", desc = "Resize down" },
			{ "<M-k>", "<cmd>lua require('smart-splits').resize_up()<cr>", desc = "Resize up" },
			{ "<M-l>", "<cmd>lua require('smart-splits').resize_right()<cr>", desc = "Resize right" },
		},
		opts = {
			-- Ignored filetypes (only while resizing)
			ignored_filetypes = {
				"nofile",
				"quickfix",
				"prompt",
			},
			-- Ignored buffer types (only while resizing)
			ignored_buftypes = { "NvimTree" },
			-- the default number of lines/columns to resize by at a time
			default_amount = 1,

			-- Desired behavior when your cursor is at an edge and you
			-- are moving towards that same edge:
			-- 'wrap' => Wrap to opposite side
			-- 'split' => Create a new split in the desired direction
			-- 'stop' => Do nothing
			-- NOTE: `at_edge = 'wrap'` is not supported on Kitty terminal
			-- multiplexer, as there is no way to determine layout via the CLI
			at_edge = "stop",

			-- when moving cursor between splits left or right,
			-- place the cursor on the same row of the *screen*
			-- regardless of line numbers. False by default.
			-- Can be overridden via function parameter, see Usage.
			move_cursor_same_row = false,
			-- whether the cursor should follow the buffer when swapping
			-- buffers by default; it can also be controlled by passing
			-- `{ move_cursor = true }` or `{ move_cursor = false }`
			-- when calling the Lua function.
			cursor_follows_swapped_bufs = false,
			-- resize mode options
			resize_mode = {
				-- key to exit persistent resize mode
				quit_key = "<ESC>",
				-- keys to use for moving in resize mode
				-- in order of left, down, up' right
				resize_keys = { "h", "j", "k", "l" },
				-- set to true to silence the notifications
				-- when entering/exiting persistent resize mode
				silent = false,
				-- must be functions, they will be executed when
				-- entering or exiting the resize mode
				hooks = {
					on_enter = nil,
					on_leave = nil,
				},
			},
			-- ignore these autocmd events (via :h eventignore) while processing
			-- smart-splits.nvim computations, which involve visiting different
			-- buffers and windows. These events will be ignored during processing,
			-- and un-ignored on completed. This only applies to resize events,
			-- not cursor movement events.
			ignored_events = {
				"BufEnter",
				"WinEnter",
			},
			-- enable or disable a multiplexer integration
			-- set to false to disable, otherwise
			-- it will default to tmux if $TMUX is set,
			-- then wezterm if $WEZTERM_PANE is set,
			-- then kitty if $KITTY_LISTEN_ON is set,
			-- otherwise false
			multiplexer_integration = nil,
			-- disable multiplexer navigation if current multiplexer pane is zoomed
			-- this functionality is only supported on tmux and Wezterm due to kitty
			-- not having a way to check if a pane is zoomed
			disable_multiplexer_nav_when_zoomed = true,
		},
	},
	{
		"kwkarlwang/bufresize.nvim",
		event = { "WinResized", "VimResized" },
		enabled = true,
		opts = {
			resize = {
				keys = {},
				trigger_events = { "VimResized", "WinResized" },
				increment = false,
			},
		},
	},
}
