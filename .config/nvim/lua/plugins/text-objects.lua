return {
	{
		"kiyoon/treesitter-indent-object.nvim",
		depenencies = {
			"lukas-reineke/indent-blankline.nvim",
		},
		init = function()
			vim.keymap.set(
				{ "x", "o" },
				"ai",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>"
			)
			vim.keymap.set(
				{ "x", "o" },
				"aI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>"
			)
			vim.keymap.set(
				{ "x", "o" },
				"ii",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>"
			)
			vim.keymap.set(
				{ "x", "o" },
				"iI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>"
			)
		end,
	},
	{

		"chrisgrieser/nvim-various-textobjs",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("various-textobjs").setup({
				-- useDefaultKeymaps = true,
			})
			local innerOuterMaps = {
				number = "n",
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
			}
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
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPost", "BufNewFile" },
	},
}
