local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
}

M.config = function()
    vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = false,
    })
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end


    local default = require("plugins.lsp.default")

    require("lspconfig").bashls.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.hl_word(client, bufnr)
        end,
    })
    require("lspconfig").cmake.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.set_key_map(client, bufnr)
            default.hl_word(client, bufnr)
        end,
    })

    require("lspconfig").cssls.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.set_key_map(client, bufnr)
            default.hl_word(client, bufnr)
        end,
    })
    require("lspconfig").dockerls.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.set_key_map(client, bufnr)
            default.hl_word(client, bufnr)
        end,
    })
    require("lspconfig").emmet_ls.setup({
        handlers = default.handlers,
        capabilities = default.capabilities,
        offset_encoding = default.offset_encoding,
    })
    require("lspconfig").eslint.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.set_key_map(client, bufnr)
            default.hl_word(client, bufnr)
        end,
    })
    require("lspconfig").gradle_ls.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.set_key_map(client, bufnr)
            default.hl_word(client, bufnr)
        end,
    })
    require("lspconfig").html.setup({
        handlers = default.handlers,
        capabilities = default.capabilities,
        offset_encoding = default.offset_encoding,
    })

    require("lspconfig").jdtls.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.hl_word(client, bufnr)
            default.set_key_map(client, bufnr)
        end,
    })
    require("lspconfig").kotlin_language_server.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        single_file_support = true,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.hl_word(client, bufnr)
            default.set_key_map(client, bufnr)
        end,
    })
    require("lspconfig").pylsp.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.hl_word(client, bufnr)
            default.set_key_map(client, bufnr)
        end,
    })
    -- require("lspconfig").pyright.setup({
    -- 	capabilities = util.capabilities,
    -- 	handlers = util.handlers,
    -- 	on_attach = function(client, bufnr)
    -- 		util.set_key_map(client, bufnr)
    -- 		util.hl_word(client, bufnr)
    -- 	end,
    -- })
    require("lspconfig").r_language_server.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.set_key_map(client, bufnr)
            default.hl_word(client, bufnr)
        end,
    })
    require("lspconfig").sourcekit.setup({
        filetypes = { "swift", "objective-c" },
        single_file_support = true,
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.set_key_map(client, bufnr)
            default.hl_word(client, bufnr)
        end,
    })
    require("lspconfig").sumneko_lua.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.hl_word(client, bufnr)
            default.set_key_map(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            -- client.server_capabilities.textDocument.completion.completionItem.snippetSupport = false
        end,
    })
    require("lspconfig").vimls.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        on_attach = function(client, bufnr)
            default.set_key_map(client, bufnr)
            default.hl_word(client, bufnr)
        end,
    })

end

return M
