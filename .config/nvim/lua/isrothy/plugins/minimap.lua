---@module 'neominimap.config.meta'

---@type Neominimap.Map.Handler
local extmark_handler = {
    name = "Todo Comment",
    mode = "icon",
    namespace = vim.api.nvim_create_namespace("neominimap_todo_comment"),
    init = function() end,
    autocmds = {
        {
            event = { "TextChanged", "TextChangedI" },
            opts = {
                callback = function(apply, args)
                    local bufnr = tonumber(args.buf) ---@cast bufnr integer
                    vim.schedule(function()
                        apply(bufnr)
                    end)
                end,
            },
        },
        {
            event = "WinScrolled",
            opts = {
                callback = function(apply)
                    local winid = vim.api.nvim_get_current_win()
                    if not winid or not vim.api.nvim_win_is_valid(winid) then
                        return
                    end
                    local bufnr = vim.api.nvim_win_get_buf(winid)
                    vim.schedule(function()
                        if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
                            apply(bufnr)
                        end
                    end)
                end,
            },
        },
    },
    get_annotations = function(bufnr)
        local ok, _ = pcall(require, "todo-comments")
        if not ok then
            return {}
        end
        local ns_id = vim.api.nvim_get_namespaces()["todo-comments"]
        local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {
            details = true,
        })
        local icons = {
            FIX = " ",
            TODO = " ",
            HACK = " ",
            WARN = " ",
            PERF = " ",
            NOTE = " ",
            TEST = "⏲ ",
        }
        local id = { FIX = 1, TODO = 2, HACK = 3, WARN = 4, PERF = 5, NOTE = 6, TEST = 7 }
        return vim.tbl_map(function(extmark) ---@param extmark vim.api.keyset.get_extmark_item
            local detail = extmark[4] ---@type vim.api.keyset.extmark_details
            local group = detail.hl_group ---@type string
            local kind = string.sub(group, 7)
            local icon = icons[kind]
            ---@type Neominimap.Map.Handler.Annotation
            return {
                lnum = extmark[2],
                end_lnum = extmark[2],
                id = id[kind],
                highlight = "TodoFg" .. kind,
                icon = icon,
                priority = detail.priority,
            }
        end, extmarks)
    end,
}

return {
    {
        dir = "~/neominimap.nvim",
        -- "Isrothy/neominimap.nvim",
        version = "v3.x.x",
        lazy = false,
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

            _G.MyStatusCol = function()
                local ok, statuscol = pcall(require, "statuscol")
                if ok then
                    return statuscol.get_statuscol_string()
                else
                    return ""
                end
            end

            ---@type Neominimap.UserConfig
            vim.g.neominimap = {
                auto_enable = true,
                log_level = vim.log.levels.DEBUG,
                notification_level = vim.log.levels.OFF,

                exclude_filetypes = {
                    "qf",
                    "neo-tree",
                    "help",
                },
                x_multiplier = 4,
                sync_cursor = true,
                click = {
                    enabled = true,
                    auto_switch_focus = true,
                },
                layout = "float",
                split = {
                    direction = "right",
                    close_if_last_window = true,
                    fix_width = false,
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
                    mode = "sign",
                },
                mark = {
                    enabled = true,
                    mode = "icon",
                    show_builtins = true,
                },
                search = {
                    enabled = true,
                    mode = "sign",
                },
                treesitter = {
                    enabled = true,
                },
                buf_filter = function(bufnr)
                    local line_cnt = vim.api.nvim_buf_line_count(bufnr)
                    return line_cnt < 4096 and not vim.b[bufnr].large_buf
                end,
                winopt = function(wo)
                    wo.statuscolumn = "%!v:lua.MyStatusCol()"
                end,
                ---@type Neominimap.Map.Handler[]
                handlers = {
                    extmark_handler,
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
}
