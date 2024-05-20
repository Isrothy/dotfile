local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = augroup("terminal_config"),
	callback = function()
		vim.wo.statuscolumn = ""
		vim.wo.colorcolumn = ""
		vim.wo.sidescrolloff = 0
		vim.wo.scrolloff = 0
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.foldcolumn = "0"
		vim.wo.foldmethod = "manual"
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
			return
		end
		vim.b[buf].last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- create cc according to filetype
local cc_filetypes = {
	c = "101",
	cpp = "101",
	java = "101",
	javascript = "101",
	javascriptreact = "101",
	kotlin = "101",
	lua = "121",
	typescript = "101",
	typescriptreact = "101",
	rust = "101",
	haskell = "101",
	swift = "101",
	markdown = "81",
}
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("colorcolumn", { clear = true }),
	callback = function(event)
		local filetype = event.match
		if cc_filetypes[filetype] then
			vim.wo.colorcolumn = cc_filetypes[filetype]
		else
			vim.wo.colorcolumn = ""
		end
	end,
})

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

-- large file
vim.api.nvim_create_autocmd({ "BufReadPre" }, {
	group = vim.api.nvim_create_augroup("large_buf", { clear = true }),
	pattern = "*",
	callback = function()
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
		if ok and stats and (stats.size > 1024 * 1024) then
			vim.b.large_buf = true
			vim.cmd("syntax off")
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.spell = false
			vim.opt_local.list = false
			vim.b.matchup_matchparen_fallback = 0
			vim.b.matchup_matchparen_enabled = 0
			local status_ok, ts_config = pcall(require, "nvim-treesitter.configs")
			if not status_ok then
				return
			end
			local disable_cb = function(_, buf)
				local success, detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
				return success and detected
			end
			for _, mod_name in ipairs(ts_config.available_modules()) do
				local module_config = ts_config.get_module(mod_name) or {}
				local old_disabled = module_config.disable
				module_config.disable = function(lang, buf)
					return disable_cb(lang, buf)
						or (type(old_disabled) == "table" and vim.tbl_contains(old_disabled, lang))
						or (type(old_disabled) == "function" and old_disabled(lang, buf))
				end
			end
			vim.notify("Large buffer detected", "warn")
			vim.api.nvim_exec_autocmds("User", {
				pattern = "LargeBuf",
			})
		else
			vim.b.large_buf = false
		end
	end,
})
