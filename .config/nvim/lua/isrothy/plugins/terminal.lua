return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = { "<c-`>" },
		cmd = {
			"TermExec",
			"ToggleTerm",
			"ToggleTermToggleAll",
			"ToggleTermSendCurrentLine",
			"ToggleTermSendVisualLines",
			"ToggleTermSendVisualSelection",
			"ToggleTermSetName",
		},
		init = function()
			vim.api.nvim_create_user_command("TermRun", function(opts)
				local cmd = table.concat(opts.fargs, " ")
				cmd = cmd:gsub([["]], [[\"]])
				require("toggleterm").exec(cmd)
			end, { nargs = "*", desc = "Alias for TermExec with dynamic command execution" })
		end,
		opts = {
			open_mapping = [[<c-`>]],
			hide_numbers = true,
			autochdir = true,
			insert_mappings = true,
			shade_terminals = false,
			close_on_exit = false,
			winbar = {
				enabled = true,
			},
		},
	},
	{
		"willothy/flatten.nvim",
		enabled = true,
		lazy = false,
		priority = 1001,
		opts = function()
			local saved_terminal

			return {
				window = {
					open = "alternate",
				},
				one_per = {
					kitty = true, -- Flatten all instance in the current Kitty session
					wezterm = false, -- Flatten all instance in the current Wezterm session
				},
				callbacks = {
					should_block = function(argv)
						return vim.tbl_contains(argv, "-b")
					end,
					pre_open = function()
						local term = require("toggleterm.terminal")
						local termid = term.get_focused_id()
						saved_terminal = term.get(termid)
					end,
					post_open = function(bufnr, winnr, ft, is_blocking)
						if is_blocking and saved_terminal then
							saved_terminal:close()
						else
							vim.api.nvim_set_current_win(winnr)
						end

						if ft == "gitcommit" or ft == "gitrebase" then
							vim.api.nvim_create_autocmd("BufWritePost", {
								buffer = bufnr,
								once = true,
								callback = vim.schedule_wrap(function()
									vim.api.nvim_buf_delete(bufnr, {})
								end),
							})
						end
					end,
					block_end = function()
						vim.schedule(function()
							if saved_terminal then
								saved_terminal:open()
								saved_terminal = nil
							end
						end)
					end,
				},
			}
		end,
	},
	{
		"mikesmithgh/kitty-scrollback.nvim",
		lazy = true,
		cmd = {
			"KittyScrollbackGenerateKittens",
			"KittyScrollbackCheckHealth",
		},
		event = { "User KittyScrollbackLaunch" },
		-- version = '*', -- latest stable version, may have breaking changes if major version changed
		-- version = '^4.0.0', -- pin major version, include fixes and features that do not have breaking changes
		opts = {},
	},
}
