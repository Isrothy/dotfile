return {
	{
		"echasnovski/mini.trailspace",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.trailspace").setup({
				only_in_normal_buffers = true,
			})
		end,
	},
	{
		"echasnovski/mini.bufremove",
		event = "BufDelete",
		config = function()
			require("mini.bufremove").setup()
		end,
	},
	{
		"echasnovski/mini.ai",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.ai").setup({
				-- Table with textobject id as fields, textobject specification as values.
				-- Also use this to disable builtin textobjects. See |MiniAi.config|.
				custom_textobjects = nil,

				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					-- Main textobject prefixes
					around = "a",
					inside = "i",

					-- Next/last variants
					around_next = "an",
					inside_next = "in",
					around_last = "al",
					inside_last = "il",

					-- Move cursor to corresponding edge of `a` textobject
					goto_left = "g[",
					goto_right = "g]",
				},

				-- Number of lines within which textobject is searched
				n_lines = 50,

				-- How to search for object (first inside current line, then inside
				-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
				-- 'cover_or_nearest', 'next', 'previous', 'nearest'.
				search_method = "cover_or_next",
			})
		end,
	},
	{
		"echasnovski/mini.animate",
		-- "echasnovski/mini.nvim",
		lazy = false,

		enabled = false,
		config = function()
			local animate = require("mini.animate")
			require("mini.animate").setup({
				cursor = {
					enable = true,
					timing = animate.gen_timing.quartic({ ease = "in-out", duration = 250, unit = "total" }),
				},
				scroll = {
					enable = true,
					timing = animate.gen_timing.quartic({ ease = "in-out", duration = 250, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({ max_output_steps = 121 }),
				},
				open = {
					-- Whether to enable this animation
					enable = true,
				},
				close = {
					-- Whether to enable this animation
					enable = true,
				},
			})
		end,
	},
}
