local default_options = { noremap = true, silent = true }
local expr_options = { expr = true, silent = true }

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", default_options)
vim.g.mapleader = " "

vim.keymap.set({ "n", "v", "i" }, "<UP>", "<NOP>", default_options)
vim.keymap.set({ "n", "v", "i" }, "<DOWN>", "<NOP>", default_options)
vim.keymap.set({ "n", "v", "i" }, "<LEFT>", "<NOP>", default_options)
vim.keymap.set({ "n", "v", "i" }, "<RIGHT>", "<NOP>", default_options)

vim.keymap.set(
	"n",
	"gO",
	"<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
	{ desc = "append line before" }
)
vim.keymap.set("n", "go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", { desc = "append line after" })

-- vim.keymap.set("v", "<", "<gv", default_options)
-- vim.keymap.set("v", ">", ">gv", default_options)
-- vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", default_options)
-- vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", default_options)

vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

vim.keymap.set({ "n" }, "<c-h>", "<c-w>h", default_options)
vim.keymap.set({ "n" }, "<c-j>", "<c-w>j", default_options)
vim.keymap.set({ "n" }, "<c-k>", "<c-w>k", default_options)
vim.keymap.set({ "n" }, "<c-l>", "<c-w>l", default_options)
vim.keymap.set({ "n" }, "<c-v>", "<c-w>v", default_options)
vim.keymap.set({ "n" }, "<c-s>", "<c-w>s", default_options)
vim.keymap.set({ "n" }, "<c-c>", "<c-w>c", default_options)
vim.keymap.set({ "n" }, "<c-o>", "<c-w>o", default_options)
vim.keymap.set({ "n" }, "<c-=>", "<c-w>+", default_options)
vim.keymap.set({ "n" }, "<c-->", "<c-w>-", default_options)
vim.keymap.set({ "n" }, "<c-.>", "<c-w>>", default_options)
vim.keymap.set({ "n" }, "<c-,>", "<c-w><", default_options)

vim.keymap.set("n", "<esc>", ":nohlsearch<cr>")

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], default_options)
vim.keymap.set("t", "<c-h>", [[<c-\><c-n><c-w>h]], default_options)
vim.keymap.set("t", "<c-j>", [[<c-\><c-n><c-w>j]], default_options)
vim.keymap.set("t", "<c-k>", [[<c-\><c-n><c-w>k]], default_options)
vim.keymap.set("t", "<c-l>", [[<c-\><c-n><c-w>l]], default_options)

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, default_options)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, default_options)
vim.keymap.set(
	"n",
	"[d",
	vim.diagnostic.goto_prev,
	{ noremap = true, silent = true, desc = "Go to previous diagnostic" }
)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Go to next diagnostic" })

-- vim.keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')))<cr>",
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
	vim.keymap.set("n", "<leader>b" .. key, function()
		swap_buffers(key)
	end, default_options)
end
