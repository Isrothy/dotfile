local opt = vim.opt
local o = vim.o
local g = vim.g

g.compatible = 0
opt.termguicolors = true

opt.mouse = ""
opt.syntax = "on"
opt.cmdheight = 0
opt.laststatus = 3
opt.showcmd = true
opt.cursorline = true
opt.number = true
opt.relativenumber = true
o.pumheight = 10
opt.swapfile = false
opt.undofile = true

opt.nrformats = { "alpha", "bin", "octal", "hex" }

o.matchpairs = vim.o.matchpairs .. ",<:>"

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
opt.wrap = false
opt.linebreak = true
-- opt.textwidth = 0
-- opt.wrapmargin =40
opt.scrolloff = 5
opt.sidescrolloff = 40
opt.history = 2000
opt.ttimeoutlen = 0
opt.belloff = "all"
opt.conceallevel = 0
opt.updatetime = 500
opt.wildmenu = true
opt.scrollback = 2000

o.whichwrap = vim.o.whichwrap .. "<,>,h,l"
o.splitkeep = "screen"

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

-- hearch settings
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.gp = "rg"

g.html_indent_autotags = "html,head,body"
g.markdown_recommended_style = 0

--------- fold -----------
-- local function get_custom_foldtxt_suffix(foldstart)
-- 	local fold_suffix_str = string.format("  %s [%s lines]", "┉", vim.v.foldend - foldstart + 1)
--
-- 	return { fold_suffix_str, "Folded" }
-- end
--
-- local function get_custom_foldtext(foldtxt_suffix, foldstart)
-- 	local line = vim.api.nvim_buf_get_lines(0, foldstart - 1, foldstart, false)[1]
--
-- 	return {
-- 		{ line, "Normal" },
-- 		foldtxt_suffix,
-- 	}
-- end
--
-- _G.get_foldtext = function()
-- 	local foldstart = vim.v.foldstart
-- 	local ts_foldtxt = vim.treesitter.foldtext()
-- 	local foldtxt_suffix = get_custom_foldtxt_suffix(foldstart)
--
-- 	if type(ts_foldtxt) == "string" then
-- 		return get_custom_foldtext(foldtxt_suffix, foldstart)
-- 	else
-- 		table.insert(ts_foldtxt, foldtxt_suffix)
-- 		return ts_foldtxt
-- 	end
-- end

o.foldlevelstart = 99
o.foldenable = true
opt.foldcolumn = "1"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.get_foldtext()"
opt.foldmethod = "expr"
--------- end fold ----------
