return {
	{
		"folke/flash.nvim",
		event = {"BufReadPre", "BufNewFile"},
		keys = {
			{
				"gj",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"gt",
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
			{
				"R",
				mode = { "n", "o", "x" },
				function()
					-- show labeled treesitter nodes around the search matches
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
		},
		opts = {
			labels = "asdfghjklqwertyuiopzxcvbnm",
			search = {
				-- search/jump in all windows
				multi_window = true,
				-- search direction
				forward = true,
				-- when `false`, find only matches in the given direction
				wrap = true,
				---@type Flash.Pattern.Mode
				-- Each mode will take ignorecase and smartcase into account.
				-- * exact: exact match
				-- * search: regular search
				-- * fuzzy: fuzzy search
				-- * fun(str): custom function that returns a pattern
				--   For example, to only match at the beginning of a word:
				--   mode = function(str)
				--     return "\\<" .. str
				--   end,
				mode = "search",
				-- behave like `incsearch`
				incremental = false,
				-- Excluded filetypes and custom window filters
				---@type (string|fun(win:window))[]
				exclude = {
					"notify",
					"noice",
					"cmp_menu",
					function(win)
						-- exclude non-focusable windows
						return not vim.api.nvim_win_get_config(win).focusable
					end,
				},
				-- Optional trigger character that needs to be typed before
				-- a jump label can be used. It's NOT recommended to set this,
				-- unless you know what you're doing
				trigger = "",
				-- max pattern length. If the pattern length is equal to this
				-- labels will no longer be skipped. When it exceeds this length
				-- it will either end in a jump or terminate the search
				max_length = nil, ---@type number?
			},
			jump = {
				-- save location in the jumplist
				jumplist = true,
				-- jump position
				pos = "start", ---@type "start" | "end" | "range"
				-- add pattern to search history
				history = false,
				-- add pattern to search register
				register = false,
				-- clear highlight after jump
				nohlsearch = false,
				-- automatically jump when there is only one match
				autojump = false,
				-- You can force inclusive/exclusive jumps by setting the
				-- `inclusive` option. By default it will be automatically
				-- set based on the mode.
				inclusive = nil, ---@type boolean?
			},
			label = {
				-- add a label for the first match in the current window.
				-- you can always jump to the first match with `<CR>`
				current = true,
				-- show the label after the match
				after = true, ---@type boolean|number[]
				-- show the label before the match
				before = false, ---@type boolean|number[]
				-- position of the label extmark
				style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
				-- flash tries to re-use labels that were already assigned to a position,
				-- when typing more characters. By default only lower-case labels are re-used.
				reuse = "lowercase", ---@type "lowercase" | "all"
			},
			highlight = {
				-- show a backdrop with hl FlashBackdrop
				backdrop = true,
				-- Highlight the search matches
				matches = true,
				-- extmark priority
				priority = 5000,
				groups = {
					match = "FlashMatch",
					current = "FlashCurrent",
					backdrop = "FlashBackdrop",
					label = "FlashLabel",
				},
			},
			-- action to perform when picking a label.
			-- defaults to the jumping logic depending on the mode.
			---@type fun(match:Flash.Match, state:Flash.State)|nil
			action = nil,
			-- initial pattern to use when opening flash
			pattern = "",
			-- You can override the default options for a specific mode.
			-- Use it with `require("flash").jump({mode = "forward"})`
			---@type table<string, Flash.Config>
			modes = {
				-- options used when flash is activated through
				-- a regular search with `/` or `?`
				search = {
					enabled = true, -- enable flash for search
					highlight = { backdrop = false },
					jump = { history = true, register = true, nohlsearch = true },
					search = {
						-- `forward` will be automatically set to the search direction
						-- `mode` is always set to `search`
						-- `incremental` is set to `true` when `incsearch` is enabled
					},
				},
				-- options used when flash is activated through
				-- `f`, `F`, `t`, `T`, `;` and `,` motions
				char = {
					enabled = true,
					-- by default all keymaps are enabled, but you can disable some of them,
					-- by removing them from the list.
					keys = { "f", "F", "t", "T", ";", "," },
					search = { wrap = false },
					highlight = { backdrop = true },
					jump = { register = false },
				},
				-- options used for treesitter selections
				-- `require("flash").treesitter()`
				treesitter = {
					labels = "abcdefghijklmnopqrstuvwxyz",
					jump = { pos = "range" },
					highlight = {
						label = { before = true, after = true, style = "inline" },
						backdrop = false,
						matches = false,
					},
				},
				-- options used for remote flash
				remote = {},
			},
		},
	},
	{
		"ggandor/leap.nvim",
		keys = { "gl", "gL" },
		lazy = false,
		enabled = false,
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
		enabled = false,
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
