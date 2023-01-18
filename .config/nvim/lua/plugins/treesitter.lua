local TS = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- One of "all", "maintained" (parsers with maintainers), or a list of languages
			-- ensure_installed = { "c", "cpp", "java" },

			-- Install languages synchronously (only applied to `ensure_installed`)
			sync_install = false,

			highlight = {
				-- `false` will disable the whole extension
				enable = true,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			rainbow = {
				enable = true,
				-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
				extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
				query = { "rainbow-parens", html = "rainbow-tags" },
				hlgroups = {
					"TSRainbowRed",
					"TSRainbowYellow",
					"TSRainbowBlue",
					"TSRainbowGreen",
					"TSRainbowCyan",
					"TSRainbowOrange",
					"TSRainbowViolet",
					"TSRainbowWhite",
				},
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "gni",
					scope_incremental = "gsi",
					node_decremental = "gnd",
				},
			},
			indent = {
				enable = true,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			autotag = {
				enable = true,
			},
			endwise = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = false,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["a#"] = "@condition.outer",
						["i#"] = "@condition.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				move = {
					enable = false,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]#"] = "@conditional.outer",
						["]l"] = "@loop.outer",
						["]b"] = "@block.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]B"] = "@block.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[#"] = "@conditional.outer",
						["[l"] = "@loop.outer",
						["[b"] = "@block.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[B"] = "@block.outer",
					},
				},
			},
		})
	end,
}


local node_action = {
	"ckolkey/ts-node-action",
	-- keys = {
	-- 	{ "<leader>n", "<Cmd>lua require('ts-node-action').node_action() <cr>", mode = "n", desc = "Trigger node action" },
	-- },
	init = function()
		vim.keymap.set(
			{ "n" },
			"<leader>n",
			[[<cmd>lua require'ts-node-action'.node_action() <cr>]],
			{ desc = "Trigger Node Action" }
		)
	end,

	dependencies = { "nvim-treesitter" },
	config = function() -- Optional
		require("ts-node-action").setup({})
	end,
	-- lazy = false,
}

return {
	TS,
	node_action,
	-- {
	-- 	"mrjones2014/nvim-ts-rainbow",
	-- 	enabled = false,
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- },
	-- {
	-- 	"HiPhish/nvim-ts-rainbow2",
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- },
	{
		"RRethy/nvim-treesitter-endwise",
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
					config = {
						css = "/* %s */",
						javascript = {
							__default = "// %s",
							jsx_element = "{/* %s */}",
							jsx_fragment = "{/* %s */}",
							jsx_attribute = "// %s",
							comment = "// %s",
						},
						typescript = { __default = "// %s", __multiline = "/* %s */" },
					},
				},
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.opt.list = true
			-- vim.opt.listchars:append("space:⋅")
			-- vim.opt.listchars:append("eol:↴")

			require("indent_blankline").setup({
				char = "▎",
				char_blankline = "▎",
				context_char = "▎",
				-- space_char_blankline = " ",
				use_treesitter_scope = true,
				show_current_context = true,
				show_current_context_start = true,
			})

			-- vim.cmd[[
			-- 	 let g:indent_blankline_char = '▎'
			-- ]]
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "Neogen",
		config = function()
			require("neogen").setup({
				snippet_engine = "luasnip",
			})
		end,
	},
}
