local M = {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp" },
}

M.config = function()
    local default = require("plugins.lsp.default")

    local clangd_capabilities = default.capabilities

    -- clangd_capabilities.offsetEncoding = { "utf-16" }
    require("clangd_extensions").setup({
        server = {
            capabilities = clangd_capabilities,
            handlers = default.handlers,
            offset_encoding = default.offset_encoding,
            on_attach = function(client, bufnr)
                default.set_key_map(client, bufnr)
                default.hl_word(client, bufnr)
            end,
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--completion-style=bundled",
                "--cross-file-rename",
                "--header-insertion=iwyu",
            },
        },
        extensions = {
            -- defaults:
            -- Automatically set inlay hints (type hints)
            autoSetHints = false,
            -- Whether to show hover actions inside the hover window
            hover_with_actions = true,
            -- These apply to the default ClangdSetInlayHints command
            inlay_hints = {
                -- Only show inlay hints for the current line
                only_current_line = false,
                -- Event which triggers a refersh of the inlay hints.
                -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
                -- not that this may cause  higher CPU usage.
                -- This option is only respected when only_current_line and
                -- autoSetHints both are true.
                only_current_line_autocmd = "CursorHold",
                -- whether to show parameter hints with the inlay hints or not
                show_parameter_hints = false,
                -- prefix for parameter hints
                parameter_hints_prefix = "<- ",
                -- prefix for all the other hints (type, chaining)
                other_hints_prefix = "=> ",
                -- whether to align to the length of the longest line in the file
                max_len_align = false,
                -- padding from the left if max_len_align is true
                max_len_align_padding = 1,
                -- whether to align to the extreme right or not
                right_align = false,
                -- padding from the right if right_align is true
                right_align_padding = 7,
                -- The color of the hints
                highlight = "Comment",
                -- The highlight group priority for extmark
                priority = 100,
            },
            ast = {
                role_icons = {
                    type = "",
                    declaration = "ﭝ",
                    expression = "ﰊ",
                    specifier = "炙",
                    statement = "ﰉ",
                    ["template argument"] = "",
                },

                kind_icons = {
                    Compound = "ﯶ",
                    Recovery = "",
                    TranslationUnit = "",
                    PackExpansion = "",
                    TemplateTypeParm = "",
                    TemplateTemplateParm = "",
                    TemplateParamObject = "",
                },

                highlights = {
                    detail = "Comment",
                },
            },
            memory_usage = {
                border = default.border,
            },
            symbol_info = {
                border = default.border,
            },
        },
    })
end

return M
