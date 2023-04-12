return {
	{
		"lewis6991/gitsigns.nvim",
		event = {  "VeryLazy" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 0,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 7,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "rounded",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					-- Actions
					vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
					vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
					vim.keymap.set("n", "<leader>hS", gs.stage_buffer)
					vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk)
					vim.keymap.set("n", "<leader>hR", gs.reset_buffer)
					vim.keymap.set("n", "<leader>hp", gs.preview_hunk)
					vim.keymap.set("n", "<leader>hb", gs.toggle_current_line_blame)
					vim.keymap.set("n", "<leader>hd", gs.diffthis)
					vim.keymap.set("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					vim.keymap.set("n", "<leader>D", gs.toggle_deleted)

					-- Text object
					vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
					vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { expr = true, desc = "Next hunk" })
					vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { expr = true, desc = "Previous hunk" })
				end,
				trouble = false,
			})
			-- require("scrollbar.handlers.gitsigns").setup()
		end,
	},

	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
		config = function()
			-- Lua
			local actions = require("diffview.actions")

			require("diffview").setup({
				diff_binaries = false, -- Show diffs for binaries
				enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
				git_cmd = { "git" }, -- The git executable followed by default args.
				use_icons = true, -- Requires nvim-web-devicons
				show_help_hints = true, -- Show hints for how to open the help panel
				watch_index = true, -- Update views and index buffers when the git index changes.
				icons = { -- Only applies when use_icons is true.
					folder_closed = "",
					folder_open = "",
				},
				signs = {
					fold_closed = "",
					fold_open = "",
					done = "✓",
				},
				view = {
					-- Configure the layout and behavior of different types of views.
					-- Available layouts:
					--  'diff1_plain'
					--    |'diff2_horizontal'
					--    |'diff2_vertical'
					--    |'diff3_horizontal'
					--    |'diff3_vertical'
					--    |'diff3_mixed'
					--    |'diff4_mixed'
					-- For more info, see ':h diffview-config-view.x.layout'.
					default = {
						-- Config for changed files, and staged files in diff views.
						layout = "diff2_horizontal",
					},
					merge_tool = {
						-- Config for conflicted files in diff views during a merge or rebase.
						layout = "diff3_horizontal",
						disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
					},
					file_history = {
						-- Config for changed files in file history views.
						layout = "diff2_horizontal",
					},
				},
				file_panel = {
					listing_style = "tree", -- One of 'list' or 'tree'
					tree_options = { -- Only applies when listing_style is 'tree'
						flatten_dirs = true, -- Flatten dirs that only contain one single dir
						folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
					},
					win_config = { -- See ':h diffview-config-win_config'
						position = "left",
						width = 35,
						win_opts = {},
					},
				},
				file_history_panel = {
					log_options = { -- See ':h diffview-config-log_options'
						git = {
							single_file = {
								diff_merges = "combined",
							},
							multi_file = {
								diff_merges = "first-parent",
							},
						},
						hg = {
							single_file = {},
							multi_file = {},
						},
					},
					win_config = { -- See ':h diffview-config-win_config'
						position = "bottom",
						height = 16,
						win_opts = {},
					},
				},
				commit_log_panel = {
					win_config = { -- See ':h diffview-config-win_config'
						win_opts = {},
					},
				},
				default_args = { -- Default args prepended to the arg-list for the listed commands
					DiffviewOpen = {},
					DiffviewFileHistory = {},
				},
				hooks = {}, -- See ':h diffview-config-hooks'
				keymaps = {
					disable_defaults = false, -- Disable the default keymaps
					view = {
						-- The `view` bindings are active in the diff buffers, only when the current
						-- tabpage is a Diffview.
						{ "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
						{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
						{
							"n",
							"gf",
							actions.goto_file,
							{ desc = "Open the file in a new split in the previous tabpage" },
						},
						{ "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
						{ "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
						{ "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
						{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel." } },
						{ "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle through available layouts." } },
						{
							"n",
							"[x",
							actions.prev_conflict,
							{ desc = "In the merge-tool: jump to the previous conflict" },
						},
						{
							"n",
							"]x",
							actions.next_conflict,
							{ desc = "In the merge-tool: jump to the next conflict" },
						},
						{
							"n",
							"<leader>co",
							actions.conflict_choose("ours"),
							{ desc = "Choose the OURS version of a conflict" },
						},
						{
							"n",
							"<leader>ct",
							actions.conflict_choose("theirs"),
							{ desc = "Choose the THEIRS version of a conflict" },
						},
						{
							"n",
							"<leader>cb",
							actions.conflict_choose("base"),
							{ desc = "Choose the BASE version of a conflict" },
						},
						{
							"n",
							"<leader>ca",
							actions.conflict_choose("all"),
							{ desc = "Choose all the versions of a conflict" },
						},
						{ "n", "dx", actions.conflict_choose("none"), { desc = "Delete the conflict region" } },
					},
					diff1 = {
						-- Mappings in single window diff layouts
						{ "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
					},
					diff2 = {
						-- Mappings in 2-way diff layouts
						{ "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
					},
					diff3 = {
						-- Mappings in 3-way diff layouts
						{
							{ "n", "x" },
							"2do",
							actions.diffget("ours"),
							{ desc = "Obtain the diff hunk from the OURS version of the file" },
						},
						{
							{ "n", "x" },
							"3do",
							actions.diffget("theirs"),
							{ desc = "Obtain the diff hunk from the THEIRS version of the file" },
						},
						{ "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
					},
					diff4 = {
						-- Mappings in 4-way diff layouts
						{
							{ "n", "x" },
							"1do",
							actions.diffget("base"),
							{ desc = "Obtain the diff hunk from the BASE version of the file" },
						},
						{
							{ "n", "x" },
							"2do",
							actions.diffget("ours"),
							{ desc = "Obtain the diff hunk from the OURS version of the file" },
						},
						{
							{ "n", "x" },
							"3do",
							actions.diffget("theirs"),
							{ desc = "Obtain the diff hunk from the THEIRS version of the file" },
						},
						{ "n", "g?", actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
					},
					file_panel = {
						{
							"n",
							"j",
							actions.next_entry,
							{ desc = "Bring the cursor to the next file entry" },
						},
						{
							"n",
							"<down>",
							actions.next_entry,
							{ desc = "Bring the cursor to the next file entry" },
						},
						{
							"n",
							"k",
							actions.prev_entry,
							{ desc = "Bring the cursor to the previous file entry." },
						},
						{
							"n",
							"<up>",
							actions.prev_entry,
							{ desc = "Bring the cursor to the previous file entry." },
						},
						{ "n", "<cr>", actions.select_entry, { desc = "Open the diff for the selected entry." } },
						{ "n", "o", actions.select_entry, { desc = "Open the diff for the selected entry." } },
						{
							"n",
							"<2-LeftMouse>",
							actions.select_entry,
							{ desc = "Open the diff for the selected entry." },
						},
						{ "n", "-", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry." } },
						{ "n", "S", actions.stage_all, { desc = "Stage all entries." } },
						{ "n", "U", actions.unstage_all, { desc = "Unstage all entries." } },
						{
							"n",
							"X",
							actions.restore_entry,
							{ desc = "Restore entry to the state on the left side." },
						},
						{ "n", "L", actions.open_commit_log, { desc = "Open the commit log panel." } },
						{ "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
						{ "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
						{ "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
						{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
						{
							"n",
							"gf",
							actions.goto_file,
							{ desc = "Open the file in a new split in the previous tabpage" },
						},
						{ "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
						{ "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
						{ "n", "i", actions.listing_style, { desc = "Toggle between 'list' and 'tree' views" } },
						{
							"n",
							"f",
							actions.toggle_flatten_dirs,
							{ desc = "Flatten empty subdirectories in tree listing style." },
						},
						{
							"n",
							"R",
							actions.refresh_files,
							{ desc = "Update stats and entries in the file list." },
						},
						{ "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
						{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel" } },
						{ "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle available layouts" } },
						{ "n", "[x", actions.prev_conflict, { desc = "Go to the previous conflict" } },
						{ "n", "]x", actions.next_conflict, { desc = "Go to the next conflict" } },
						{ "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
					},
					file_history_panel = {
						{ "n", "g!", actions.options, { desc = "Open the option panel" } },
						{
							"n",
							"<C-A-d>",
							actions.open_in_diffview,
							{ desc = "Open the entry under the cursor in a diffview" },
						},
						{
							"n",
							"y",
							actions.copy_hash,
							{ desc = "Copy the commit hash of the entry under the cursor" },
						},
						{ "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
						{ "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
						{ "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
						{
							"n",
							"j",
							actions.next_entry,
							{ desc = "Bring the cursor to the next file entry" },
						},
						{
							"n",
							"<down>",
							actions.next_entry,
							{ desc = "Bring the cursor to the next file entry" },
						},
						{
							"n",
							"k",
							actions.prev_entry,
							{ desc = "Bring the cursor to the previous file entry." },
						},
						{
							"n",
							"<up>",
							actions.prev_entry,
							{ desc = "Bring the cursor to the previous file entry." },
						},
						{
							"n",
							"<cr>",
							actions.select_entry,
							{ desc = "Open the diff for the selected entry." },
						},
						{
							"n",
							"o",
							actions.select_entry,
							{ desc = "Open the diff for the selected entry." },
						},
						{
							"n",
							"<2-LeftMouse>",
							actions.select_entry,
							{ desc = "Open the diff for the selected entry." },
						},
						{ "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
						{ "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
						{ "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
						{
							"n",
							"<s-tab>",
							actions.select_prev_entry,
							{ desc = "Open the diff for the previous file" },
						},
						{
							"n",
							"gf",
							actions.goto_file,
							{ desc = "Open the file in a new split in the previous tabpage" },
						},
						{ "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
						{ "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
						{ "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
						{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel" } },
						{ "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle available layouts" } },
						{ "n", "g?", actions.help("file_history_panel"), { desc = "Open the help panel" } },
					},
					option_panel = {
						{ "n", "<tab>", actions.select_entry, { desc = "Change the current option" } },
						{ "n", "q", actions.close, { desc = "Close the panel" } },
						{ "n", "g?", actions.help("option_panel"), { desc = "Open the help panel" } },
					},
					help_panel = {
						{ "n", "q", actions.close, { desc = "Close help menu" } },
						{ "n", "<esc>", actions.close, { desc = "Close help menu" } },
					},
				},
			})
		end,
	},
}
