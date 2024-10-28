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

local inc_rename = {
    "smjonas/inc-rename.nvim",
    enabled = true,
    event = { "LspAttach" },
    opts = { cmd_name = "IncRename" },
}

local illuminate = {
    "RRethy/vim-illuminate",
    enabled = true,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        delay = 200,
        large_file_cutoff = 2000,
        providers = {
            "lsp",
            -- "treesitter",
            -- "regex",
        },
        large_file_overrides = {
            providers = {},
        },
        filetypes_denylist = {
            "TelescopePrompt",
            "aerial",
            "dirbuf",
            "dirvish",
            "fugitive",
            "neo-tree",
            "text",
            "toggleterm",
        },
    },
    config = function(_, opts)
        require("illuminate").configure(opts)

        local function map(key, dir, buffer)
            vim.keymap.set("n", key, function()
                require("illuminate")["goto_" .. dir .. "_reference"](true)
            end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
        end

        map("]]", "next")
        map("[[", "prev")

        -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local buffer = vim.api.nvim_get_current_buf()
                map("]]", "next", buffer)
                map("[[", "prev", buffer)
            end,
        })
    end,
    keys = {
        { "]]", desc = "Next reference" },
        { "[[", desc = "Prev reference" },
    },
}

local trouble = {
    "folke/trouble.nvim",
    cmd = {
        "Trouble",
    },
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>xs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>xl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
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
    event = "LspAttach", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
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
    illuminate,
    inc_rename,
    trouble,
    lsplinks,
    symbol_usage,
}
