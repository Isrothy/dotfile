local map = vim.keymap.set

local default_options = { noremap = true, silent = true }
local expr_options = { expr = true, silent = true }

map({ "n", "v" }, "<Space>", "<Nop>", default_options)
vim.g.mapleader = " "

map("n", "gO", "<cmd>call append(line('.') -1, repeat([''], v:count1))<cr>", { desc = "append line before" })
map("n", "go", "<cmd>call append(line('.'),   repeat([''], v:count1))<cr>", { desc = "append line after" })

-- map("v", "<", "<gv", default_options)
-- map("v", ">", ">gv", default_options)
-- map("x", "K", ":move '<-2<CR>gv-gv", default_options)
-- map("x", "J", ":move '>+1<CR>gv-gv", default_options)

map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

map("n", "<C-v>", "<C-w>v", default_options)
map("n", "<C-s>", "<C-w>s", default_options)
map("n", "<C-c>", "<C-w>c", default_options)
map("n", "<C-o>", "<C-w>o", default_options)
map("n", "<C-,>", "<C-w><", default_options)
map("n", "<C-.>", "<C-w>>", default_options)
map("n", "<C-=>", "<C-w>+", default_options)
map("n", "<C-->", "<C-w>-", default_options)

map("n", "<esc>", ":nohlsearch<cr>", default_options)

map("t", "<esc>", [[<C-\><C-n>]], default_options)

-- map("i", "<M-h>", "<Left>", { noremap = false, desc = "Left" })
-- map("i", "<M-j>", "<Down>", { noremap = false, desc = "Down" })
-- map("i", "<M-k>", "<Up>", { noremap = false, desc = "Up" })
-- map("i", "<M-l>", "<Right>", { noremap = false, desc = "Right" })
--
-- map("t", "<M-h>", "<Left>", { desc = "Left" })
-- map("t", "<M-j>", "<Down>", { desc = "Down" })
-- map("t", "<M-k>", "<Up>", { desc = "Up" })
-- map("t", "<M-l>", "<Right>", { desc = "Right" })

map("n", "<leader>qd", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Quickfix diagnostics" })
map("n", "<leader>cd", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Current line diagnostics" })

-- map("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", { noremap = true, silent = true })
-- map("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", { noremap = true, silent = true })
-- map("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", { noremap = true, silent = true })
-- map("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", { noremap = true, silent = true })
-- map("n", "<Leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { noremap = true, silent = true })
-- map("n", "<Leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')))<cr>",
-- 	{ noremap = true, silent = true })
