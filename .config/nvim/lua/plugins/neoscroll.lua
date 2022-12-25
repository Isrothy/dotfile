local M = {
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
		"gg",
		"G",
	},
	enabled = false,
	lazy = false,
}

M.config = function()
	require("neoscroll").setup({
		-- All these keys will be mapped to their corresponding default scrolling animation
		mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
		hide_cursor = false, -- Hide cursor while scrolling
		stop_eof = true, -- Stop at <EOF> when scrolling downwards
		respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
		cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
		easing_function = "sine", -- Default easing function
		pre_hook = nil, -- Function to run before the scrolling animation starts
		post_hook = nil, -- Function to run after the scrolling animation ends
		performance_mode = false, -- Disable "Performance Mode" on all buffers.
	})

	local t = {}
	-- Syntax: t[keys] = {function, {function arguments}}
	t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150" } }
	t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150" } }
	t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "350" } }
	t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "350" } }
	t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
	t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
	t["zt"] = { "zt", { "125" } }
	t["zz"] = { "zz", { "125" } }
	t["zb"] = { "zb", { "125" } }
	t["gg"] = { "scroll", { "-2*vim.api.nvim_buf_line_count(0)", "true", "50", "sine" } }
	t["G"] = { "scroll", { "2*vim.api.nvim_buf_line_count(0)", "true", "50", "sine" } }

	require("neoscroll.config").set_mappings(t)
end

return M
