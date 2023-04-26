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
		vim.wo.sidescrolloff = 0
		vim.wo.scrolloff = 0
	end,
})

-- local cc_filetypes = {
-- 	c = "101",
-- 	cpp = "101",
-- 	java = "101",
-- 	javascript = "101",
-- 	javascriptreact = "101",
-- 	kotlin = "101",
-- 	lua = "121",
-- 	typescript = "101",
-- 	typescriptreact = "101",
-- 	rust = "101",
-- 	swift = "101",
-- }
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	group = vim.api.nvim_create_augroup("colorcolumn", { clear = true }),
-- 	callback = function(event)
-- 		local filetype = event.match
-- 		if cc_filetypes[filetype] then
-- 			vim.wo.colorcolumn = cc_filetypes[filetype]
-- 		else
-- 			vim.wo.colorcolumn = ""
-- 		end
-- 	end,
-- })

-- local wrap_filetypes = {
-- 	"markdown",
-- 	"latex",
-- 	"text",
-- }
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	group = vim.api.nvim_create_augroup("wrap", { clear = true }),
-- 	callback = function(event)
-- 		local filetype = event.match
-- 		if vim.tbl_contains(wrap_filetypes, filetype) then
-- 			vim.wo.wrap = true
-- 			vim.wo.linebreak = true
-- 		else
-- 			vim.wo.wrap = false
-- 			vim.wo.linebreak = false
-- 		end
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- 	group = vim.api.nvim_create_augroup("ScrollEOF", { clear = true }),
-- 	pattern = "*",
--- 	callback = function()
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
