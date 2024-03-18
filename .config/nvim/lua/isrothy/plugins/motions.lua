return {
	{
		"folke/flash.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
		},
		opts = {
			modes = {
				search = {
					enabled = false,
				},
			},
		},
	},
	{
		"Aasim-A/scrollEOF.nvim",
		event = { "BufReadPre", "BufNewFile" },
		enabled = true,
		opts = { -- The pattern used for the internal autocmd to determine
			-- where to run scrollEOF. See https://neovim.io/doc/user/autocmd.html#autocmd-pattern
			pattern = "*",
			-- Whether or not scrollEOF should be enabled in insert mode
			insert_mode = true,
			-- List of filetypes to disable scrollEOF for.
			disabled_filetypes = {
				"terminal",
			},
			-- List of modes to disable scrollEOF for. see https://neovim.io/doc/user/builtin.html#mode() for available modes.
			disabled_modes = {},
		},
	},
	{
		"karb94/neoscroll.nvim",
		keys = {
			"<C-u>",
			"<C-d>",
			"<C-b>",
			"<C-f>",
			"<C-y>",
			"<C-e>",
			"zt",
			"zz",
			"zb",
		},
		config = function()
			require("neoscroll").setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = "quadratic", -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
				performance_mode = false, -- Disable "Performance Mode" on all buffers.
			})
			local t = {}
			-- Syntax: t[keys] = {function, {function arguments}}
			t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "83" } }
			t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "83" } }
			t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "83" } }
			t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "83" } }
			t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
			t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
			t["zt"] = { "zt", { "250" } }
			t["zz"] = { "zz", { "250" } }
			t["zb"] = { "zb", { "250" } }

			require("neoscroll.config").set_mappings(t)
		end,
		enabled = false,
	},
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		enabled = false,
		opts = function()
			local animate = require("mini.animate")
			return {
				resize = {
					enable = false,
					timing = animate.gen_timing.quadratic({ duration = 64, unit = "total" }),
				},
				open = {
					enable = false,
					timing = animate.gen_timing.quadratic({ duration = 64, unit = "total" }),
				},
				close = {
					enable = false,
					timing = animate.gen_timing.quadratic({ duration = 64, unit = "total" }),
				},
				cursor = {
					enable = false,
				},
				scroll = {
					timing = animate.gen_timing.quadratic({ duration = 24, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({
						predicate = function(total_scroll)
							return total_scroll > 1
						end,
					}),
				},
			}
		end,
	},
}
