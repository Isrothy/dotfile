local map = function(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

local default_options = { noremap = true, silent = true }
local expr_options = { expr = true, silent = true }

map({ "n", "x" }, "<Space>", "<Nop>")
map({ "n", "x", "i", "c", "t" }, "<f1>", "<nop>")
map({ "n", "x", "i", "c" }, "<c-z>", "<nop>")
vim.g.mapleader = " "

map("n", "gO", "<cmd>call append(line('.') -1, repeat([''], v:count1))<cr>", { desc = "append line before" })
map("n", "go", "<cmd>call append(line('.'),   repeat([''], v:count1))<cr>", { desc = "append line after" })

map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

map("x", "g/", "<esc>/\\%V", {
    silent = false,
    desc = "Search inside visual selection",
})
map("n", "gV", "\"`[\" . strpart(getregtype(), 0, 1) . \"`]\"", {
    expr = true,
    replace_keycodes = false,
    desc = "Visually select changed text",
})

-- map("n", "<leader>o", "<C-o>", default_options)
-- map("n", "<leader>i", "<C-i>", default_options)

map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>wc", "<C-w>c", { desc = "Close window" })
map("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
-- map("n", "<leader>ws", "<C-w>s", default_options)
-- map("t", "<esc>", [[<C-\><C-n>]], default_options)
-- map("n", "<C-,>", "<C-w><", default_options)
-- map("n", "<C-.>", "<C-w>>", default_options)
-- map("n", "<C-=>", "<C-w>+", default_options)
-- map("n", "<C-->", "<C-w>-", default_options)

map("n", "<esc>", ":nohlsearch<cr>", default_options)

map({ "i", "c", "t" }, "<M-h>", "<Left>", { noremap = false, desc = "Left" })
map({ "i", "c", "t" }, "<M-j>", "<Down>", { noremap = false, desc = "Down" })
map({ "i", "c", "t" }, "<M-k>", "<Up>", { noremap = false, desc = "Up" })
map({ "i", "c", "t" }, "<M-l>", "<Right>", { noremap = false, desc = "Right" })

map("n", "<leader>xq", vim.diagnostic.setqflist, { desc = "Quickfix list" })
map("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Location list" })
map("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Current line" })

map("x", ".", ":norm .<CR>")
map("x", "@", ":norm @q<CR>")

map("n", "<leader>yr", ":call setreg('+', getreg('@'))<CR>", { desc = "Yank register to system clipboard" })
map(
    "n",
    "<leader>yp",
    ":call setreg('+', expand('%:.') .. ':' .. line('.'))<CR>",
    { desc = "Yank filename and line number to system clipboard" }
)

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
