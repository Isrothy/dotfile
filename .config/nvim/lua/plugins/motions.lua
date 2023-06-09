return {
	{
		"ggandor/leap.nvim",
		keys = { "gl", "gL" },
		-- lazy = false,
		opts = {
			max_phase_one_targets = nil,
			highlight_unlabeled_phase_one_targets = false,
			max_highlighted_traversal_targets = 10,
			case_sensitive = true,
			equivalence_classes = { " \t\r\n" },
			substitute_chars = {},
			safe_labels = { "s", "d", "f", "g", "h", "l", "n", "u", "t" },
			labels = { "s", "d", "f", "g", "h", "n", "j", "k" },
			special_keys = {
				repeat_search = "<enter>",
				next_phase_one_target = "<enter>",
				next_target = { "<enter>", ";" },
				prev_target = { "<tab>", "," },
				next_group = "<space>",
				prev_group = "<tab>",
				multi_accept = "<enter>",
				multi_revert = "<backspace>",
			},
		},
		config = function(_, opts)
			require("leap").setup(opts)
			for _, _4_ in ipairs({
				{ { "n", "x", "o" }, "gl", "<Plug>(leap-forward)" },
				{ { "n", "x", "o" }, "gL", "<Plug>(leap-backward)" },
				-- { "o", "<F8>", "<Plug>(leap-forward-x)" },
				-- { "o", "<F7>", "<Plug>(leap-backward-x)" },
				-- { { "n", "x", "o" }, "<F9>", "<Plug>(leap-cross-window)" },
			}) do
				local _each_5_ = _4_
				local mode = _each_5_[1]
				local lhs = _each_5_[2]
				local rhs = _each_5_[3]
				vim.keymap.set(mode, lhs, rhs, { silent = true })
			end
		end,
	},
	{
		"ggandor/flit.nvim",
		keys = { "f", "F", "t", "T" },
		enabled = false,
		opts = {
			keys = { f = "f", F = "F", t = "t", T = "T" },
			-- A string like "nv", "nvo", "o", etc.
			labeled_modes = "v",
			multiline = false,
			-- Like `leap`s similar argument (call-specific overrides).
			-- E.g.: opts = { equivalence_classes = {} }
			opts = {},
		},
	},
	{
		"nacro90/numb.nvim",
		event = "CmdlineEnter",
		enabled = false,
		opts = {
			show_numbers = true, -- Enable 'number' for the window while peeking
			show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			hide_relativenumbers = false, -- Enable turning off 'relativenumber' for the window while peeking
			number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
			centered_peeking = true, -- Peeked line will be centered relative to window
		},
	},
	{
		"jinh0/eyeliner.nvim",
		keys = { { "f" }, { "F" } },
		opts = {
			highlight_on_key = true, -- show highlights only after keypress
			dim = true, -- dim all other characters if set to true (recommended!)
		},
	},
	{
		"Aasim-A/scrollEOF.nvim",
		event = { "CursorMoved", "CursorMovedI" },
		enabled = false,
		opts = {
			-- The pattern used for the internal autocmd to determine
			-- where to run scrollEOF. See https://neovim.io/doc/user/autocmd.html#autocmd-pattern
			pattern = "*",
			-- Whether or not scrollEOF should be enabled in insert mode
			insert_mode = true,

			disabled_filetypes = {
				"quickfix",
				"nofile",
				"help",
				"terminal",
				"toggleterm",
				"",
			},
		},
	},
}
