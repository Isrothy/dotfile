return {
	{
		"ggandor/leap.nvim",
		keys = { "gl", "gL" },
		-- lazy = false,
		config = function()
			require("leap").setup({
				max_phase_one_targets = nil,
				highlight_unlabeled_phase_one_targets = false,
				max_highlighted_traversal_targets = 10,
				case_sensitive = true,
				equivalence_classes = { " \t\r\n" },
				substitute_chars = {},
				safe_labels = { "s", "f", "n", "u", "t" },
				labels = { "s", "f", "n", "j", "k" },
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
			})
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
		config = function()
			require("flit").setup({
				keys = { f = "f", F = "F", t = "t", T = "T" },
				-- A string like "nv", "nvo", "o", etc.
				labeled_modes = "v",
				multiline = false,
				-- Like `leap`s similar argument (call-specific overrides).
				-- E.g.: opts = { equivalence_classes = {} }
				opts = {},
			})
		end,
	},
}
