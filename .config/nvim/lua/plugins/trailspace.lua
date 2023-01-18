return {
	"echasnovski/mini.trailspace",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("mini.trailspace").setup({
			only_in_normal_buffers = true,
		})
	end,
}
