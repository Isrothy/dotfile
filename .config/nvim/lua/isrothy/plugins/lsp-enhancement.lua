local lightbulb = {
    "kosayoda/nvim-lightbulb",
    enabled = true,
    event = { "LspAttach" },
    opts = {
        priority = 10,
        hide_in_unfocused_buffer = true,
        link_highlights = true,
        validate_config = "auto",
        action_kinds = nil,
        sign = {
            enabled = true,
            text = "💡",
            hl = "LightBulbSign",
        },
        virtual_text = { enabled = false },
        float = { enabled = false },
        status_text = { enabled = false },
        number = { enabled = false },
        line = { enabled = false },
        autocmd = {
            enabled = true,
            updatetime = 200,
            events = { "CursorHold", "CursorHoldI" },
            pattern = { "*" },
        },
        ignore = {
            clients = {},
            ft = {},
            actions_without_kind = false,
        },
    },
}

local actions_preview = {
    "aznhe21/actions-preview.nvim",
    enabled = true,
    opts = {
        diff = {
            ctxlen = 3,
        },
        backend = { "telescope", "nui" },
        telescope = {
            sorting_strategy = "ascending",
            layout_strategy = "vertical",
            layout_config = {
                width = 0.8,
                height = 0.9,
                prompt_position = "top",
                preview_cutoff = 20,
                preview_height = function(_, _, max_lines)
                    return max_lines - 15
                end,
            },
        },
    },
}

local conform = {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    opts = {
        default_format_opts = {
            timeout_ms = 3000,
            async = true,
            quiet = false,
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua", lsp_format = "fallback" },
            sh = { "shfmt", lsp_format = "fallback" },
            c = { "clang-format", lsp_format = "fallback" },
            cpp = { "clang-format", lsp_format = "fallback" },
            javascript = { "prettier", lsp_format = "fallback" },
            typescript = { "prettier", lsp_format = "fallback" },
            markdown = {
                "prettier",
                "markdownlint-cli2",
                "markdown-toc",
                lsp_format = "fallback",
            },
            ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        },
        formatters = {
            ["markdown-toc"] = {
                condition = function(_, ctx)
                    for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                        if line:find("<!%-%- toc %-%->") then
                            return true
                        end
                    end
                end,
            },
            ["markdownlint-cli2"] = {
                condition = function(_, ctx)
                    local diag = vim.tbl_filter(function(d)
                        return d.source == "markdownlint"
                    end, vim.diagnostic.get(ctx.buf))
                    return #diag > 0
                end,
            },
            injected = { options = { ignore_errors = true } },
        },
    },
}

local trouble = {
    "folke/trouble.nvim",
    cmd = {
        "Trouble",
    },
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (Trouble)" },
        { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list (Trouble)" },
        { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list (Trouble)" },

        { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
        { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },

        {
            "[q",
            function()
                if require("trouble").is_open() then
                    require("trouble").prev({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Previous Trouble/Quickfix Item",
        },
        {
            "]q",
            function()
                if require("trouble").is_open() then
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Next Trouble/Quickfix Item",
        },
    },
    opts = {
        modes = {
            symbols = {
                desc = "document symbols",
                mode = "lsp_document_symbols",
                focus = false,
                win = { position = "right" },
                filter = {
                    -- remove Package since luals uses it for control flow structures
                    ["not"] = { ft = "lua", kind = "Package" },
                    any = {
                        -- all symbol kinds for help / markdown files
                        ft = { "help", "markdown" },
                        -- default set of symbol kinds
                        kind = {
                            "Array",
                            "Boolean",
                            "Class",
                            "Constructor",
                            "Constant",
                            "Enum",
                            "EnumMember",
                            "Event",
                            "Field",
                            "File",
                            "Function",
                            "Interface",
                            "Key",
                            "Module",
                            "Method",
                            "Namespace",
                            "Number",
                            "Object",
                            "Package",
                            "Property",
                            "String",
                            "Struct",
                            "TypeParameter",
                            "Variable",
                        },
                    },
                },
            },
        },
    },
}

local lsplinks = {
    "icholy/lsplinks.nvim",
    keys = {
        {
            "gx",
            function()
                require("lsplinks").gx()
            end,
            mode = { "n" },
            desc = "Open link",
        },
    },
    opts = {
        highlight = true,
        hl_group = "Underlined",
    },
}

local symbol_usage = {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    opts = {
        vt_position = "end_of_line",
        text_format = function(symbol)
            local fragments = {}

            -- Indicator that shows if there are any other symbols in the same line
            local stacked_functions = symbol.stacked_count > 0 and (" | +%s"):format(symbol.stacked_count) or ""

            if symbol.references then
                local usage = symbol.references <= 1 and "usage" or "usages"
                local num = symbol.references == 0 and "no" or symbol.references
                table.insert(fragments, ("%s %s"):format(num, usage))
            end

            if symbol.definition then
                table.insert(fragments, symbol.definition .. " defs")
            end

            if symbol.implementation then
                table.insert(fragments, symbol.implementation .. " impls")
            end

            return table.concat(fragments, ", ") .. stacked_functions
        end,
    },
}

return {
    lightbulb,
    actions_preview,
    conform,
    trouble,
    lsplinks,
    symbol_usage,
}
