local TS = {
	"nvim-treesitter/nvim-treesitter",
	enabled = true,
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- One of "all", "maintained" (parsers with maintainers), or a list of languages
			-- ensure_installed = { "c", "cpp", "java" },

			-- Install languages synchronously (only applied to `ensure_installed`)
			sync_install = false,

			matchup = {
				enable = false, -- mandatory, false will disable the whole extension
				disable_virtual_text = true,
			},
			highlight = {
				-- `false` will disable the whole extension
				enable = true,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<enter>",
					node_incremental = "<enter>",
					node_decremental = "<BS>",
					scope_incremental = "<c-s>",
				},
			},
			indent = {
				enable = false,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
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

local iswap = {
	"mizlan/iswap.nvim",
	cmd = {
		"ISwap",
		"ISwapWith",
		"ISwapNode",
		"ISwapNodeWith",
		"ISwapNodeWithLeft",
		"ISwapNodeWithRight",
	},
	init = function()
		vim.keymap.set({ "n" }, "<leader>is", [[<cmd>ISwap<cr>]], { desc = "ISwap" })
		vim.keymap.set({ "n" }, "<leader>iw", [[<cmd>ISwapWith<cr>]], { desc = "ISwap with" })
		vim.keymap.set({ "n" }, "<leader>in", [[<cmd>ISwapNode<cr>]], { desc = "ISwap node" })
		vim.keymap.set({ "n" }, "<leader>im", [[<cmd>ISwapNodeWith<cr>]], { desc = "ISwap node with" })
		vim.keymap.set({ "n" }, "<m-i>", [[<cmd>ISwapNodeWithLeft<cr>]], { desc = "ISwap node with left" })
		vim.keymap.set({ "n" }, "<m-o>", [[<cmd>ISwapNodeWithRight<cr>]], { desc = "ISwap node with right" })
	end,
	opts = {
		-- The keys that will be used as a selection, in order
		-- ('asdfghjklqwertyuiopzxcvbnm' by default)
		keys = "qwertyuiop",

		-- Grey out the rest of the text when making a selection
		-- (enabled by default)
		grey = "disable",

		-- Highlight group for the sniping value (asdf etc.)
		-- default 'Search'
		hl_snipe = "Search",

		-- Highlight group for the visual selection of terms
		-- default 'Visual'
		hl_selection = "Visual",

		-- Highlight group for the greyed background
		-- default 'Comment'
		hl_grey = "Comment",

		-- Post-operation flashing highlight style,
		-- either 'simultaneous' or 'sequential', or false to disable
		-- default 'sequential'
		flash_style = "simultaneous",

		-- Highlight group for flashing highlight afterward
		-- default 'IncSearch'
		hl_flash = "IncSearch",

		-- Move cursor to the other element in ISwap*With commands
		-- default false
		move_cursor = true,

		-- Automatically swap with only two arguments
		-- default nil
		autoswap = true,

		-- Other default options you probably should not change:
		debug = nil,
		hl_grey_priority = "1000",
	},
}
local rainbow = {
	"HiPhish/rainbow-delimiters.nvim",
	event = { "BufReadPost", "BufNewFile" },
	enabled = true,
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
				jsx = "rainbow-parens",
				tsx = "rainbow-parens",
				verilog = "rainbow-blocks",
			},
		}
	end,
}
local endwise = {
	"RRethy/nvim-treesitter-endwise",
	event = { "InsertEnter" },
	-- ft = {
	-- 	"lua",
	-- 	"vim",
	-- 	"ruby",
	-- 	"bash",
	-- 	"zsh",
	-- 	"sh",
	-- },
}

local autotag = {
	"windwp/nvim-ts-autotag",
	event = "InsertEnter",
}

local neogen = {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	cmd = "Neogen",
	opts = {
		snippet_engine = "luasnip",
	},
}

local femaco = {
	"AckslD/nvim-FeMaco.lua",
	cmd = "FeMaco",
	opts = {},
}
local node_marker = {
	"atusy/tsnode-marker.nvim",
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
	requires = {
		"nvim-treesitter/nvim-treesitter",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		-- 'narrative'
		mode = "narrative", -- TODO: 'ascii', 'graphical'

		-- automatically show the explainer when the cursor enters a regexp
		auto = false,

		-- filetypes (i.e. extensions) in which to run the autocommand
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

		-- Whether to log debug messages
		debug = false,

		-- 'split', 'popup'
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
