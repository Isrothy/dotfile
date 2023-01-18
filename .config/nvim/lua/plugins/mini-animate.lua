return {
	{
		"echasnovski/mini.animate",
		-- "echasnovski/mini.nvim",
		-- branch = "stable",
		enabled = false,
		event = "VeryLazy",
		config = function()
			local animate = require("mini.animate")
			require("mini.animate").setup({
				cursor = {
					enable = true,
					timing = animate.gen_timing.exponential({ ease = "in-out", duration = 150, unit = "total" }),
					path = animate.gen_path.line(),
				},
				scroll = {
					enable = true,
					timing = animate.gen_timing.exponential({ ease = "in-out", duration = 150, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({ max_output_steps = 100 }),
				},
				resize = {
					timing = animate.gen_timing.exponential({ ease = "in-out", duration = 200, unit = "total" }),
				},
				open = {
					enable = true,
					timing = animate.gen_timing.exponential({ ease = "in-out", duration = 200, unit = "total" }),
				},
				close = {
					enable = true,
					timing = animate.gen_timing.exponential({ ease = "in-out", duration = 200, unit = "total" }),
				},
			})
		end,
	},
}
