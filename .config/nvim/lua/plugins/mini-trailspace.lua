local M = {
	"echasnovski/mini.trailspace",
	event = { "BufReadPost", "BufNewFile" },
}

M.config = function()
	require("mini.trailspace").setup({
		only_in_normal_buffers = true,
	})
end

return M
