local M = {
	"echasnovski/mini.animate",
	-- "echasnovski/mini.nvim",
	lazy = false,
	enabled = false,
}

function M.config()
	local animate = require("mini.animate")
	require("mini.animate").setup({
		cursor = {
			enable = true,
			timing = animate.gen_timing.quartic({ ease = "in-out", duration = 250, unit = "total" }),
		},
		scroll = {
			enable = false,
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
end

return M
