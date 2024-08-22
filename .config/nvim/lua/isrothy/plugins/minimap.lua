---@module 'neominimap.config.meta'
return {
    {
        dir = "~/neominimap.nvim",
        -- "Isrothy/neominimap.nvim",
        lazy = false,
        -- version = "v3.*.*",
        enabled = true,
        keys = {
            -- Global Minimap Controls
            { "<leader>nm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
            { "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
            { "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
            { "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },

            -- Window-Specific Minimap Controls
            { "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
            { "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
            { "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
            { "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },

            -- Tab-Specific Minimap Controls
            { "<leader>ntt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
            { "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
            { "<leader>nto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
            { "<leader>ntc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },

            -- Buffer-Specific Minimap Controls
            { "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
            { "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
            { "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
            { "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },

            ---Focus Controls
            { "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
            { "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
            { "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
        },

        init = function()
            vim.opt.wrap = false
            vim.opt.sidescrolloff = 36

            ---@type Neominimap.UserConfig
            vim.g.neominimap = {
                auto_enable = true,
                log_level = vim.log.levels.TRACE,
                exclude_filetypes = {
                    "qf",
                    "neo-tree",
                    "help",
                },
                buf_filter = function(bufnr)
                    local line_cnt = vim.api.nvim_buf_line_count(bufnr)
                    return line_cnt < 4096 and not vim.b[bufnr].large_buf
                end,
                x_multiplier = 4,
                sync_cursor = true,
                click = {
                    enabled = true,
                    auto_switch_focus = true,
                },
                layout = "split",
                split = {
                    direction = "right",
                },
                float = {
                    minimap_width = 22,
                    window_border = { "▏", "", "", "", "", "", "▏", "▏" },
                },
                diagnostic = {
                    enabled = true,
                    severity = vim.diagnostic.severity.HINT,
                    mode = "line",
                },
                git = {
                    enabled = true,
                },
                search = {
                    enabled = true,
                    mode = "sign",
                },
                treesitter = {
                    enabled = true,
                },
            }
        end,
    },
    {
        "echasnovski/mini.map",
        version = "*",
        lazy = false,
        enabled = false,
        -- No need to copy this inside `setup()`. Will be used automatically.
        config = function()
            require("mini.map").setup({
                -- Highlight integrations (none by default)
                integrations = nil,

                -- Symbols used to display data
                symbols = {
                    -- Encode symbols. See `:h MiniMap.config` for specification and
                    -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
                    -- Default: solid blocks with 3x2 resolution.
                    encode = nil,

                    -- Scrollbar parts for view and line. Use empty string to disable any.
                    scroll_line = "█",
                    scroll_view = "┃",
                },

                -- Window options
                window = {
                    -- Whether window is focusable in normal way (with `wincmd` or mouse)
                    focusable = true,
                    -- Side to stick ('left' or 'right')
                    side = "right",
                    -- Whether to show count of multiple integration highlights
                    show_integration_count = true,
                    -- Total width
                    width = 10,
                    -- Z-index
                    zindex = 10,
                },
            })
        end,
    },
    {
        "gorbit99/codewindow.nvim",
        -- dir = "~/codewindow.nvim",
        lazy = false,
        enabled = false,
        init = function()
            -- vim.opt.sidescrolloff = 36
            vim.g.codewindow = {
                auto_enable = true,
                exclude_filetypes = {
                    "qf",
                    "help",
                },
                minimap_width = 20,
                use_lsp = true,
                use_treesitter = true,
                use_git = true,
                width_multiplier = 4,
                z_index = 1,
                show_cursor = true,
                screen_bounds = "background",
                window_border = "none",
                -- window_border = { "", "", "", "", "", "", "", "" },
                relative = "win",
                events = {
                    "LspAttach",
                    "BufEnter",
                    "BufNewFile",
                    "BufRead",
                    "TextChanged",
                    "InsertLeave",
                    "DiagnosticChanged",
                    "FileWritePost",
                },
            }
        end,
        opts = {},
    },
    {
        "wfxr/minimap.vim",
        lazy = true,
        init = function()
            vim.g.minimap_auto_start = 1
        end,
    },
}
