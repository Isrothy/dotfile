return {
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
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
			hint = "statusline-winbar",
			filter_rules = {
				bo = {
					filetype = {
						"neo-tree",
						"neo-tree-popup",
						"notify",
						"quickfix",
						"aerial",
						"edgy",
					},
					buftype = {
						"terminal",
						"aerial",
					},
				},
			},
			picker_config = {
				statusline_winbar_picker = {
					selection_display = function(char, windowid)
						return "%=" .. char .. "%="
					end,
					use_winbar = "never", -- "always" | "never" | "smart"
				},
			},
			show_prompt = false,
		},
	},
	{
		"mrjones2014/smart-splits.nvim",
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

			{ "<leader>bh", "<cmd>lua require('smart-splits').swap_buf_left()<cr>", desc = "Swap buffers left" },
			{ "<leader>bj", "<cmd>lua require('smart-splits').swap_buf_down()<cr>", desc = "Swap buffers down" },
			{ "<leader>bk", "<cmd>lua require('smart-splits').swap_buf_up()<cr>", desc = "Swap buffers up" },
			{ "<leader>bl", "<cmd>lua require('smart-splits').swap_buf_right()<cr>", desc = "Swap buffers right" },

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
					-- on_leave = require("bufresize").register,
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
}
