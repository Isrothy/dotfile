local M = {
	"echasnovski/mini.bufremove",
	event = "BufDelete",
}

M.config = function()
	require("mini.bufremove").setup()
end

return M
