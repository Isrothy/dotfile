local set = vim.keymap.set
local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
  set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map({ "n", "x" }, "<SPACE>", "<NOP>")
map({ "n", "x" }, "\\", "<NOP>")
map({ "n", "x", "i", "c" }, "<C-Z>", "<NOP>")

map("n", "<LEADER>;", "<CMD>w<CR>", { desc = "Save" })
map("n", "<C-C>", "ciw", { desc = "Change word" })

map("t", "<C-\\>", "<C-\\><C-N>", { desc = "Escape terminal mode" })

map("i", ",", ",<C-G>u")
map("i", ".", ".<C-G>u")
map("i", ";", ";<C-G>u")

map("n", "gO", "<CMD>call append(line('.') -1, repeat([''], v:count1))<CR>", { desc = "Append line before" })
map("n", "go", "<CMD>call append(line('.'),   repeat([''], v:count1))<CR>", { desc = "Append line after" })

map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up" })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down" })

map("x", "g/", "<ESC>/\\%V", {
  silent = false,
  desc = "Search inside visual selection",
})
map("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"', {
  expr = true,
  replace_keycodes = false,
  desc = "Visually select changed text",
})

map("n", "<LEADER>wd", "<C-W>c", { desc = "Close current window" })

map("n", "<ESC>", "<ESC>:nohlsearch<CR>", { desc = "Clear search highlight" })

map({ "i", "c", "t" }, "<M-h>", "<LEFT>", { desc = "Left" })
map({ "i", "c", "t" }, "<M-j>", "<DOWN>", { desc = "Down" })
map({ "i", "c", "t" }, "<M-k>", "<UP>", { desc = "Up" })
map({ "i", "c", "t" }, "<M-l>", "<RIGHT>", { desc = "Right" })

map("n", "<LEADER>xq", vim.diagnostic.setqflist, { desc = "Quickfix list" })
map("n", "<LEADER>xl", vim.diagnostic.setloclist, { desc = "Location list" })
map("n", "<LEADER>xc", vim.diagnostic.open_float, { desc = "Current line" })

map("x", ".", ":norm .<CR>")
map("x", "@", ":norm @q<CR>")

map("n", "gco", "o<ESC>Vcx<ESC><CMD>normal gcc<CR>fxa<BS>", { desc = "Add comment below" })
map("n", "gcO", "O<ESC>Vcx<ESC><CMD>normal gcc<CR>fxa<BS>", { desc = "Add comment above" })

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go({ severity = severity }) end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Previous diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Previous error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Previois warning" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<LEADER>lh", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<LEADER>ln", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<LEADER>ll", vim.lsp.codelens.run, { desc = "Code lens" })
map("n", "<LEADER>la", vim.lsp.buf.code_action, { desc = "Code action" })

map("n", "<LEADER>Wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace" })
map("n", "<LEADER>Wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace" })
map(
  "n",
  "<LEADER>Wl",
  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
  { desc = "List workspace" }
)
map("n", "<LEADER>Ws", function() vim.lsp.buf.workspace_symbol() end, { desc = "Workspace symbols" })


map("n", "<LEADER><TAB>o", "<CMD>tabonly<CR>", { desc = "Close other tabs" })
map("n", "<LEADER><TAB>d", "<CMD>tabclose<CR>", { desc = "Close current tab" })
map("n", "<LEADER><TAB>f", "<CMD>tabfirst<CR>", { desc = "First tab" })
map("n", "<LEADER><TAB>l", "<CMD>tablast<CR>", { desc = "Last tab" })
map("n", "<LEADER><TAB><TAB>", "<CMD>tabnew<CR>", { desc = "New tab" })
map("n", "<LEADER><TAB>]", "<CMD>tabnext<CR>", { desc = "Next tab" })
map("n", "<LEADER><TAB>[", "<CMD>tabprevious<CR>", { desc = "Previous tab" })

map("n", "]<TAB>", "<CMD>tabnext<CR>", { desc = "Next tab" })
map("n", "[<TAB>", "<CMD>tabprevious<CR>", { desc = "Previous tab" })
map("n", "]<S-TAB>", "<CMD>tablast<CR>", { desc = "Next tab" })
map("n", "[<S-TAB>", "<CMD>tabfirst<CR>", { desc = "Previous tab" })

map("n", "<leader><Tab>c", function()
  vim.ui.input({ prompt = "Enter tab number to close: " }, function(input)
    local tab_number = tonumber(input)
    if tab_number then
      vim.cmd("tabclose " .. tab_number)
    else
      print("Invalid tab number")
    end
  end)
end, { desc = "Close a tab" })

map("n", "<leader><Tab>p", function()
  vim.ui.input({ prompt = "Enter tab number to pick: " }, function(input)
    local tab_number = tonumber(input)
    if tab_number then
      vim.cmd("tabn " .. tab_number)
    else
      print("Invalid tab number")
    end
  end)
end, { desc = "Pick a tab" })

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
