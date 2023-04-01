return {
	"rafcamlet/nvim-luapad",
	cmd = {
		"Luapad",
		"LuaRun",
	},
	config = function()
		require("luapad").setup()
	end,
}
