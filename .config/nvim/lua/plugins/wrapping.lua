return {
	"andrewferrier/wrapping.nvim",
	enabled = false,
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("wrapping").setup({
			create_commands = true,
			notify_on_switch = true,
			create_keymappings = false,
			softener = { markdown = true },
			auto_set_mode_filetype_allowlist = {
				"asciidoc",
				"gitcommit",
				"latex",
				"mail",
				"markdown",
				"rst",
				"tex",
				"text",
			},
		})
	end,
}
