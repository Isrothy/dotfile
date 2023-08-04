local opt = vim.opt
local o = vim.o
local g = vim.g

opt.termguicolors = true

opt.mouse = ""
opt.syntax = "on"
opt.cmdheight = 0
opt.showcmd = true
opt.cursorline = true
opt.number = true
opt.relativenumber = true

o.pumheight = 10

--fold
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
opt.foldcolumn = "1"
-- opt.foldmethod = "syntax"
-- opt.foldmethod = "manual"
-- opt.foldmethod = "indent"
-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- opt.foldtext = "v:folddashes.substitute(getline(v:foldstart),'/\\*\\|\\*/\\|{{{\\d\\=','','g')"

opt.undofile = true

opt.nrformats = { "alpha", "bin", "octal", "hex" }

o.matchpairs = vim.o.matchpairs .. ",<:>"
o.whichwrap = vim.o.whichwrap .. "<,>,h,l"
o.splitkeep = "screen"

opt.fillchars = {
	vert = "│",
	eob = " ", -- suppress ~ at EndOfBuffer
	diff = "╱", -- alternatives = ⣿ ░ ─ ╱
	msgsep = "‾",
	fold = "⠀",
	foldopen = "▼",
	-- foldsep = "│",
	foldsep = " ",
	foldclose = "▶",
}

opt.virtualedit = { "block", "onemore" }
opt.wrap = true
opt.linebreak = true
-- opt.textwidth = 0
-- opt.wrapmargin =40
opt.scrolloff = 5
opt.sidescrolloff = 30
opt.history = 2000
opt.ttimeoutlen = 0
opt.belloff = "all"
opt.conceallevel = 0
opt.updatetime = 500
opt.wildmenu = true

-- opt.spell = true
-- opt.spelllang = { 'en_us' }
opt.completeopt = { "menu", "menuone", "noselect" }

-- buffer settings
opt.autoread = true
opt.confirm = true
opt.hidden = true

-- coding settings
opt.encoding = "utf-8"

--session
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

-- indentation & format settings
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.expandtab = true
opt.smarttab = true
opt.tabstop = 4
opt.softtabstop = -1
opt.shiftwidth = 0
opt.cinoptions = "g0,(0,l1,n-2"
opt.backspace = { "indent", "eol", "start" }

opt.laststatus = 3

opt.gp = "rg"

opt.swapfile = false

-- hearch settings
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

g.html_indent_autotags = "html,head,body"
g.markdown_recommended_style = 0
