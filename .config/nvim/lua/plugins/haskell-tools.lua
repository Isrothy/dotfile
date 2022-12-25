local M = {
    "MrcJkb/haskell-tools.nvim",
    ft = { "haskell" },
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
    },
}

M.config = function()
    local default = require("plugins.lsp.default")

    local ht = require("haskell-tools")
    ht.setup({
        tools = { -- haskell-tools options
            codeLens = {
                -- Whether to automatically display/refresh codeLenses
                autoRefresh = true,
            },
            hoogle = {
                -- 'auto': Choose a mode automatically, based on what is available.
                -- 'telescope-local': Force use of a local installation.
                -- 'telescope-web': The online version (depends on curl).
                -- 'browser': Open hoogle search in the default browser.
                mode = "auto",
            },
            repl = {
                -- 'builtin': Use the simple builtin repl
                -- 'toggleterm': Use akinsho/toggleterm.nvim
                handler = nil,
                builtin = {
                    create_repl_window = function(view)
                        -- create_repl_split | create_repl_vsplit | create_repl_tabnew | create_repl_cur_win
                        return view.create_repl_split({ size = vim.o.lines / 3 })
                    end,
                },
            },
            hover = {
                -- Whether to disable haskell-tools hover and use the builtin lsp's default handler
                disable = false,
                border = default.border,
                --
                -- border = {
                -- 	{ " ", "FloatBorder" },
                -- 	{ " ", "FloatBorder" },
                -- 	{ " ", "FloatBorder" },
                -- 	{ " ", "FloatBorder" },
                -- 	{ " ", "FloatBorder" },
                -- 	{ " ", "FloatBorder" },
                -- 	{ " ", "FloatBorder" },
                -- 	{ " ", "FloatBorder" },
                -- },

                stylize_markdown = true,
                -- Whether to automatically switch to the hover window
                auto_focus = false,
            },
            tags = {
                -- enable = vim.fn.executable("fast-tags") == 1,
                enable = false,
                -- Events to trigger package tag generation
                package_events = { "BufWritePost" },
            },
        },
        hls = {
            capabilities = default.capabilities,
            handlers = default.handlers,
            offset_encoding = default.offset_encoding,
            -- See nvim-lspconfig's  suggested configuration for keymaps, etc.
            on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                default.set_key_map(client, bufnr)
                default.hl_word(client, bufnr)
                require("telescope").load_extension("ht")
                vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
                vim.keymap.set("n", "<leader>s", ht.hoogle.hoogle_signature, opts)
            end,
            -- single_file_support = true,
            -- settings = {
            haskell = { -- haskell-language-server options
                formattingProvider = "ormolu",
                checkProject = true, -- Setting this to true could have a performance impact on large mono repos.
                -- ...
            },
        },
    })
end

return M
