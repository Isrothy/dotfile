local map = vim.keymap.set

local default_options = { noremap = true, silent = true }
local expr_options = { expr = true, silent = true }

map({ "n", "x" }, "<Space>", "<Nop>", default_options)
map({ "n", "x", "i", "c", "t" }, "<F1>", "<Nop>", default_options)
vim.g.mapleader = " "

map(
	"n",
	"gO",
	"<cmd>call append(line('.') -1, repeat([''], v:count1))<cr>",
	{ desc = "append line before", noremap = true }
)
map(
	"n",
	"go",
	"<cmd>call append(line('.'),   repeat([''], v:count1))<cr>",
	{ desc = "append line after", noremap = true }
)

-- map("v", "<", "<gv", default_options)
-- map("v", ">", ">gv", default_options)
-- map("x", "K", ":move '<-2<CR>gv-gv", default_options)
-- map("x", "J", ":move '>+1<CR>gv-gv", default_options)

map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

map("x", "g/", "<esc>/\\%V", {
	silent = false,
	noremap = true,
	desc = "Search inside visual selection",
})
map("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"', {
	expr = true,
	replace_keycodes = false,
	noremap = true,
	desc = "Visually select changed text",
})

map("n", "<leader>o", "<C-o>", default_options)
map("n", "<leader>i", "<C-i>", default_options)

map("n", "<C-v>", "<C-w>v", default_options)
map("n", "<C-s>", "<C-w>s", default_options)
map("n", "<C-c>", "<C-w>c", default_options)
map("t", "<esc>", [[<C-\><C-n>]], default_options)
-- map("n", "<C-,>", "<C-w><", default_options)
-- map("n", "<C-.>", "<C-w>>", default_options)
-- map("n", "<C-=>", "<C-w>+", default_options)
-- map("n", "<C-->", "<C-w>-", default_options)

map("n", "<C-o>", "<C-w>o", default_options)
map("n", "<esc>", ":nohlsearch<cr>", default_options)

map({ "i", "c", "t" }, "<M-h>", "<Left>", { noremap = false, desc = "Left" })
map({ "i", "c", "t" }, "<M-j>", "<Down>", { noremap = false, desc = "Down" })
map({ "i", "c", "t" }, "<M-k>", "<Up>", { noremap = false, desc = "Up" })
map({ "i", "c", "t" }, "<M-l>", "<Right>", { noremap = false, desc = "Right" })

map("n", "<leader>qd", vim.diagnostic.setqflist, { noremap = true, silent = true, desc = "Quickfix diagnostics" })
map("n", "<leader>ld", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Local diagnostics" })
map("n", "<leader>cd", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Current line diagnostics" })

map("x", ".", ":norm .<CR>", default_options)
map("x", "@", ":norm @q<CR>", default_options)

map(
	"n",
	"<leader>yr",
	":call setreg('+', getreg('@'))<CR>",
	{ noremap = true, silent = true, desc = "Paste register to system clipboard" }
)
map("n", "<leader>yp", ":call setreg('+', expand('%:.') .. ':' .. line('.'))<CR>", {
	noremap = true,
	silent = true,
	desc = "Paste filename and line number to system clipboard",
})

vim.cmd([[
cnoreabbrev W! w!
cnoreabbrev W1 w!
cnoreabbrev w1 w!
cnoreabbrev Q! q!
cnoreabbrev Q1 q!
cnoreabbrev q1 q!
cnoreabbrev Qa! qa!
cnoreabbrev Qall! qall!
cnoreabbrev Wa wa
cnoreabbrev Wq wq
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev wq1 wq!
cnoreabbrev Wq1 wq!
cnoreabbrev wQ1 wq!
cnoreabbrev WQ1 wq!
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Qall qall
]])
