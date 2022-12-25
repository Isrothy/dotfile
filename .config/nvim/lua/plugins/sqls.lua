local M = {
    "nanotee/sqls.nvim",
    ft = { "sql", "mysql" },
}
M.config = function()
    local default = require("setup.lsp.default")
    require("lspconfig").sqls.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        on_attach = function(client, bufnr)
            require("sqls").on_attach(client, bufnr)
            default.set_key_map(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
        end,
    })
end

return M
