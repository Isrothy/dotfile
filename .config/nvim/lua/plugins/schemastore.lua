local M = {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc" },
}

M.config = function()
    local default = require("plugins.lsp.default")
    require("lspconfig").jsonls.setup({
        capabilities = default.capabilities,
        handlers = default.handlers,
        offset_encoding = default.offset_encoding,
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
            },
        },
        on_attach = function(client, bufnr)
            default.hl_word(client, bufnr)
            default.set_key_map(client, bufnr)
        end,
    })
end

return M
