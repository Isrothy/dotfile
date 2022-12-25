local M = {}

M.border = {
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ " ", "FloatBorder" },
}

M.handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = M.border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = M.border }),
}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

M.hl_word = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#4C566A", fg = "NONE" })
		vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#4C566A", fg = "NONE" })
		vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#4C566A", fg = "NONE" })
		-- vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "NONE", fg = "NONE", underline = true })
		-- vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "NONE", fg = "NONE", underline = true })
		-- vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "NONE", fg = "NONE", underline = true })
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

M.set_key_map = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gl", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gD", function()
		require("telescope.builtin").lsp_type_definitions({ jump_type = "never" })
	end, bufopts)

	vim.keymap.set("n", "gd", function()
		require("telescope.builtin").lsp_definitions({ jump_type = "never" })
	end, bufopts)

	vim.keymap.set("n", "gi", function()
		require("telescope.builtin").lsp_implementations({ jump_type = "never" })
	end, bufopts)

	vim.keymap.set("n", "gr", function()
		require("telescope.builtin").lsp_references({ jump_type = "never" })
	end, bufopts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<Leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

M.offset_encoding = "utf-8"

return M
