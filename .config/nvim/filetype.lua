vim.filetype.add({
	filename = {
		[".git/config"] = "gitconfig",
		[".swift-format"] = "json",
		[".clang-format"] = "yaml",
		["README$"] = function(path, bufnr)
			if string.find("#", vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)) then
				return "markdown"
			end
		end,
	},
})
