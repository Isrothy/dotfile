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

map("n", "<C-h>", "<C-w>h", default_options)
map("n", "<C-j>", "<C-w>j", default_options)
map("n", "<C-k>", "<C-w>k", default_options)
map("n", "<C-l>", "<C-w>l", default_options)
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
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], default_options)
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], default_options)
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], default_options)
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], default_options)

map("c", "<M-h>", "<Left>", { silent = false, desc = "Left" })
map("c", "<M-l>", "<Right>", { silent = false, desc = "Right" })

-- Don't `noremap` in insert mode to have these keybindings behave exactly
-- like arrows (crucial inside TelescopePrompt)
map("i", "<M-h>", "<Left>", { noremap = false, desc = "Left" })
map("i", "<M-j>", "<Down>", { noremap = false, desc = "Down" })
map("i", "<M-k>", "<Up>", { noremap = false, desc = "Up" })
map("i", "<M-l>", "<Right>", { noremap = false, desc = "Right" })

map("t", "<M-h>", "<Left>", { desc = "Left" })
map("t", "<M-j>", "<Down>", { desc = "Down" })
map("t", "<M-k>", "<Up>", { desc = "Up" })
map("t", "<M-l>", "<Right>", { desc = "Right" })

map("n", "<leader>q", vim.diagnostic.setloclist, default_options)
map("n", "<leader>d", vim.diagnostic.open_float, default_options)

-- map(
-- 	"n",
-- 	"]d",
-- 	"<cmd>lua vim.diagnostic.goto_next({float={border = 'rounded'}})<cr>",
-- 	{ noremap = true, silent = true, desc = "Diagnostic forward" }
-- )
-- map(
-- 	"n",
-- 	"[d",
-- 	"<cmd> lua vim.diagnostic.goto_prev({float={border = 'rounded'}})<cr>",
-- 	{ noremap = true, silent = true, desc = "Diagnostic backward" }
-- )

-- map("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", { noremap = true, silent = true })
-- map("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", { noremap = true, silent = true })
-- map("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", { noremap = true, silent = true })
-- map("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", { noremap = true, silent = true })
-- map("n", "<Leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { noremap = true, silent = true })
-- map("n", "<Leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')))<cr>",
-- 	{ noremap = true, silent = true })

local function swap_buffers(with)
	if string.match(with, "[hjkl]") then
		local target_window = vim.fn.win_getid(vim.fn.winnr(with))
		local target_buffer = vim.api.nvim_win_get_buf(target_window)

		local target_filetype = vim.api.nvim_buf_get_option(target_buffer, "filetype")
		local current_filetype = vim.api.nvim_buf_get_option(0, "filetype")
		local ignore = {
			"NvimTree",
			"neo-tree",
			"toggleterm",
			"BufTerm",
			"aerial",
		}

		if not (vim.tbl_contains(ignore, target_filetype) or vim.tbl_contains(ignore, current_filetype)) then
			local current_buffer = vim.fn.bufnr()

			vim.cmd("b " .. target_buffer)
			vim.fn.win_gotoid(target_window)
			vim.cmd("b " .. current_buffer)
		end
	else
		print("argument needs to be one of [hjkl]")
	end
end

for _, key in ipairs({ "h", "j", "k", "l" }) do
	map("n", "<leader>b" .. key, function()
		swap_buffers(key)
	end, default_options)
end
