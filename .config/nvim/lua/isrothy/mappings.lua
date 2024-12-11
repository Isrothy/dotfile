local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","

map({ "n", "x" }, "<SPACE>", "<NOP>")
map({ "n", "x", "i", "c" }, "<C-Z>", "<NOP>")

map("n", "<C-C>", "ciw", { desc = "Change Word" })

map("t", "<C-\\>", "<C-\\><C-N>", { desc = "Escape Terminal Mode" })

map("i", ",", ",<C-G>u")
map("i", ".", ".<C-G>u")
map("i", ";", ";<C-G>u")

map(
  "n",
  "gO",
  "<CMD>call append(line('.') -1, repeat([''], v:count1))<CR>",
  { desc = "Append Line Before" }
)
map(
  "n",
  "go",
  "<CMD>call append(line('.'),   repeat([''], v:count1))<CR>",
  { desc = "Append Line After" }
)

map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up" })
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down" })

map("x", "g/", "<ESC>/\\%V", {
  silent = false,
  desc = "Search Inside Visual Selection",
})
map("n", "gV", "\"`[\" . strpart(getregtype(), 0, 1) . \"`]\"", {
  expr = true,
  replace_keycodes = false,
  desc = "Visually Select Changed Text",
})

-- map("n", "<LEADER>o", "<C-o>", default_options)
-- map("n", "<LEADER>i", "<C-i>", default_options)

-- map("n", "<LEADER>ws", "<C-W>s", { desc = "Split Window Horizontally" })
map("n", "<LEADER>wd", "<C-W>c", { desc = "Close Window" })
-- map("n", "<LEADER>wo", "<C-W>o", { desc = "Close Other Windows" })

map("n", "<ESC>", ":nohlsearch<CR>", { desc = "Clear Search Highlight" })

map({ "i", "c", "t" }, "<M-h>", "<LEFT>", { desc = "Left" })
map({ "i", "c", "t" }, "<M-j>", "<DOWN>", { desc = "Down" })
map({ "i", "c", "t" }, "<M-k>", "<UP>", { desc = "Up" })
map({ "i", "c", "t" }, "<M-l>", "<RIGHT>", { desc = "Right" })

map("n", "<LEADER>xq", vim.diagnostic.setqflist, { desc = "Quickfix List" })
map("n", "<LEADER>xl", vim.diagnostic.setloclist, { desc = "Location List" })
map("n", "<LEADER>xc", vim.diagnostic.open_float, { desc = "Current Line" })

map("x", ".", ":norm .<CR>")
map("x", "@", ":norm @q<CR>")

map("n", "gco", "o<ESC>Vcx<ESC><CMD>normal gcc<CR>fxa<BS>", { desc = "Add Comment Below" })
map("n", "gcO", "O<ESC>Vcx<ESC><CMD>normal gcc<CR>fxa<BS>", { desc = "Add Comment Above" })

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

map("n", "<LEADER><TAB>o", "<CMD>tabonly<CR>", { desc = "Close Other Tabs" })
map("n", "<LEADER><TAB>d", "<CMD>tabclose<CR>", { desc = "Close Tab" })
map("n", "<LEADER><TAB>f", "<CMD>tabfirst<CR>", { desc = "First Tab" })
map("n", "<LEADER><TAB>l", "<CMD>tablast<CR>", { desc = "Last Tab" })
map("n", "<LEADER><TAB><TAB>", "<CMD>tabnew<CR>", { desc = "New Tab" })
map("n", "<LEADER><TAB>]", "<CMD>tabnext<CR>", { desc = "Next Tab" })
map("n", "<LEADER><TAB>[", "<CMD>tabprevious<CR>", { desc = "Previous Tab" })

map("n", "]<TAB>", "<CMD>tabnext<CR>", { desc = "Next Tab" })
map("n", "[<TAB>", "<CMD>tabprevious<CR>", { desc = "Previous Tab" })
map("n", "]<S-TAB>", "<CMD>tablast<CR>", { desc = "Next Tab" })
map("n", "[<S-TAB>", "<CMD>tabfirst<CR>", { desc = "Previous Tab" })

vim.keymap.set("n", "<leader><Tab>c", function()
  vim.ui.input({ prompt = "Enter tab number to close: " }, function(input)
    local tab_number = tonumber(input)
    if tab_number then
      vim.cmd("tabclose " .. tab_number)
    else
      print("Invalid tab number")
    end
  end)
end, { desc = "Close a Tab" })

vim.keymap.set("n", "<leader><Tab>p", function()
  vim.ui.input({ prompt = "Enter tab number to pick: " }, function(input)
    local tab_number = tonumber(input)
    if tab_number then
      vim.cmd("tabn " .. tab_number)
    else
      print("Invalid tab number")
    end
  end)
end, { desc = "Pick a Tab" })

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
