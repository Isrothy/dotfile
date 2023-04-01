return {
	"chrisgrieser/nvim-recorder",
	keys = { { "q" }, { "Q" }, { "<C-q>" }, { "cq" }, { "yq" } },
	enabled = false,
	config = function()
		require("recorder").setup({
			-- Named registers where macros are saved. The first register is the default
			-- register/macro-slot used after startup.
			slots = { "x", "y", "z" },

			-- Default keymaps
			mapping = {
				startStopRecording = "q",
				playMacro = "Q",
				switchSlot = "<C-q>",
				editMacro = "cq",
				yankMacro = "yq",
				addBreakPoint = "##",
			},

			-- clear all macros-slots on startup
			clear = true,

			-- log level used for any notification. Mostly relevant for nvim-notify.
			-- (Note that by default, nvim-notify does not show the levels trace and debug.)
			logLevel = vim.log.levels.INFO,

			-- experimental. See README.
			dapSharedKeymaps = false,
		})
	end,
}
