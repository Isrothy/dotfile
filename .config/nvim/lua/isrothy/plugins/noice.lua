local M = {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
}

M.opts = {
    cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {
            border = {
                -- style = vim.g.neovide and "solid" or "rounded",
            },
        }, -- global options for the cmdline. See section on views
        format = {
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
            calculator = { pattern = "^=", icon = "", lang = "vimnormal" },
            term_run = { pattern = "^:%s*TermRun%s+", icon = "", lang = "bash" },
            input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
        },
    },
    popupmenu = {
        enabled = true, -- enables the Noice popupmenu UI
        ---@type 'nui'|'cmp'
        backend = "cmp", -- backend to use to show regular cmdline completions
        ---@type NoicePopupmenuItemKind|false
        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        kind_icons = {}, -- set to `false` to disable icons
    },
    messages = {
        enabled = true, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = false, -- view for search count messages. Set to `false` to disable
    },
    -- You can add any custom commands below that will be available with `:Noice command`
    commands = {
        history = {
            -- options for the message history that you get with `:Noice`
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {
                any = {
                    { event = "notify" },
                    { error = true },
                    { warning = true },
                    { event = "msg_show", kind = { "" } },
                    { event = "lsp", kind = "message" },
                },
            },
        },
        -- :Noice last
        last = {
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = {
                any = {
                    { event = "notify" },
                    { error = true },
                    { warning = true },
                    { event = "msg_show", kind = { "" } },
                    { event = "lsp", kind = "message" },
                },
            },
            filter_opts = { count = 1 },
        },
        -- :Noice errors
        errors = {
            -- options for the message history that you get with `:Noice`
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = { error = true },
            filter_opts = { reverse = true },
        },
    },
    notify = {
        enabled = true,
    },
    lsp = {
        progress = {
            enabled = true,
            throttle = 1000 / 60, -- frequency to update lsp progress message
        },
        override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = true,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = true,
        },
        hover = {
            enabled = true,
            view = nil, -- when nil, use defaults from documentation
            silent = true,
            opts = {
                border = {
                    style = "rounded",
                }, -- merged with defaults from documentation

                scrollbar = false,
            },
        },
        signature = {
            enabled = true,
            opts = {
                border = {
                    style = "rounded",
                }, -- merged with defaults from documentation
            },
        },
        message = {
            enabled = true,
            view = "notify",
            opts = {},
        },
        documentation = {
            view = "hover",
        },
    },
    presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    throttle = 1000 / 60, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.

    views = {
        cmdline_popup = {
            position = {
                row = "5%",
            },
            size = {
                height = "auto",
            },
        },
        popupmenu = {},
    },
    routes = {
        {
            filter = {
                event = "msg_show",
                kind = "",
                find = "written",
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = "msg_show",
                find = "^nil$",
            },
            opts = { skip = true },
        },
    }, -- @see the section on routes below
}

M.config = function(_, opts)
    require("noice").setup(opts)

    vim.keymap.set("n", "<c-f>", function()
        if not require("noice.lsp").scroll(4) then
            return "<c-f>"
        end
    end, { silent = true, expr = true })

    vim.keymap.set("n", "<c-b>", function()
        if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
        end
    end, { silent = true, expr = true })

    vim.keymap.set("c", "<S-Enter>", function()
        require("noice").redirect(vim.fn.getcmdline())
    end, { desc = "Redirect Cmdline" })
    vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
        if not require("noice.lsp").scroll(4) then
            return "<c-f>"
        end
    end, { silent = true, expr = true })

    vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
        if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
        end
    end, { silent = true, expr = true })
end

return M
