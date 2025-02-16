local opt = vim.opt
local g = vim.g

opt.mouse = ""
opt.syntax = "on"

opt.cmdheight = 0
opt.laststatus = 3
opt.showcmd = true
opt.cursorline = true
opt.cursorlineopt = "number,screenline"
opt.number = true
opt.relativenumber = true
opt.pumheight = 10
opt.splitbelow = true
opt.splitright = false

opt.swapfile = false
opt.undofile = true

opt.nrformats = { "alpha", "bin", "octal", "hex" }

opt.fillchars = {
  vert = "│",
  eob = " ", -- suppress ~ at EndOfBuffer
  diff = "╱", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  fold = "⠀",
  foldopen = "▼",
  foldsep = " ",
  foldclose = "▶",
}

opt.virtualedit = { "block", "onemore" }
opt.whichwrap = vim.o.whichwrap .. "<,>,h,l"
opt.wrap = false
opt.linebreak = true
-- opt.textwidth = 0
-- opt.wrapmargin =40
opt.scrolloff = 8
opt.smoothscroll = true
opt.sidescrolloff = 16
opt.signcolumn = "yes"

opt.history = 2000
opt.ttimeoutlen = 0
opt.belloff = "all"
opt.conceallevel = 0
opt.updatetime = 500
opt.wildmenu = true
opt.scrollback = 2000
opt.jumpoptions = "stack,view"

opt.autoread = true
opt.confirm = true
opt.hidden = true

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

opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.expandtab = true
opt.smarttab = true
opt.tabstop = 4
opt.softtabstop = -1
opt.shiftwidth = 4
opt.cinoptions = "g0,(0,l1,n-2"
opt.backspace = { "indent", "eol", "start" }

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.gp = "rg"

opt.foldlevelstart = 99
opt.foldenable = true
opt.foldcolumn = "1"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = "v:lua.get_foldtext()"
opt.foldmethod = "expr"

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

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  ---@diagnostic disable-next-line: inject-field
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
