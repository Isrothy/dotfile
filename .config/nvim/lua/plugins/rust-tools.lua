local M = {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
}

function M.config()
    local default = require("plugins.lsp.default")
    local rt = require("rust-tools")
    rt.setup({
        server = {
            capabilities = default.capabilities,
            handlers = default.handlers,
            offset_encoding = default.offset_encoding,
            on_attach = function(client, bufnr)
                default.set_key_map(client, bufnr)
                default.hl_word(client, bufnr)
                vim.keymap.set("n", "gh", rt.hover_actions.hover_actions, { buffer = bufnr })
                vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
            end,
            standalone = true,
        },
        tools = { -- rust-tools options

            -- how to execute terminal commands
            -- options right now: termopen / quickfix
            executor = require("rust-tools/executors").termopen,

            -- callback to execute once rust-analyzer is done initializing the workspace
            -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
            on_initialized = nil,

            -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
            reload_workspace_from_cargo_toml = true,

            -- These apply to the default RustSetInlayHints command
            inlay_hints = {
                -- automatically set inlay hints (type hints)
                -- default: true
                auto = false,

                -- Only show inlay hints for the current line
                only_current_line = false,

                -- whether to show parameter hints with the inlay hints or not
                -- default: true
                show_parameter_hints = false,

                -- prefix for parameter hints
                -- default: "<-"
                parameter_hints_prefix = "<- ",

                -- prefix for all the other hints (type, chaining)
                -- default: "=>"
                other_hints_prefix = "=> ",

                -- whether to align to the lenght of the longest line in the file
                max_len_align = false,

                -- padding from the left if max_len_align is true
                max_len_align_padding = 1,

                -- whether to align to the extreme right or not
                right_align = false,

                -- padding from the right if right_align is true
                right_align_padding = 7,

                -- The color of the hints
                highlight = "Comment",
            },
            hover_actions = {

                -- the border that is used for the hover window
                -- see vim.api.nvim_open_win()
                border = default.border,

                -- whether the hover action window gets automatically focused
                -- default: false
                auto_focus = false,
            },
        },
    })
    require("rust-tools").inlay_hints.disable()
end

return M
