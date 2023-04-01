return {
	{
		"roobert/search-replace.nvim",
		enabled = true,
		cmd = {
			"SearchReplaceSingleBufferOpen",
			"SearchReplaceMultiBufferOpen",

			"SearchReplaceSingleBufferCWord",
			"SearchReplaceSingleBufferCWORD",
			"SearchReplaceSingleBufferCExpr",
			"SearchReplaceSingleBufferCFile",

			"SearchReplaceMultiBufferCWord",
			"SearchReplaceMultiBufferCWORD",
			"SearchReplaceMultiBufferCExpr",
			"SearchReplaceMultiBufferCFile",

			"SearchReplaceSingleBufferSelections",
			"SearchReplaceMultiBufferSelections",

			"SearchReplaceSingleBufferWithinBlock",

			"SearchReplaceVisualSelection",
			"SearchReplaceVisualSelectionCWord",
			"SearchReplaceVisualSelectionCWORD",
			"SearchReplaceVisualSelectionCExpr",
			"SearchReplaceVisualSelectionCFile",
		},
		keys = {
			{ "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>" },
			{ "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>" },
			{ "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>" },
			{ "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>" },
			{ "<leader>rf", "<CMD>SearchReplaceSingleBufferFile<CR>" },

			{ "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>" },
			{ "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>" },
			{ "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>" },
			{ "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWORD<CR>" },
			{ "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>" },
			{ "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>" },

			{ "<C-r>", [[<CMD>SearchReplaceSingleBufferVisualSelection<CR>]], mode = "v" },
			{ "<C-b>", [[<CMD>SearchReplaceWithinVisualSelectionCWord<CR>]], mode = "v" },
		},
		config = function()
			require("search-replace").setup({
				default_replace_single_buffer_options = "gcI",
				default_replace_multi_buffer_options = "egcI",
			})
		end,
	},
	{
		"cshuaimin/ssr.nvim",
		enabled = false,
		keys = {
			{
				"<leader>sr",
				function()
					require("ssr").open()
				end,
				mode = { "x", "n" },
			},
		},
		config = function()
			require("ssr").setup({
				min_width = 50,
				min_height = 5,
				max_width = 120,
				max_height = 25,
				keymaps = {
					close = "q",
					next_match = "n",
					prev_match = "N",
					replace_confirm = "<cr>",
					replace_all = "<leader><cr>",
				},
			})
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		event = { "BufReadPre", "BufNewFile" },
		enabled = true,
		config = function()
			require("hlslens").setup({
				virt_priority = 1,
				-- build_position_cb = function(plist, _, _, _)
					-- require("scrollbar.handlers.search").handler.show(plist.start_pos)
				-- end,
			})
			-- vim.cmd([[
			-- 	augroup scrollbar_search_hide
			-- 		autocmd!
			-- 		autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
			-- 	augroup END
			-- ]])

			vim.api.nvim_set_keymap(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				{ noremap = true, silent = true }
			)
			vim.keymap.set("n", "*", [[*<cmd>lua require('hlslens').start()<cr>]], { noremap = true, silent = true })
			vim.keymap.set("n", "#", [[#<cmd>lua require('hlslens').start()<cr>]], { noremap = true, silent = true })
			vim.keymap.set("n", "g*", [[g*<cmd>lua require('hlslens').start()<cr>]], { noremap = true, silent = true })
			vim.keymap.set("n", "g#", [[g#<cmd>lua require('hlslens').start()<cr>]], { noremap = true, silent = true })

			-- require("scrollbar.handlers.search").setup({
			-- 	override_lens = function() end,
			-- })
		end,
	},
}
