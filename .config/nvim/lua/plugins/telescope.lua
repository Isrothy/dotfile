local telescope = {
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	enabled = true,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-frecency.nvim", dependencies = { "kkharji/sqlite.lua" } },
		{ "jvgrootveld/telescope-zoxide" },
		{ "debugloop/telescope-undo.nvim" },
	},
}

telescope.keys = {
	{ "<leader><leader>a", "<cmd>Telescope autocommands<cr>" },
	{ "<leader><leader>b", "<cmd>Telescope buffers<cr>" },
	{ "<leader><leader>c", "<cmd>Telescope commands<cr>" },
	{ "<leader><leader>d", "<cmd>Telescope diagnostics<cr>" },

	{ "<leader><leader>f", "<cmd>Telescope find_files<cr>" },
	{ "<leader><leader>g", "<cmd>Telescope live_grep<cr>" },
	{ "<leader><leader>h", "<cmd>Telescope help_tags<cr>" },

	{ "<leader><leader>j", "<cmd>Telescope jumplist<cr>" },
	{ "<leader><leader>k", "<cmd>Telescope keymaps<cr>" },
	{ "<leader><leader>l", "<cmd>Telescope local_list<cr>" },
	{ "<leader><leader>m", "<cmd>Telescope marks<cr>" },
	{ "<leader><leader>n", "<cmd>Telescope noice<cr>" },
	{ "<leader><leader>o", "<cmd>Telescope frecency<cr>" },
	{ "<leader><leader>p", "<cmd>Telescope projects<cr>" },
	{ "<leader><leader>q", "<cmd>Telescope quickfix<cr>" },
	{ "<leader><leader>r", "<cmd>Telescope registers<cr>" },
	{ "<leader><leader>s", "<cmd>Telescope smart_open<cr>" },
	{ "<leader><leader>t", "<cmd>Telescope treesitter<cr>" },
	{ "<leader><leader>u", "<cmd>Telescope undo<cr>" },
	{ "<leader><leader>v", "<cmd>Telescope vim_options<cr>" },

	{ "<leader><leader>y", "<cmd>Telescope yank_history<cr>" },
	{ "<leader><leader>z", "<cmd>Telescope zoxide list<cr>" },
}

telescope.config = function()
	-- local command_center = require("command_center")
	local previewers = require("telescope.previewers")
	local Job = require("plenary.job")

	local new_maker = function(filepath, bufnr, opts)
		filepath = vim.fn.expand(filepath)
		Job:new({
			command = "file",
			args = { "--mime-type", "-b", filepath },
			on_exit = function(j)
				local mime_type = vim.split(j:result()[1], "/")[1]
				if mime_type == "text" then
					previewers.buffer_previewer_maker(filepath, bufnr, opts)
				else
					-- maybe we want to write something to the buffer here
					vim.schedule(function()
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
					end)
				end
			end,
		}):sync()
	end

	require("telescope").setup({
		pickers = {
			find_files = {
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			},
		},
		defaults = {
			buffer_previewer_maker = new_maker,
			dynamic_preview_title = true,
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim",
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
				-- require("telescope.themes").get_cursor({}),
			},
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
			aerial = {
				-- Display symbols as <root>.<parent>.<symbol>
				show_nesting = true,
			},
			undo = {
				use_delta = true,
				side_by_side = true,
				layout_strategy = "vertical",
				diff_context_lines = vim.o.scrolloff,
				layout_config = {
					-- preview_height = 0.8,
				},
				mappings = { -- this whole table is the default
					i = {
						-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
						-- you want to use the following actions. This means installing as a dependency of
						-- telescope in it's `requirements` and loading this extension from there instead of
						-- having the separate plugin definition as outlined above. See issue #6.
						["<cr>"] = require("telescope-undo.actions").yank_additions,
						["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
						["<C-cr>"] = require("telescope-undo.actions").restore,
					},
				},
			},
			zoxide = {
				prompt_title = "[ Walking on the shoulders of TJ ]",
				list_command = "zoxide query -ls",
				mappings = {
					default = {
						action = function(selection)
							vim.cmd("cd " .. selection.path)
						end,
						after_action = function(selection)
							print("Directory changed to " .. selection.path)
						end,
					},
				},
			},
			lazy = {
				-- Optional theme (the extension doesn't set a default theme)
				theme = "ivy",
				-- Whether or not to show the icon in the first column
				show_icon = true,
				-- Mappings for the actions
				mappings = {
					open_in_browser = "<C-o>",
					open_in_find_files = "<C-f>",
					open_in_live_grep = "<C-g>",
					open_plugins_picker = "<C-b>", -- Works only after having called first another action
					open_lazy_root_find_files = "<C-r>f",
					open_lazy_root_live_grep = "<C-r>g",
				},
				-- Other telescope configuration options
			},
		},
	})

	require("telescope").load_extension("notify")
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("zoxide")
	require("telescope").load_extension("frecency")
	require("telescope").load_extension("aerial")
	require("telescope").load_extension("noice")
	require("telescope").load_extension("undo")
	require("telescope").load_extension("smart_open")
end

return {
	telescope,
	{
		"luc-tielen/telescope_hoogle",
		ft = "haskell",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("hoogle")
		end,
	},
	{
		"danielfalk/smart-open.nvim",
		branch = "0.1.x",
		dependencies = { "kkharji/sqlite.lua" },
	},
	{
		"wintermute-cell/gitignore.nvim",
		cmd = { "GitIgnore" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
}
