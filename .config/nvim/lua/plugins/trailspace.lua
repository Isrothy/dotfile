return {
	{
		"echasnovski/mini.trailspace",
		enabled = true,
		event = { "BufReadPost", "BufNewFile" },
		init = function()
			vim.api.nvim_create_user_command("MiniTrailspace", "lua MiniTrailspace.trim()", {})
			vim.api.nvim_create_user_command("MiniTrailspaceLastlines", "lua MiniTrailspace.trim_last_lines()", {})
		end,
		opts = {
			only_in_normal_buffers = true,
		},
	},
}
