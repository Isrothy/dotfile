local M = {
	"stevearc/aerial.nvim",
	enabled = true,
}

-- M.init = function()
-- 	vim.keymap.set("n", "<F9>", "<cmd>AerialToggle<CR>", { noremap = true, silent = true })
-- end

M.cmd = { "AerialToggle" }

M.opts = {
	backends = { "markdown", "lsp", "treesitter", "man" },

	layout = {
		max_width = 0.2,
		width = nil,
		min_width = 0.15,
		default_direction = "right",
		-- placement = "window",
		placement = "edge",
		preserve_equality = true,
	},

	-- attach_mode = "window",
	attach_mode = "global",
	close_automatic_events = {},
	keymaps = {
		["?"] = "actions.show_help",
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.jump",
		["<2-LeftMouse>"] = "actions.jump",
		["<C-v>"] = "actions.jump_vsplit",
		["<C-s>"] = "actions.jump_split",
		["p"] = "actions.scroll",
		["<C-j>"] = "actions.down_and_scroll",
		["<C-k>"] = "actions.up_and_scroll",
		["{"] = "actions.prev",
		["}"] = "actions.next",
		["[["] = "actions.prev_up",
		["]]"] = "actions.next_up",
		["q"] = "actions.close",
		["o"] = "actions.tree_toggle",
		["za"] = "actions.tree_toggle",
		["O"] = "actions.tree_toggle_recursive",
		["zA"] = "actions.tree_toggle_recursive",
		["l"] = "actions.tree_open",
		["zo"] = "actions.tree_open",
		["L"] = "actions.tree_open_recursive",
		["zO"] = "actions.tree_open_recursive",
		["h"] = "actions.tree_close",
		["zc"] = "actions.tree_close",
		["H"] = "actions.tree_close_recursive",
		["zC"] = "actions.tree_close_recursive",
		["zr"] = "actions.tree_increase_fold_level",
		["zR"] = "actions.tree_open_all",
		["zm"] = "actions.tree_decrease_fold_level",
		["zM"] = "actions.tree_close_all",
		["zx"] = "actions.tree_sync_folds",
		["zX"] = "actions.tree_sync_folds",
	},

	-- When true, don't load aerial until a command or function is called
	-- Defaults to true, unless `on_attach` is provided, then it defaults to false
	lazy_load = true,

	-- Disable aerial on files with this many lines
	disable_max_lines = nil,

	-- Disable aerial on files this size or larger (in bytes)
	disable_max_size = nil, -- Default 2MB

	-- A list of all symbols to display. Set to false to display all symbols.
	-- This can be a filetype map (see :help aerial-filetype-map)
	-- To see all available values, see :help SymbolKind
	-- filter_kind = false,
	filter_kind = {
		"Array",
		"Boolean",
		"Class",
		"Constructor",
		"Constant",
		"Enum",
		"EnumMember",
		"Event",
		"Field",
		"File",
		"Function",
		"Interface",
		"Key",
		"Module",
		"Method",
		"Namespace",
		"Number",
		"Object",
		"Package",
		"Property",
		"String",
		"Struct",
		"TypeParameter",
		"Variable",
	},
	--
	-- Determines line highlighting mode when multiple splits are visible.
	-- split_width   Each open window will have its cursor location marked in the
	--               aerial buffer. Each line will only be partially highlighted
	--               to indicate which window is at that location.
	-- full_width    Each open window will have its cursor location marked as a
	--               full-width highlight in the aerial buffer.
	-- last          Only the most-recently focused window will have its location
	--               marked in the aerial buffer.
	-- none          Do not show the cursor locations in the aerial window.
	highlight_mode = "split_width",

	-- Highlight the closest symbol if the cursor is not exactly on one.
	highlight_closest = true,

	-- Highlight the symbol in the source buffer when cursor is in the aerial win
	highlight_on_hover = true,

	-- When jumping to a symbol, highlight the line for this many ms.
	-- Set to false to disable
	highlight_on_jump = 300,

	-- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
	-- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
	-- default collapsed icon. The default icon set is determined by the
	-- "nerd_font" option below.
	-- If you have lspkind-nvim installed, it will be the default icon set.
	-- This can be a filetype map (see :help aerial-filetype-map)
	icons = {
		File = "󰈙",
		Module = "",
		Namespace = "󰅪",
		Package = "󰏖",
		Class = "󰠱",
		Method = "󰆧",
		Variable = "󰂡",
		Field = "󰇽",
		Unit = "",
		Value = "󰎠",
		Interface = "",
		Function = "󰊕",
		Constant = "",
		Constructor = "",
		String = "𝓐",
		Number = "#",
		Boolean = "⊨",
		Array = "󰅪",
		Object = "⦿",
		Enum = "",
		Property = "󰜢",
		Key = "🔐",
		Null = "NULL",
		EnumMember = "",
		Struct = "",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "󰅲",
		Text = "",
	},
	-- Show box drawing characters for the tree hierarchy
	show_guides = true,
	-- Customize the characters used when show_guides = true
	guides = {
		-- When the child item has a sibling below it
		mid_item = "├─",
		-- When the child item is the last in the list
		last_item = "└─",
		-- When there are nested child guides to the right
		nested_top = "│ ",
		-- Raw indentation
		whitespace = "  ",
	},
	lsp = {
		diagnostics_trigger_update = true,
		update_when_errors = true,
		update_delay = 300,
	},

	treesitter = {
		update_delay = 300,
	},

	markdown = {
		update_delay = 300,
	},
	man = {
		update_delay = 300,
	},
}

return M
