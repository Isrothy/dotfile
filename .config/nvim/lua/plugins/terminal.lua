return {
	{
		"akinsho/nvim-toggleterm.lua",
		keys = [[<c-`>]],
		cmd = {
			"TermExec",
			"TermSelect",
			"ToggleTerm",
			"ToggleTermSendCurrentLine",
			"ToggleTermSendVisualLines",
			"ToggleTermSendVisualSelection",
			"ToggleTermSetName",
			"ToggleTermToggleAll",
		},
		opts = {
			-- size can be a number or function which is passed the current terminal
			size = function(term)
				if term.direction == "horizontal" then
					-- return vim.api.nvim_win_get_height(0) * 0.4 * 2
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.32
				end
			end,
			open_mapping = [[<c-`>]],
			hide_numbers = true, -- hide the number column in toggleterm buffers
			shade_filetypes = {},
			shade_terminals = false,
			start_in_insert = false,
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
			persist_size = true,
			-- direction = "horizontal",
			close_on_exit = true, -- close the terminal window when the process exits
			shell = vim.o.shell, -- change the default shell
			-- This field is only relevant if direction is set to 'float'
			float_opts = {
				-- The border key is *almost* the same as 'nvim_open_win'
				-- see :h nvim_open_win for details on borders however
				-- the 'curved' border is a custom border type
				-- not natively supported but implemented in this plugin.
				border = "single",
				-- width = <value>,
				height = 20,
				winblend = 3,
			},
		},
	},
	{
		"boltlessengineer/bufterm.nvim",
		cmd = {
			"BufTermEnter",
			"BufTermNext",
			"BufTermPrev",
		},
		enabled = false,
		opts = {
			save_native_terms = true, -- integrate native terminals from `:terminal` command
			start_in_insert = true, -- start terminal in insert mode
			remember_mode = true, -- remember vi_mode of terminal buffer
			enable_ctrl_w = true, -- use <C-w> for window navigating in terminal mode (like vim8)
			terminal = { -- default terminal settings
				buflisted = false, -- whether to set 'buflisted' option
				fallback_on_exit = true, -- prevent auto-closing window on terminal exit
			},
		},
	},
	{
		"willothy/flatten.nvim",
		lazy = false,
		priority = 1001,
		opts = {
			window = {
				open = "tab",
			},
			callbacks = {
				pre_open = function()
					-- Close toggleterm when an external open request is received
					require("toggleterm").toggle(0)
				end,
				post_open = function(bufnr, winnr, ft, is_blocking)
					if is_blocking then
						-- Hide the terminal while it's blocking
						require("toggleterm").toggle(0)
					else
						-- If it's a normal file, just switch to its window
						vim.api.nvim_set_current_win(winnr)
					end

					-- If the file is a git commit, create one-shot autocmd to delete its buffer on write
					-- If you just want the toggleable terminal integration, ignore this bit
					if ft == "gitcommit" then
						vim.api.nvim_create_autocmd("BufWritePost", {
							buffer = bufnr,
							once = true,
							callback = function()
								-- This is a bit of a hack, but if you run bufdelete immediately
								-- the shell can occasionally freeze
								vim.defer_fn(function()
									vim.api.nvim_buf_delete(bufnr, {})
								end, 50)
							end,
						})
					end
				end,
				block_end = function()
					-- After blocking ends (for a git commit, etc), reopen the terminal
					require("toggleterm").toggle(0)
				end,
			},
		},
	},
	{
		"chomosuke/term-edit.nvim",
		ft = { "toggleterm", "BufTerm" },
		version = "1.*",
		otps = {
			prompt_end = "❯ ",
		},
	},
}
