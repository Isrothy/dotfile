local opt = vim.opt
local g = vim.g

opt.autoindent = true
opt.autoread = true
opt.backspace = { "indent", "eol", "start" }
opt.belloff = "all"
opt.cdhome = true
opt.cindent = true
opt.cinoptions = "g0,(0,l1,n-2"
opt.cmdheight = 1
opt.conceallevel = 0
opt.confirm = true
opt.cursorline = true
opt.cursorlineopt = "number,line"
opt.expandtab = true
opt.fillchars = {
  vert = "│",
  eob = " ",
  diff = "╱",
  msgsep = "‾",
  fold = "⠀",
  foldopen = "▼",
  foldsep = " ",
  foldclose = "▶",
}
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldtext = "v:lua.get_foldtext()"
opt.grepprg = "rg"
opt.hidden = true
opt.history = 2000
opt.ignorecase = true
opt.incsearch = true
opt.jumpoptions = "stack,view"
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.listchars = {
  trail = "·",
  tab = "→ ",
}
opt.mouse = ""
opt.nrformats = { "alpha", "bin", "octal", "hex" }
opt.number = true
opt.pumheight = 10
opt.relativenumber = true
opt.scrollback = 2000
opt.scrolloff = 8
opt.sessionoptions = {
  "buffers",
  "curdir",
  "folds",
  "folds",
  "globals",
  "help",
  "winsize",
  "skiprtp",
  "tabpages",
  "winpos",
}
opt.shiftwidth = 4
opt.showcmd = false
opt.sidescrolloff = 16
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.smoothscroll = true
opt.softtabstop = -1
opt.splitbelow = true
opt.splitright = false
opt.swapfile = false
opt.syntax = "on"
opt.tabstop = 4
opt.ttimeoutlen = 0
opt.undofile = true
opt.updatetime = 500
opt.virtualedit = "block"
opt.virtualedit = { "block", "onemore" }
opt.whichwrap = vim.o.whichwrap .. "<,>,h,l"
opt.wildmenu = true
opt.winborder = "rounded"
opt.wrap = false

g.html_indent_autotags = "html,head,body"
g.markdown_recommended_style = 0

g.mapleader = " "
g.maplocalleader = "\\"
