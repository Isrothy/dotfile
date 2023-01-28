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
		-- lazy = true,
		-- keys = {
		-- 	{ "iN", mode = { "x", "o" }, desc = "inner number textobj" },
		-- 	{ "aN", mode = { "x", "o" }, desc = "outer number textobj" },
		-- 	{ "iv", mode = { "x", "o" }, desc = "inner value textobj" },
		-- 	{ "av", mode = { "x", "o" }, desc = "outer value textobj" },
		-- 	{ "ik", mode = { "x", "o" }, desc = "innver key textobj" },
		-- 	{ "ak", mode = { "x", "o" }, desc = "outer key textobj" },
		-- 	{ "iS", mode = { "x", "o" }, desc = "inner subword textobj" },
		-- 	{ "aS", mode = { "x", "o" }, desc = "outer subword textobj" },
		-- 	{ "n", mode = { "x", "o" }, desc = "nearEol textobj" },
		-- 	{ "r", mode = { "x", "o" }, desc = "restOfParagraph textobj" },
		-- 	{ "!", mode = { "x", "o" }, desc = "diagnostic textobj" },
		-- 	{ "|", mode = { "x", "o" }, desc = "column textobj" },
		-- 	{ "gG", mode = { "x", "o" }, desc = "entireBuffer textobj" },
		-- 	{ "L", mode = { "x", "o" }, desc = "url textobj" },
		-- },
		init = function()
			local ftMaps = {
				{
					map = { jsRegex = "/" },
					fts = { "javascript", "typescript" },
				},
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
			}
			local keymap = vim.keymap.set
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
							end, { desc = "outer" .. name, buffer = true })
							keymap({ "o", "x" }, "i" .. map, function()
								require("various-textobjs")[objName](true)
							end, { desc = "inner" .. name, buffer = true })
						end
					end,
				})
			end
		end,

		config = function()
			require("various-textobjs").setup({
				useDefaultKeymaps = false,
			})
			local innerOuterMaps = {
				number = "N",
				value = "v",
				key = "k",
				subword = "S",
			}
			local oneMaps = {
				nearEoL = "n",
				restOfParagraph = "r",
				diagnostic = "!",
				column = "|",
				entireBuffer = "gG",
				url = "L", -- uppercase to avoid conflict with some comments plugin mapping `u` to comments textobjs for undoing
			}
			local keymap = vim.keymap.set
			for objName, map in pairs(innerOuterMaps) do
				local name = " " .. objName .. " textobj"
				keymap({ "o", "x" }, "a" .. map, function()
					require("various-textobjs")[objName](false)
				end, { desc = "outer" .. name })
				keymap({ "o", "x" }, "i" .. map, function()
					require("various-textobjs")[objName](true)
				end, { desc = "inner" .. name })
			end
			for objName, map in pairs(oneMaps) do
				keymap({ "o", "x" }, map, require("various-textobjs")[objName], { desc = objName .. " textobj" })
			end
		end,
	},
	{
		"echasnovski/mini.ai",
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
