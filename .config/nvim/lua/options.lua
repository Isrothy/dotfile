vim.opt.termguicolors = true
vim.opt.syntax = "on"
vim.opt.mouse = ""
vim.opt.cmdheight = 0
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = -1
vim.o.foldenable = false
vim.o.foldopen = "block,mark,percent,quickfix,search,tag,undo"
vim.opt.foldmethod = "syntax"
-- vim.opt.foldmethod = "manual"
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.undofile = true
vim.opt.nrformats = { "alpha", "bin", "octal", "hex" }

vim.o.whichwrap = vim.o.whichwrap .. "<,>,h,l"
vim.o.matchpairs = vim.o.matchpairs .. ",<:>"
vim.o.splitkeep = "screen"

vim.opt.fillchars = {
	vert = "│",
	fold = "⠀",
	eob = " ", -- suppress ~ at EndOfBuffer
	diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.virtualedit = { "block", "onemore" }
vim.opt.sidescroll = 10
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6
vim.opt.history = 2000
vim.opt.ttimeoutlen = 0
vim.opt.belloff = "all"
vim.opt.conceallevel = 0
vim.opt.updatetime = 500
vim.opt.wildmenu = true
-- vim.opt.cc = "100"

-- vim.opt.spell = true
-- vim.opt.spelllang = { 'en_us' }
vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.undofile = true

-- buffer settings
vim.opt.autoread = true
vim.opt.confirm = true
vim.opt.hidden = true

-- coding settings
vim.opt.encoding = "utf-8"
vim.opt.termencoding = "utf-8"

-- vim.o.viewoptions = "word,cursor,folds,options"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- indentation & format settings
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 0
vim.opt.cinoptions = "g0,(0,l1"
vim.opt.backspace = { "indent", "eol", "start" }
vim.g.html_indent_autotags = "html,head,body"
vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 1
vim.g.wrap = true

vim.opt.laststatus = 3

vim.opt.gp = "rg"

-- hearch settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
