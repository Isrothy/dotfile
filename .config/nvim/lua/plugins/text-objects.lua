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
			vim.keymap.set(
				{ "x", "o" },
				"ai",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>",
				{ noremap = true, silent = true, desc = "context-aware indent" }
			)
			vim.keymap.set(
				{ "x", "o" },
				"aI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>",
				{ noremap = true, silent = true, desc = "entire-line indent" }
			)
			vim.keymap.set(
				{ "x", "o" },
				"ii",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>",
				{ noremap = true, silent = true, desc = "inner block" }
			)
			vim.keymap.set(
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
			local map = vim.keymap.set

			map({ "o", "x" }, "ii", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
			map({ "o", "x" }, "ai", "<cmd>lua require('various-textobjs').indentation(false, true)<CR>")
			map({ "o", "x" }, "iI", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
			map({ "o", "x" }, "aI", "<cmd>lua require('various-textobjs').indentation(false, false)<CR>")

			map({ "o", "x" }, "R", "<cmd>lua require('various-textobjs').restOfIdentation()<CR>")

			map({ "o", "x" }, "iS", "<cmd>lua require('various-textobjs').subword(true)<CR>")
			map({ "o", "x" }, "aS", "<cmd>lua require('various-textobjs').subword(false)<CR>")

			map({ "o", "x" }, "%", "<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>")
			map({ "o", "x" }, "Q", "<cmd>lua require('various-textobjs').toNextQuotationMark()<CR>")

			map({ "o", "x" }, "r", "<cmd>lua require('various-textobjs').restOfParagraph()<CR>")

			map({ "o", "x" }, "gG", "<cmd>lua require('various-textobjs').entireBuffer()<CR>")

			map({ "o", "x" }, "\\", "<cmd>lua require('various-textobjs').nearEoL()<CR>")

			map({ "o", "x" }, "i_", "<cmd>lua require('various-textobjs').lineCharacterwise(true)<CR>")
			map({ "o", "x" }, "a_", "<cmd>lua require('various-textobjs').lineCharacterwise(false)<CR>")

			map({ "o", "x" }, "|", "<cmd>lua require('various-textobjs').column()<CR>")

			map({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value(true)<CR>")
			map({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value(false)<CR>")

			map({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key(true)<CR>")
			map({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key(false)<CR>")

			map({ "o", "x" }, "L", "<cmd>lua require('various-textobjs').url()<CR>")

			map({ "o", "x" }, "i.", "<cmd>lua require('various-textobjs').number(true)<CR>")
			map({ "o", "x" }, "a.", "<cmd>lua require('various-textobjs').number(false)<CR>")

			map({ "o", "x" }, "!", "<cmd>lua require('various-textobjs').diagnostic()<CR>")

			map({ "o", "x" }, "iz", "<cmd>lua require('various-textobjs').closedFold(true)<CR>")
			map({ "o", "x" }, "az", "<cmd>lua require('various-textobjs').closedFold(false)<CR>")

			map({ "o", "x" }, "im", "<cmd>lua require('various-textobjs').chainMember(true)<CR>")
			map({ "o", "x" }, "am", "<cmd>lua require('various-textobjs').chainMember(false)<CR>")

			map({ "o", "x" }, "gw", "<cmd>lua require('various-textobjs').visibleInWindow()<CR>")
			map({ "o", "x" }, "gW", "<cmd>lua require('various-textobjs').restOfWindow()<CR>")

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
					map({ "o", "x" }, "il", "<cmd>lua require('various-textobjs').mdlink(true)<CR>", { buffer = true })
					map({ "o", "x" }, "al", "<cmd>lua require('various-textobjs').mdlink(false)<CR>", { buffer = true })
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
						{ buffer = true }
					)
					map(
						{ "o", "x" },
						"aC",
						"<cmd>lua require('various-textobjs').mdFencedCodeBlock(false)<CR>",
						{ buffer = true }
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
						{ buffer = true }
					)
					map(
						{ "o", "x" },
						"ac",
						"<cmd>lua require('various-textobjs').cssSelector(false)<CR>",
						{ buffer = true }
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
						{ buffer = true }
					)
					map(
						{ "o", "x" },
						"ax",
						"<cmd>lua require('various-textobjs').htmlAttribute(false)<CR>",
						{ buffer = true }
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
						{ buffer = true }
					)
					map(
						{ "o", "x" },
						"aD",
						"<cmd>lua require('various-textobjs').doubleSquareBrackets(false)<CR>",
						{ buffer = true }
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
						{ buffer = true }
					)
					map(
						{ "o", "x" },
						"aP",
						"<cmd>lua require('various-textobjs').shellPipe(false)<CR>",
						{ buffer = true }
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
		enabled = true,
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"Julian/vim-textobj-variable-segment",
		enabled = false,
		dependencies = {
			"kana/vim-textobj-user",
		},
		event = { "BufReadPost", "BufNewFile" },
	},
	custom_textobjects = custom_textobjects,
}
