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
					extensions = require("ultimate-autopair.maps.bs").default_extensions,
				},
				cr = {
					enable = true,
					autoclose = true,
					multichar = {
						enable = true,
						markdown = { { "```", "```", pair = true, noalpha = true, next = true } },
					},
					addsemi = { "c", "cpp", "rust" },
					fallback = nil,
					extensions = require("ultimate-autopair.maps.cr").default_extensions,
				},
				space = {
					enable = true,
					fallback = nil,
				},
				fastwarp = {
					enable = false,
					hopout = false,
					map = "<M-e>",
					rmap = "<M-E>",
					Wmap = "<M-C-e>",
					cmap = "<M-e>",
					rcmap = "<M-E>",
					Wcmap = "<M-C-e>",
					multiline = true,
					fallback = nil,
					extensions = require("ultimate-autopair.maps.fastwarp").default_extensions,
					endextensions = require("ultimate-autopair.maps.fastwarp").default_endextensions,
					rextensions = require("ultimate-autopair.maps.rfastwarp").default_extensions,
					rendextensions = require("ultimate-autopair.maps.rfastwarp").default_endextensions,
				},
				fastend = {
					enable = true,
					map = "<M-$>",
					cmap = "<M-$>",
					smart = false,
					fallback = nil,
				},
				-- _default_beg_filter = M.default_beg_filter,
				-- _default_end_filter = M.default_end_filter,
				extensions = {
					{ "cmdtype", { "/", "?", "@" } },
					"multichar",
					"string",
					{ "treenode", { inside = { "comment" } } },
					{ "escape", { filter = true } },
					"rules",
					"filetype",
					{ "alpha", { before = { "'" } } },
					{ "suround", { '"', "'" } },
					{ "fly", { ")", "}", "]", " ", match = nil, nofilter = false } },
				},
				internal_pairs = {
					{ "(", ")" },
					{ "'", "'", rules = { { "when", { "option", "lisp" }, { "instring" } } } },
					{ "'", "'", rules = { { "not", { "filetype", "tex" } } } },
					rules = { --only runs if the extension rules is loaded
						{
							[[\']],
							[[\']],
							rules = {
								{
									"and",
									{ "not", { "or", { "next", "'" }, { "previous", "\\", 2 } } },
									{
										"instring",
									},
								},
							},
						},
						{
							[[\"]],
							[[\"]],
							rules = {
								{
									"and",
									{ "not", { "or", { "next", '"' }, { "previous", "\\", 2 } } },
									{
										"instring",
									},
								},
							},
						},
					},
					ft = {
						markdown = {
							{ "```", "```" },
							{ "<!--", "-->" },
						},
						TelescopePrompt = { disable = true },
					},
				},
			})
		end,
	},
	{
		"altermo/npairs-integrate-upair",
		dependencies = { "windwp/nvim-autopairs", "altermo/ultimate-autopair.nvim" },
		event = { "InsertEnter", "CmdlineEnter" },
		enabled = false,
		config = function()
			require("npairs-int-upair").setup({
				map = "n", --which of them should be the insert mode autopair
				cmap = "u", --which of them should be the cmd mode autopair (only 'u' supported)
				bs = "n", --which of them should be the backspace
				cr = "n", --which of them should be the newline
				space = "u", --which of them should be the space (only 'u' supported)
				c_h = "n", --which of them should be the <C-h> (only 'n' supported)
				c_w = "n", --which of them should be the <C-w> (only 'n' supported)
			})
		end,
	},
}
