local map = vim.keymap.set
local custom_textobjects = {
	f = {
		a = "@function.outer",
		i = "@function.inner",
	},
	o = {
		a = { "@conditional.outer", "@loop.outer" },
		i = { "@conditional.inner", "@loop.inner" },
	},
	c = {
		a = "@class.outer",
		i = "@class.inner",
	},
	C = {
		a = "@comment.outer",
		i = "@comment.inner",
	},
	s = {
		a = "@statement.outer",
		i = "@statement.inner",
	},
	b = {
		a = "@block.outer",
		i = "@block.inner",
	},
	p = {
		a = "@parameter.outer",
		i = "@parameter.inner",
	},
	t = {
		a = "@call.outer",
		i = "@call.inner",
	},
	m = {
		a = "@method.outer",
		i = "@method.inner",
	},
}

return {
	{
		"kiyoon/treesitter-indent-object.nvim",
		enabled = true,
		dependencies = {
			"lukas-reineke/indent-blankline.nvim",
		},
		init = function()
			map(
				{ "x", "o" },
				"ai",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>",
				{ noremap = true, silent = true, desc = "context-aware indent" }
			)
			map(
				{ "x", "o" },
				"aI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>",
				{ noremap = true, silent = true, desc = "entire-line indent" }
			)
			map(
				{ "x", "o" },
				"ii",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>",
				{ noremap = true, silent = true, desc = "inner block" }
			)
			map(
				{ "x", "o" },
				"iI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>",
				{ noremap = true, silent = true, desc = "entire inner range" }
			)
		end,
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		event = { "BufRead", "BufNewFile" },
		enabled = true,
		init = function()
			-- map(
			-- 	{ "o", "x" },
			-- 	"R",
			-- 	"<cmd>lua require('various-textobjs').restOfIdentation()<CR>",
			-- 	{ noremap = true, silent = true, desc = "rest of identation" }
			-- )

			map(
				{ "o", "x" },
				"iS",
				"<cmd>lua require('various-textobjs').subword(true)<CR>",
				{ noremap = true, silent = true, desc = "inner subword" }
			)
			map(
				{ "o", "x" },
				"aS",
				"<cmd>lua require('various-textobjs').subword(false)<CR>",
				{ noremap = true, silent = true, desc = "around subword" }
			)
			map(
				{ "o", "x" },
				"C",
				"<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>",
				{ noremap = true, silent = true, desc = "to next closing bracket" }
			)
			map(
				{ "o", "x" },
				"Q",
				"<cmd>lua require('various-textobjs').toNextQuotationMark()<CR>",
				{ noremap = true, silent = true, desc = "to next quotation mark" }
			)

			map(
				{ "o", "x" },
				"r",
				"<cmd>lua require('various-textobjs').restOfParagraph()<CR>",
				{ noremap = true, silent = true, desc = "rest of paragraph" }
			)

			map(
				{ "o", "x" },
				"gG",
				"<cmd>lua require('various-textobjs').entireBuffer()<CR>",
				{ noremap = true, silent = true, desc = "entire buffer" }
			)

			map(
				{ "o", "x" },
				"\\",
				"<cmd>lua require('various-textobjs').nearEoL()<CR>",
				{ noremap = true, silent = true, desc = "near end of line" }
			)

			map(
				{ "o", "x" },
				"i_",
				"<cmd>lua require('various-textobjs').lineCharacterwise(true)<CR>",
				{ noremap = true, silent = true, desc = "inner line" }
			)
			map(
				{ "o", "x" },
				"a_",
				"<cmd>lua require('various-textobjs').lineCharacterwise(false)<CR>",
				{ noremap = true, silent = true, desc = "around line" }
			)

			map(
				{ "o", "x" },
				"|",
				"<cmd>lua require('various-textobjs').column()<CR>",
				{ noremap = true, silent = true, desc = "column" }
			)

			map(
				{ "o", "x" },
				"iv",
				"<cmd>lua require('various-textobjs').value(true)<CR>",
				{ noremap = true, silent = true, desc = "inner value" }
			)
			map(
				{ "o", "x" },
				"av",
				"<cmd>lua require('various-textobjs').value(false)<CR>",
				{ noremap = true, silent = true, desc = "around value" }
			)

			map(
				{ "o", "x" },
				"ik",
				"<cmd>lua require('various-textobjs').key(true)<CR>",
				{ noremap = true, silent = true, desc = "inner key" }
			)
			map(
				{ "o", "x" },
				"ak",
				"<cmd>lua require('various-textobjs').key(false)<CR>",
				{ noremap = true, silent = true, desc = "around key" }
			)

			map(
				{ "o", "x" },
				"L",
				"<cmd>lua require('various-textobjs').url()<CR>",
				{ noremap = true, silent = true, desc = "url" }
			)

			map(
				{ "o", "x" },
				"i.",
				"<cmd>lua require('various-textobjs').number(true)<CR>",
				{ noremap = true, silent = true, desc = "inner number" }
			)
			map(
				{ "o", "x" },
				"a.",
				"<cmd>lua require('various-textobjs').number(false)<CR>",
				{ noremap = true, silent = true, desc = "around number" }
			)

			map(
				{ "o", "x" },
				"!",
				"<cmd>lua require('various-textobjs').diagnostic()<CR>",
				{ noremap = true, silent = true, desc = "diagnostic" }
			)

			map(
				{ "o", "x" },
				"iz",
				"<cmd>lua require('various-textobjs').closedFold(true)<CR>",
				{ noremap = true, silent = true, desc = "inner closed fold" }
			)
			map(
				{ "o", "x" },
				"az",
				"<cmd>lua require('various-textobjs').closedFold(false)<CR>",
				{ noremap = true, silent = true, desc = "around closed fold" }
			)

			map(
				{ "o", "x" },
				"im",
				"<cmd>lua require('various-textobjs').chainMember(true)<CR>",
				{ noremap = true, silent = true, desc = "inner chain member" }
			)
			map(
				{ "o", "x" },
				"am",
				"<cmd>lua require('various-textobjs').chainMember(false)<CR>",
				{ noremap = true, silent = true, desc = "around chain member" }
			)

			map(
				{ "o", "x" },
				"gw",
				"<cmd>lua require('various-textobjs').visibleInWindow()<CR>",
				{ noremap = true, silent = true, desc = "visible in window" }
			)
			map(
				{ "o", "x" },
				"gW",
				"<cmd>lua require('various-textobjs').restOfWindow()<CR>",
				{ noremap = true, silent = true, desc = "rest of window" }
			)

			--------------------------------------------------------------------------------------
			-- put these into the ftplugins or autocms for the filetypes you want to use them with
			--use an autocmd set to keymap for markdown file type
			--use lua api

			local function augroup(name)
				return vim.api.nvim_create_augroup(name, { clear = true })
			end
			vim.api.nvim_create_autocmd("FileType", {
				group = augroup("various_textobjs_mklink"),
				pattern = { "markdown", "toml" },
				callback = function()
					map(
						{ "o", "x" },
						"il",
						"<cmd>lua require('various-textobjs').mdlink(true)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "inner link" }
					)
					map(
						{ "o", "x" },
						"al",
						"<cmd>lua require('various-textobjs').mdlink(false)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "around link" }
					)
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = augroup("various_textobjs_mk_fenced_code_block"),
				pattern = { "markdown" },
				callback = function()
					map(
						{ "o", "x" },
						"iC",
						"<cmd>lua require('various-textobjs').mdFencedCodeBlock(true)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "inner fenced code block" }
					)
					map(
						{ "o", "x" },
						"aC",
						"<cmd>lua require('various-textobjs').mdFencedCodeBlock(false)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "around fenced code block" }
					)
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = augroup("various_textobjs_css_selector"),
				pattern = {
					"css",
					"scss",
				},
				callback = function()
					map(
						{ "o", "x" },
						"ic",
						"<cmd>lua require('various-textobjs').cssSelector(true)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "inner css selector" }
					)
					map(
						{ "o", "x" },
						"ac",
						"<cmd>lua require('various-textobjs').cssSelector(false)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "around css selector" }
					)
				end,
			})
			vim.api.nvim_create_autocmd("FileType", {
				group = augroup("various_textobjs_html_attribute"),
				pattern = {
					"html",
					"xml",
					"css",
					"scss",
					"vue",
				},
				callback = function()
					map(
						{ "o", "x" },
						"ix",
						"<cmd>lua require('various-textobjs').htmlAttribute(true)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "inner html attribute" }
					)
					map(
						{ "o", "x" },
						"ax",
						"<cmd>lua require('various-textobjs').htmlAttribute(false)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "around html attribute" }
					)
				end,
			})
			vim.api.nvim_create_autocmd("FileType", {
				group = augroup("various_textobjs_double_square_brackets"),
				pattern = {
					"markdown",
					"lua",
					"sh",
					"zsh",
					"bash",
					"fish",
					"neorg",
				},
				callback = function()
					map(
						{ "o", "x" },
						"iD",
						"<cmd>lua require('various-textobjs').doubleSquareBrackets(true)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "inner double square brackets" }
					)
					map(
						{ "o", "x" },
						"aD",
						"<cmd>lua require('various-textobjs').doubleSquareBrackets(false)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "around double square brackets" }
					)
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = augroup("various_textobjs_shell_pipe"),
				pattern = {
					"sh",
					"zsh",
					"bash",
					"fish",
				},
				callback = function()
					map(
						{ "o", "x" },
						"iP",
						"<cmd>lua require('various-textobjs').shellPipe(true)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "inner shell pipe" }
					)
					map(
						{ "o", "x" },
						"aP",
						"<cmd>lua require('various-textobjs').shellPipe(false)<CR>",
						{ buffer = true, noremap = true, silent = true, desc = "around shell pipe" }
					)
				end,
			})
		end,
		opts = {
			useDefaultKeymaps = false,
		},
	},
	{
		"echasnovski/mini.ai",
		enabled = true,
		event = { "BufReadPost", "BufNewFile" },
		depenencies = {
			"nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			local spec_treesitter = require("mini.ai").gen_spec.treesitter
			local custom_textobj = {}
			for key, val in pairs(custom_textobjects) do
				custom_textobj[key] = spec_treesitter(val)
			end

			require("mini.ai").setup({
				-- Table with textobject id as fields, textobject specification as values.
				-- Also use this to disable builtin textobjects. See |MiniAi.config|.
				custom_textobjects = custom_textobj,

				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					-- Main textobject prefixes
					around = "a",
					inside = "i",
					-- Next/last variants
					around_next = "an",
					inside_next = "in",
					around_last = "al",
					inside_last = "il",

					-- Move cursor to corresponding edge of `a` textobject
					goto_left = "g[",
					goto_right = "g]",
				},

				-- Number of lines within which textobject is searched
				n_lines = 50,

				-- How to search for object (first inside current line, then inside
				-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
				-- 'cover_or_nearest', 'next', 'previous', 'nearest'.
				search_method = "cover_or_next",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPost", "BufNewFile" },
	},
	custom_textobjects = custom_textobjects,
}
