vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.syntax = "on"
vim.opt.cmdheight = 0
vim.opt.showcmd = true
vim.opt.cursorline = true

vim.o.pumheight = 10

--fold
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- vim.opt.foldmethod = "syntax"
-- vim.opt.foldmethod = "manual"
-- vim.opt.foldmethod = "indent"
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:folddashes.substitute(getline(v:foldstart),'/\\*\\|\\*/\\|{{{\\d\\=','','g')"

vim.opt.undofile = true

vim.opt.nrformats = { "alpha", "bin", "octal", "hex" }

vim.o.matchpairs = vim.o.matchpairs .. ",<:>"
vim.o.whichwrap = vim.o.whichwrap .. "<,>,h,l"
vim.o.splitkeep = "screen"

vim.opt.fillchars = {
	vert = "│",
	eob = " ", -- suppress ~ at EndOfBuffer
	diff = "╱", -- alternatives = ⣿ ░ ─ ╱
	msgsep = "‾",
	fold = "⠀",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}

vim.opt.virtualedit = { "block", "onemore" }
vim.opt.wrap = true
vim.opt.linebreak = true
-- vim.opt.textwidth = 0
-- vim.opt.wrapmargin =40
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 30
vim.opt.history = 2000
vim.opt.ttimeoutlen = 0
vim.opt.belloff = "all"
vim.opt.conceallevel = 0
vim.opt.updatetime = 500
vim.opt.wildmenu = true

-- vim.opt.spell = true
-- vim.opt.spelllang = { 'en_us' }
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- buffer settings
vim.opt.autoread = true
vim.opt.confirm = true
vim.opt.hidden = true

-- coding settings
vim.opt.encoding = "utf-8"
vim.opt.termencoding = "utf-8"

--session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

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

vim.opt.laststatus = 3

vim.opt.gp = "rg"

-- hearch settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.html_indent_autotags = "html,head,body"
