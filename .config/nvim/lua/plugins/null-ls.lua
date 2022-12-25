local M = {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
}

M.config = function()
    local null_ls = require("null-ls")

    local default = require("plugins.lsp.default")

    null_ls.setup({
        on_init = function(new_client, _)
            new_client.offset_encoding = default.offset_encoding
        end,
        on_attach = function(client, bufnr)
            default.set_key_map(client, bufnr)
            default.hl_word(client, bufnr)
        end,
        sources = {
            null_ls.builtins.diagnostics.checkmake,
            null_ls.builtins.diagnostics.hadolint,
            null_ls.builtins.diagnostics.gitlint,
            -- null_ls.builtins.diagnostics.swiftlint,
            -- null_ls.builtins.diagnostics.yamllint,
            null_ls.builtins.diagnostics.zsh,

            null_ls.builtins.code_actions.shellcheck,

            null_ls.builtins.formatting.autopep8,
            null_ls.builtins.formatting.clang_format,
            null_ls.builtins.formatting.cmake_format,
            null_ls.builtins.formatting.markdownlint,
            null_ls.builtins.formatting.prettierd.with({
                filetypes = {
                    "css",
                    "scss",
                    "less",
                    "html",
                    "json",
                    "jsonc",
                    "yaml",
                    "graphql",
                    "handlebars",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "vue",
                },
            }),
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.swiftformat,

            -- null_ls.builtins.formatting.yamlfmt,
            null_ls.builtins.formatting.xmllint,
        },
    })
end
return M
