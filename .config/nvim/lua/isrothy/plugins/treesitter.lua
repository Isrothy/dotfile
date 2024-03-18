local TS = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	enabled = true,
	config = function()
		require("nvim-treesitter.configs").setup({
			sync_install = false,
			-- ignore_install = { "comment" },
			matchup = {
				enable = false,
				disable_virtual_text = true,
				include_match_words = false,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = function()
					return vim.b.large_buf
				end,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<enter>",
					node_incremental = "<enter>",
					node_decremental = "<BS>",
					scope_incremental = false,
					-- scope_incremental = "<c-s>",
				},
			},
			indent = {
				enable = false, -- NOTE: Bad perfromance
			},
			endwise = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = false,
					lookahead = true,
					keymaps = {
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
					enable = false,
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

local indent_blankline = {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "▎",
			tab_char = "▎",
			smart_indent_cap = true,
		},
		whitespace = {
			remove_blankline_trail = false,
		},
		scope = {
			enabled = true,
			show_start = true,
			show_end = true,
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
			include = {
				node_type = {
					lua = {
						"chunk",
						"do_statement",
						"while_statement",
						"repeat_statement",
						"if_statement",
						"for_statement",
						"function_declaration",
						"function_definition",
						"table_constructor",
						"assignment_statement",
					},
					typescript = {
						"statement_block",
						"function",
						"arrow_function",
						"function_declaration",
						"method_definition",
						"for_statement",
						"for_in_statement",
						"catch_clause",
						"object_pattern",
						"arguments",
						"switch_case",
						"switch_statement",
						"switch_default",
						"object",
						"object_type",
						"ternary_expression",
					},
				},
			},
		},
	},
	config = function(_, opts)
		local hooks = require("ibl.hooks")
		-- hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
		require("ibl").setup(opts)
		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
	init = function()
		vim.opt.list = true
	end,
}
local iswap = {
	"mizlan/iswap.nvim",
	enabled = true,
	cmd = {
		"ISwap",
		"ISwapWith",
		"ISwapNode",
		"ISwapNodeWith",
		"ISwapNodeWithLeft",
		"ISwapNodeWithRight",
	},
	keys = {
		{ "<leader>is", [[<cmd>ISwap<cr>]], desc = "ISwap" },
		{ "<leader>iw", [[<cmd>ISwapWith<cr>]], desc = "ISwap with" },
		{ "<leader>in", [[<cmd>ISwapNode<cr>]], desc = "ISwap node" },
		{ "<leader>im", [[<cmd>ISwapNodeWith<cr>]], desc = "ISwap node with" },
		{
			"<m-i>",
			[[<cmd>ISwapNodeWithLeft<cr>]],
			desc = "ISwap node with left",
			mode = { "n", "v" },
		},
		{
			"<m-o>",
			[[<cmd>ISwapNodeWithRight]],
			desc = "ISwap node with right",
			mode = { "n", "v" },
		},
	},
	opts = {
		flash_style = "simultaneous",
		move_cursor = true,
		autoswap = nil,
		debug = nil,
		hl_grey_priority = "1000",
	},
}
local rainbow = {
	"HiPhish/rainbow-delimiters.nvim",
	enabled = true,
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local rainbow_delimiters = require("rainbow-delimiters")

		vim.g.rainbow_delimiters = {
			strategy = {
				[""] = rainbow_delimiters.strategy["global"],
				vim = rainbow_delimiters.strategy["local"],
				html = rainbow_delimiters.strategy["local"],
				commonlisp = rainbow_delimiters.strategy["local"],
				fennel = rainbow_delimiters.strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
				javascript = "rainbow-parens",
				typescript = "rainbow-parens",
				tsx = "rainbow-parens",
				verilog = "rainbow-blocks",
			},
		}
	end,
}
local endwise = {
	"RRethy/nvim-treesitter-endwise",
	enabled = true,
	event = { "InsertEnter" },
}

local autotag = {
	"windwp/nvim-ts-autotag",
	-- event = { "InsertEnter" },
	enabled = true,
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		enable = true,
		enable_rename = true,
		enable_close = true,
		enable_close_on_slash = true,
	},
}

local neogen = {
	"danymat/neogen",
	enabled = true,
	dependencies = "nvim-treesitter/nvim-treesitter",
	cmd = "Neogen",
	opts = {
		snippet_engine = "luasnip",
	},
}

local femaco = {
	"AckslD/nvim-FeMaco.lua",
	enabled = true,
	cmd = "FeMaco",
	opts = {},
}

local node_marker = {
	"atusy/tsnode-marker.nvim",
	enabled = true,
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("tsnode-marker-markdown", {}),
			pattern = "markdown",
			callback = function(ctx)
				require("tsnode-marker").set_automark(ctx.buf, {
					target = { "code_fence_content" }, -- list of target node types
					hl_group = "CursorLine", -- highlight group
				})
			end,
		})
	end,
}

local treesj = {
	"Wansmer/treesj",
	enabled = true,
	keys = {
		{ "<leader>s", desc = "Split lines" },
		{ "<leader>j", desc = "Join lines" },
		{ "<leader>m", desc = "Toggle split/join" },
	},
	opts = {
		use_default_keymaps = true,
		max_join_length = 0xffffffff,
	},
}

local regexplainer = {
	"bennypowers/nvim-regexplainer",
	keys = { "gR", desc = "Explain regex" },
	enabled = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		auto = false,
		filetypes = {
			"html",
			"js",
			"cjs",
			"mjs",
			"ts",
			"jsx",
			"tsx",
			"cjsx",
			"mjsx",
			"swift",
		},
		debug = false,
		display = "popup",
		mappings = {
			toggle = "gR",
			-- examples, not defaults:
			-- show = 'gS',
			-- hide = 'gH',
			-- show_split = 'gP',
			-- show_popup = 'gU',
		},
		popup = {
			border = {
				padding = { 0, 0 },
				style = "rounded",
			},
		},
		narrative = {
			separator = "\n",
		},
	},
}

return {
	TS,
	indent_blankline,
	iswap,
	rainbow,
	femaco,
	endwise,
	autotag,
	neogen,
	node_marker,
	treesj,
	regexplainer,
}
