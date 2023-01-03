HOME = os.getenv("HOME")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("options")
require("mappings")
require("autocmd")
require("usercmd")
require("lazy_plugin")

vim.cmd([[
if exists("g:neovide")
	" set guifont=Fira\ Code:h15
	let g:neovide_input_macos_alt_is_meta = v:true
	let g:neovide_cursor_vfx_mode = "railgun"
endif
]])
