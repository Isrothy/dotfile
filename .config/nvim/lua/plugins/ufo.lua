local M = {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		"nvim-treesitter/nvim-treesitter",
	},
	-- event = "BufReadPre",
	-- event = "BufRead",
	-- event = "BufReadPost",
	enabled = false,
	lazy = false,
}

M.config = function()
	local handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = ("  %d "):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end

	require("ufo").setup({
		-- provider_selector = function(bufnr, filetype, buftype)
		-- 	return { "treesitter", "indent" }
		-- end,
		fold_virt_text_handler = handler,
		enable_get_fold_end_virt_text = true,
		preview = {

			win_config = {
				border = "none",
				winhighlight = "Normal:Folded",
				winblend = 0,
			},
			mappings = {
				scrollB = "<C-b>",
				scrollF = "<C-f>",
				scrollU = "<C-u>",
				scrollD = "<C-d>",
			},
		},
	})

	vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
	vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
	vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
	vim.keymap.set("n", "gf", require("ufo").peekFoldedLinesUnderCursor)

	function _G.nN(c)
		local ok, msg = pcall(vim.cmd, "norm!" .. vim.v.count1 .. c)
		if not ok then
			vim.api.nvim_echo({ { msg:match(":(.*)$"), "ErrorMsg" } }, false, {})
			return
		end
		require("hlslens").start()
		require("ufo").peekFoldedLinesUnderCursor()
	end

	vim.api.nvim_set_keymap("n", "n", '<Cmd>lua _G.nN("n")<CR>', {})
	vim.api.nvim_set_keymap("n", "N", '<Cmd>lua _G.nN("N")<CR>', {})
end

return M
