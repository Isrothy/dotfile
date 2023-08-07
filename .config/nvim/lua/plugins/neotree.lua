local M = {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = { "Neotree" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"s1n7ax/nvim-window-picker",
	},
	keys = {
		{ "<F2>", "<cmd>Neotree filesystem toggle left<cr>", desc = "Neotree toggle filesystem" },
		{ "<F3>", "<cmd>Neotree buffers toggle left<cr>", desc = "Neotree toggle buffers" },
		{ "<F4>", "<cmd>Neotree git_status toggle left<cr>", desc = "Neotree toggle git status" },
	},
}

M.config = function()
	local renderer = require("neo-tree.ui.renderer")

	-- Expand a node and load filesystem info if needed.
	local function open_dir(state, dir_node)
		local fs = require("neo-tree.sources.filesystem")
		fs.toggle_directory(state, dir_node, nil, true, false)
	end

	-- Expand a node and all its children, optionally stopping at max_depth.
	local function recursive_open(state, node, max_depth)
		local max_depth_reached = 1
		local stack = { node }
		while next(stack) ~= nil do
			node = table.remove(stack)
			if node.type == "directory" and not node:is_expanded() then
				open_dir(state, node)
			end

			local depth = node:get_depth()
			max_depth_reached = math.max(depth, max_depth_reached)

			if not max_depth or depth < max_depth - 1 then
				local children = state.tree:get_nodes(node:get_id())
				for _, v in ipairs(children) do
					table.insert(stack, v)
				end
			end
		end

		return max_depth_reached
	end

	--- Open the fold under the cursor, recursing if count is given.
	local function neotree_zo(state, open_all)
		local node = state.tree:get_node()

		if open_all then
			recursive_open(state, node)
		else
			recursive_open(state, node, node:get_depth() + vim.v.count1)
		end

		renderer.redraw(state)
	end

	--- Recursively open the current folder and all folders it contains.
	local function neotree_zO(state)
		neotree_zo(state, true)
	end

	-- The nodes inside the root folder are depth 2.
	local MIN_DEPTH = 2

	--- Close the node and its parents, optionally stopping at max_depth.
	local function recursive_close(state, node, max_depth)
		if max_depth == nil or max_depth <= MIN_DEPTH then
			max_depth = MIN_DEPTH
		end

		local last = node
		while node and node:get_depth() >= max_depth do
			if node:has_children() and node:is_expanded() then
				node:collapse()
			end
			last = node
			node = state.tree:get_node(node:get_parent_id())
		end

		return last
	end

	--- Close a folder, or a number of folders equal to count.
	local function neotree_zc(state, close_all)
		local node = state.tree:get_node()
		if not node then
			return
		end

		local max_depth
		if not close_all then
			max_depth = node:get_depth() - vim.v.count1
			if node:has_children() and node:is_expanded() then
				max_depth = max_depth + 1
			end
		end

		local last = recursive_close(state, node, max_depth)
		renderer.redraw(state)
		renderer.focus_node(state, last:get_id())
	end

	-- Close all containing folders back to the top level.
	local function neotree_zC(state)
		neotree_zc(state, true)
	end

	--- Open a closed folder or close an open one, with an optional count.
	local function neotree_za(state, toggle_all)
		local node = state.tree:get_node()
		if not node then
			return
		end

		if node.type == "directory" and not node:is_expanded() then
			neotree_zo(state, toggle_all)
		else
			neotree_zc(state, toggle_all)
		end
	end

	--- Recursively close an open folder or recursively open a closed folder.
	local function neotree_zA(state)
		neotree_za(state, true)
	end

	--- Set depthlevel, analagous to foldlevel, for the neo-tree file tree.
	local function set_depthlevel(state, depthlevel)
		if depthlevel < MIN_DEPTH then
			depthlevel = MIN_DEPTH
		end

		local stack = state.tree:get_nodes()
		while next(stack) ~= nil do
			local node = table.remove(stack)

			if node.type == "directory" then
				local should_be_open = depthlevel == nil or node:get_depth() < depthlevel
				if should_be_open and not node:is_expanded() then
					open_dir(state, node)
				elseif not should_be_open and node:is_expanded() then
					node:collapse()
				end
			end

			local children = state.tree:get_nodes(node:get_id())
			for _, v in ipairs(children) do
				table.insert(stack, v)
			end
		end

		vim.b.neotree_depthlevel = depthlevel
	end

	--- Refresh the tree UI after a change of depthlevel.
	-- @bool stay Keep the current node revealed and selected
	local function redraw_after_depthlevel_change(state, stay)
		local node = state.tree:get_node()

		if stay then
			require("neo-tree.ui.renderer").expand_to_node(state.tree, node)
		else
			-- Find the closest parent that is still visible.
			local parent = state.tree:get_node(node:get_parent_id())
			while not parent:is_expanded() and parent:get_depth() > 1 do
				node = parent
				parent = state.tree:get_node(node:get_parent_id())
			end
		end

		renderer.redraw(state)
		renderer.focus_node(state, node:get_id())
	end

	--- Update all open/closed folders by depthlevel, then reveal current node.
	local function neotree_zx(state)
		set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
		redraw_after_depthlevel_change(state, true)
	end

	--- Update all open/closed folders by depthlevel.
	local function neotree_zX(state)
		set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
		redraw_after_depthlevel_change(state, false)
	end

	-- Collapse more folders: decrease depthlevel by 1 or count.
	local function neotree_zm(state)
		local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
		set_depthlevel(state, depthlevel - vim.v.count1)
		redraw_after_depthlevel_change(state, false)
	end

	-- Collapse all folders. Set depthlevel to MIN_DEPTH.
	local function neotree_zM(state)
		set_depthlevel(state, MIN_DEPTH)
		redraw_after_depthlevel_change(state, false)
	end

	-- Expand more folders: increase depthlevel by 1 or count.
	local function neotree_zr(state)
		local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
		set_depthlevel(state, depthlevel + vim.v.count1)
		redraw_after_depthlevel_change(state, false)
	end

	-- Expand all folders. Set depthlevel to the deepest node level.
	local function neotree_zR(state)
		local top_level_nodes = state.tree:get_nodes()
		local max_depth = 1
		for _, node in ipairs(top_level_nodes) do
			max_depth = math.max(max_depth, recursive_open(state, node))
		end

		vim.b.neotree_depthlevel = max_depth
		redraw_after_depthlevel_change(state, false)
	end

	require("neo-tree").setup({
		sources = {
			"filesystem",
			"buffers",
			"git_status",
		},
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		use_popups_for_input = true,
		open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },

		source_selector = {
			winbar = true, -- toggle to show selector on winbar
			statusline = true, -- toggle to show selector on statusline
			show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
			-- of the top visible node when scrolled down.
			sources = { -- falls back to source_name if nil
				{
					source = "filesystem", -- string
					display_name = " 󰉓 Files ", -- string | nil
				},
				{
					source = "buffers", -- string
					display_name = " 󰈙 Buffers ", -- string | nil
				},
				{
					source = "git_status", -- string
					display_name = "  Git ", -- string | nil
				},
			},
			content_layout = "center", -- only with `tabs_layout` = "equal", "focus"
			--                start  : |/ 󰓩 bufname     \/...
			--                end    : |/     󰓩 bufname \/...
			--                center : |/   󰓩 bufname   \/...
			tabs_layout = "equal", -- start, end, center, equal, focus
			--             start  : |/  a  \/  b  \/  c  \            |
			--             end    : |            /  a  \/  b  \/  c  \|
			--             center : |      /  a  \/  b  \/  c  \      |
			--             equal  : |/    a    \/    b    \/    c    \|
			--             active : |/  focused tab    \/  b  \/  c  \|
			truncation_character = "…", -- character to use when truncating the tab label
			tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
			tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
			padding = 0, -- can be int or table
			-- padding = { left = 2, right = 0 },
			-- separator = { left = "", right = "" },
			separator = "", -- can be string or table, see below
			-- separator = { left = "▏", right = "▕" },
			-- separator = { left = "/", right = "\\", override = nil }, -- |/  a  \/  b  \/  c  \...
			-- separator = { left = "/", right = "\\", override = "right" }, -- |/  a  \  b  \  c  \...
			-- separator = { left = "/", right = "\\", override = "left" },  -- |/  a  /  b  /  c  /...
			-- separator = { left = "/", right = "\\", override = "active" },-- |/  a  / b:active \  c  \...
			-- separator = "|",                                              -- ||  a  |  b  |  c  |...
			separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
			show_separator_on_edge = false,
			--                       true  : |/    a    \/    b    \/    c    \|
			--                       false : |     a    \/    b    \/    c     |
		},
		default_component_configs = {
			container = {
				enable_character_fade = true,
			},
			indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "󰜌",
				folder_empty_open = "󰜌",
				default = "*",
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- Change type
					added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
					modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
					deleted = "✖", -- this can only be used in the git_status source
					renamed = "󰁕", -- this can only be used in the git_status source
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
		},
		window = {
			position = "left",
			width = 36,
			auto_expand_width = false,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["<space>"] = "none",
				["<tab>"] = function(state)
					local node = state.tree:get_node()
					if require("neo-tree.utils").is_expandable(node) then
						state.commands["toggle_node"](state)
					else
						state.commands["open_with_window_picker"](state)
						vim.cmd("Neotree reveal")
					end
				end,
				["o"] = "open_with_window_picker",
				["t"] = "open_tabnew",
				["s"] = "split_with_window_picker",
				["v"] = "vsplit_with_window_picker",
				["C"] = "close_node",
				["a"] = {
					"add",
					-- some commands may take optional config options, see `:h neo-tree-mappings` for details
					config = {
						show_path = "relative", -- "none", "relative", "absolute"
					},
				},
				["A"] = "add_directory",
				["d"] = "delete",
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy", -- takes text input for destination
				["m"] = "move", -- takes text input for destination
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["h"] = "",
				["l"] = "",

				["z"] = "none",

				["zo"] = neotree_zo,
				["zO"] = neotree_zO,
				["zc"] = neotree_zc,
				["zC"] = neotree_zC,
				["za"] = neotree_za,
				["zA"] = neotree_zA,
				["zx"] = neotree_zx,
				["zX"] = neotree_zX,
				["zm"] = neotree_zm,
				["zM"] = neotree_zM,
				["zr"] = neotree_zr,
				["zR"] = neotree_zR,
				["<m-h>"] = "none",
				["<m-j>"] = "none",
				["<m-k>"] = "none",
				["<m-l>"] = "none",
			},
		},
		nesting_rules = {},
		filesystem = {
			filtered_items = {
				visible = true, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = {},
				hide_by_pattern = { -- uses glob style patterns
					--"*.meta"
				},
				never_show = { -- remains hidden even if visible is toggled to true
					".DS_Store",
					"thumbs.db",
				},
			},
			follow_current_file = {
				enabled = false, -- This will find and focus the file in the active buffer every time
				--               -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			-- time the current file is changed while the tree is open.
			group_empty_dirs = false, -- when true, empty folders will be grouped together
			hijack_netrw_behavior = "disabled", -- netrw disabled, opening a directory opens neo-tree
			-- in whatever position is specified in window.position
			-- "open_current",  -- netrw disabled, opening a directory opens within the
			-- window like netrw would, regardless of window.position
			-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
			-- instead of relying on nvim autocmd events.
			window = {
				mappings = {
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["H"] = "toggle_hidden",
					["/"] = "fuzzy_finder",
					["f"] = "filter_on_submit",
					["<c-x>"] = "clear_filter",
					["[c"] = "prev_git_modified",
					["]c"] = "next_git_modified",
					["gA"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
				},
			},
		},
		buffers = {
			follow_current_file = {
				enabled = false, -- This will find and focus the file in the active buffer every time
				--               -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			-- time the current file is changed while the tree is open.
			group_empty_dirs = true, -- when true, empty folders will be grouped together
			show_unloaded = true,
			window = {
				mappings = {
					["bd"] = "buffer_delete",
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["gA"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
				},
			},
		},
		git_status = {
			window = {
				mappings = {
					["gA"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
				},
			},
		},
		diagnostics = {
			bind_to_cwd = true,
			diag_sort_function = "severity", -- "severity" means diagnostic items are sorted by severity in addition to their positions.
			-- "position" means diagnostic items are sorted strictly by their positions.
			-- May also be a function.
			follow_behavior = { -- Behavior when `follow_current_file` is true
				always_focus_file = false, -- Focus the followed file, even when focus is currently on a diagnostic item belonging to that file.
				expand_followed = true, -- Ensure the node of the followed file is expanded
				collapse_others = true, -- Ensure other nodes are collapsed
			},
			follow_current_file = true,
			group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
			group_empty_dirs = true, -- when true, empty directories will be grouped together
			show_unloaded = true, -- show diagnostics from unloaded buffers
			window = {
				mappings = {
					["w"] = "",
				},
			},
		},
	})

	vim.g.neo_tree_remove_legacy_commands = 1
end

return M
