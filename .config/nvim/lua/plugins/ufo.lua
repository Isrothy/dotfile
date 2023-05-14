local M = {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	event = { "BufReadPost", "BufNewFile" },
	lazy = false,
	enabled = true,
	-- event = "User isfolded",
}

-- M.init = function()
-- 	local fn = vim.fn
-- 	local fastfoldtimer
-- 	fastfoldtimer = fn.timer_start(2000, function()
-- 		if #fn.filter(fn.range(1, fn.line("$")), "foldlevel(v:val)>0") > 0 then
-- 			vim.cmd("doautocmd User isfolded")
-- 			fn.timer_stop(fastfoldtimer)
-- 		end
-- 	end, { ["repeat"] = -1 })
-- end


M.opts = {
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
	fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = (" 󰦸 %d "):format(endLnum - lnum)
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
	end,
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
}

M.config = function(_, opts)
	require("ufo").setup(opts)

	vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
	vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
	vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
	vim.keymap.set("n", "gf", require("ufo").peekFoldedLinesUnderCursor)
end

return M
