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
		enabled = false,
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
			local keymap = vim.keymap.set
			local innerOuterMaps = {
				value = "v",
				key = "k",
				subword = "S", -- lowercase taken for sentence textobj
			}
			local oneMaps = {
				lineCharacterwise = "_",
				toNextClosingBracket = "%", -- since this is basically a more intuitive version of the standard "%" motion-as-textobj
				restOfParagraph = "r",
				restOfIndentation = "R",
				diagnostic = "!",
				column = "|",
				entireBuffer = "gG", -- G + gg
				url = "L", -- gu, gU, and U would conflict with gugu, gUgU, and gUU. u would conflict with gcu (undo comment)
			}
			local ftMaps = {
				{
					map = { mdlink = "l" },
					fts = { "markdown", "toml" },
				},
				{
					map = { mdFencedCodeBlock = "C" },
					fts = { "markdown" },
				},
				{
					map = { doubleSquareBrackets = "D" },
					fts = { "lua", "norg", "sh", "fish", "zsh", "bash", "markdown" },
				},
				{
					map = { cssSelector = "c" },
					fts = { "css", "scss" },
				},
				{
					map = { shellPipe = "P" },
					fts = { "sh", "bash", "zsh", "fish" },
				},
				{
					map = { htmlAttribute = "x" },
					fts = { "html", "css", "scss", "xml" },
				},
			}
			keymap(
				{ "o", "x" },
				"ii",
				"<cmd>lua require('various-textobjs').indentation(true, true)<CR>",
				{ noremap = true, desc = "inner-inner indentation textobj" }
			)
			keymap(
				{ "o", "x" },
				"ai",
				"<cmd>lua require('various-textobjs').indentation(false, true)<CR>",
				{ noremap = true, desc = "outer-inner indentation textobj" }
			)
			keymap(
				{ "o", "x" },
				"iI",
				"<cmd>lua require('various-textobjs').indentation(true, true)<CR>",
				{ noremap = true, desc = "inner-inner indentation textobj" }
			)
			keymap(
				{ "o", "x" },
				"aI",
				"<cmd>lua require('various-textobjs').indentation(false, false)<CR>",
				{ noremap = true, desc = "outer-outer indentation textobj" }
			)

			for objName, map in pairs(innerOuterMaps) do
				local name = " " .. objName .. " textobj"
				keymap(
					{ "o", "x" },
					"a" .. map,
					"<cmd>lua require('various-textobjs')." .. objName .. "(true)<CR>",
					{ noremap = true, desc = "outer" .. name }
				)
				keymap(
					{ "o", "x" },
					"i" .. map,
					"<cmd>lua require('various-textobjs')." .. objName .. "(false)<CR>",
					{ noremap = true, desc = "inner" .. name }
				)
			end
			for objName, map in pairs(oneMaps) do
				keymap(
					{ "o", "x" },
					map,
					"<cmd>lua require('various-textobjs')." .. objName .. "()<CR>",
					{ noremap = true, desc = objName .. " textobj" }
				)
			end

			vim.api.nvim_create_augroup("VariousTextobjs", {})
			for _, textobj in pairs(ftMaps) do
				vim.api.nvim_create_autocmd("FileType", {
					group = "VariousTextobjs",
					pattern = textobj.fts,
					callback = function()
						for objName, map in pairs(textobj.map) do
							local name = " " .. objName .. " textobj"
							keymap({ "o", "x" }, "a" .. map, function()
								require("various-textobjs")[objName](false)
							end, { noremap = true, desc = "outer" .. name, buffer = true })
							keymap({ "o", "x" }, "i" .. map, function()
								require("various-textobjs")[objName](true)
							end, { noremap = true, desc = "inner" .. name, buffer = true })
						end
					end,
				})
			end
		end,

		config = function()
			require("various-textobjs").setup({
				useDefaultKeymaps = false,
			})
		end,
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
