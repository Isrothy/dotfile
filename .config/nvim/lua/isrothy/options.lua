local opt = vim.opt
local g = vim.g

opt.autoindent = true
opt.autoread = true
opt.backspace = { "indent", "eol", "start" }
opt.belloff = "all"
opt.cindent = true
opt.cinoptions = "g0,(0,l1,n-2"
opt.cmdheight = 0
opt.conceallevel = 0
opt.confirm = true
opt.cursorline = true
opt.cursorlineopt = "number,screenline"
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
opt.gp = "rg"
opt.hidden = true
opt.history = 2000
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.jumpoptions = "stack,view"
opt.laststatus = 3
opt.linebreak = true
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
  "tabpages",
  "winsize",
  "folds",
  "help",
  "globals",
  "skiprtp",
  "terminal",
  "folds",
}
opt.shiftwidth = 4
opt.showcmd = true
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
opt.virtualedit = { "block", "onemore" }
opt.whichwrap = vim.o.whichwrap .. "<,>,h,l"
opt.wildmenu = true
opt.wrap = false

g.html_indent_autotags = "html,head,body"
g.markdown_recommended_style = 0

vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = { " ", " ", " ", " " },
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
