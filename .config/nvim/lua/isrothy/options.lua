local opt = vim.opt
local g = vim.g

g.compatible = 0
opt.termguicolors = true

---Neovide options
g.neovide_input_macos_option_key_is_meta = "both"
g.neovide_underline_stroke_scale = 3
g.neovide_floating_shadow = false
g.neovide_transparency = 1
g.neovide_window_blurred = true
g.neovide_floating_blur_amount_x = 2.0
g.neovide_floating_blur_amount_y = 2.0
g.neovide_show_border = true
g.neovide_touch_deadzone = 6.0
g.neovide_cursor_animate_command_line = false
g.neovide_cursor_smooth_blink = true

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
