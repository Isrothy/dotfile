return {
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter", "CmdlineEnter" },
		enabled = true,
		config = function()
			require("nvim-autopairs").setup({
				map_bs = true,
				map_c_h = true,
				check_ts = true,
				map_c_w = true,
				disable_filetype = { "TelescopePrompt" },
			})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		enabled = false,
		config = function()
			require("ultimate-autopair").setup({
				mapopt = { noremap = true },
				cmap = true,
				bs = {
					enable = true,
					overjump = true,
					space = true,
					multichar = true,
					fallback = nil,
				},
				cr = {
					enable = true,
					autoclose = true,
					multichar = {
						markdown = {
							{
								"```",
								"```",
								pair = true,
								noalpha = true,
								next = true,
							},
						},
						lua = {
							{ "then", "end" },
							{ "do", "end" },
						},
					},
					addsemi = {
						"c",
						"cpp",
						"java",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"rust",
					},
					fallback = nil,
				},
				space = {
					enable = true,
					fallback = nil,
				},
				fastwarp = {
					enable = true,
					map = "<m-e>",
					Wmap = "<m-E>",
					cmap = "<m-e>",
					Wcmap = "<m-E>",
					fallback = nil,
				},
				fastend = {
					enable = true,
					map = "<m-$>",
					cmap = "<m-$>",
					fallback = nil,
				},
				extensions = {
					{ "cmdtype", { "/", "?", "@" } },
					--'indentblock',
					"multichar",
					"string",
					{ "treenode", { inside = { "comment" } } },
					"escape",
					"rules",
					"filetype",
					{ "alpha", { before = { "'" } } },
					{ "suround", { '"', "'" } },
					{ "fly", { ")", "}", "]", " " } },
				},
				{ "(", ")" },
				{ "'", "'", rules = { { "when", { "option", "lisp" }, { "instring" } } } },
				rules = { --only runs if the extension rules is loaded
					{ [[\']], [[\']], rules = { { "not", { "or", { "next", "'" }, { "previous", "\\", 2 } } } } },
					{ [[\"]], [[\"]], rules = { { "not", { "or", { "next", '"' }, { "previous", "\\", 2 } } } } },
				},
				ft = {
					markdown = {
						{ "```", "```" },
						{ "<!--", "-->" },
					},
					---more...
				},
				---more...
			})
		end,
	},
}
