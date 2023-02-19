vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		local file = vim.loop.fs_realpath(event.match) or event.match

		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		local backup = vim.fn.fnamemodify(file, ":p:~:h")
		backup = backup:gsub("[/\\]", "%%")
		vim.go.backupext = backup
	end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	callback = function()
		vim.wo.statuscolumn = ""
		vim.wo.colorcolumn = ""
	end,
})

-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- 	group = vim.api.nvim_create_augroup("ScrollEOF", { clear = true }),
-- 	pattern = "*",
-- 	callback = function()
-- 		local filetype = vim.bo.filetype
-- 		local ignore_filetype = {
-- 			"quickfix",
-- 			"nofile",
-- 			"help",
-- 			"terminal",
-- 			"toggleterm",
-- 			"",
-- 		}
-- 		if vim.tbl_contains(ignore_filetype, filetype) then
-- 			return
-- 		end
-- 		local win_height = vim.api.nvim_win_get_height(0)
-- 		local win_view = vim.fn.winsaveview()
-- 		local scrolloff = math.min(vim.o.scrolloff, math.floor(win_height / 2))
-- 		local scrolloff_line_count = win_height - (vim.fn.line("w$") - win_view.topline + 1)
-- 		local distance_to_last_line = vim.fn.line("$") - win_view.lnum
--
-- 		if distance_to_last_line < scrolloff and scrolloff_line_count + distance_to_last_line < scrolloff then
-- 			win_view.topline = win_view.topline + scrolloff - (scrolloff_line_count + distance_to_last_line)
-- 			vim.fn.winrestview(win_view)
-- 		end
-- 	end,
-- })
