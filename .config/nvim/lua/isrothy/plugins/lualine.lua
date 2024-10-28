local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "Isrothy/lualine-diagnostic-message",
        "meuter/lualine-so-fancy.nvim",
        "folke/noice.nvim",
    },
}

local tab_size = function()
    return (vim.bo.expandtab and "␠" or "␉") .. vim.bo.tabstop
end

-- Truncating components in smaller window
local trunc = function(trunc_width, trunc_len, hide_width, no_ellipsis)
    return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
            return ""
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
        end
        return str
    end
end

-- Using external source for diff
local diff_source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

M.config = function()
    local c = require("nord.colors").palette

    local minimap_extension = require("neominimap.statusline").lualine_default

    local trouble = require("trouble")
    local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal} ⟩",
        -- The following line is needed to fix the background color
        -- Set it to the lualine section you want to use
        hl_group = "lualine_c_normal",
    })

    require("lualine").setup({
        options = {
            icons_enabled = true,
            -- component_separators = { left = '╲', right = '╱' },
            component_separators = "",
            -- section_separators = { left = "", right = "" },
            section_separators = "",
            disabled_filetypes = {
                statusline = {
                    "dashboard",
                    "alpha",
                },
                winbar = {
                    "neo-tree",
                    "aerial",
                    "packer",
                    "alpha",
                    "dap-repl",
                    "dapui_watches",
                    "dapui_stacks",
                    "dapui_breakpoints",
                    "dapui_scopes",
                    "dapui_colsoles",
                    "trouble",
                    "",
                },
            },
            always_divide_middle = true,
            globalstatus = true,
        },
        sections = {
            lualine_a = {
                { "mode", fmt = trunc(80, 4, nil, true) },
                {
                    require("noice").api.status.command.get,
                    cond = require("noice").api.status.command.has,
                },
                {
                    "fancy_macro",
                    icon = {
                        "⏺",
                        color = { fg = c.polar_night.origin },
                    },
                },
            },
            lualine_b = {
                {
                    "b:gitsigns_head",
                    icon = "",
                },
                {
                    "diff",
                    source = diff_source,
                    colored = true,
                    symbols = {
                        added = " ",
                        modified = " ",
                        removed = " ",
                    },
                },
            },
            lualine_c = {
                -- { require("NeoComposer.ui").status_recording },
                {
                    "filename",
                    file_status = true,
                    newfile_status = true,
                    symbols = {
                        modified = "[+]", -- Text to show when the file is modified.
                        readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                        unnamed = "[UNNAMED]", -- Text to show for unnamed buffers.
                        newfile = "[New]",
                    },
                    fmt = trunc(90, 30, 50),
                    path = 0,
                },
                {
                    "diagnostic-message",
                    icons = {
                        error = " ",
                        warn = " ",
                        hint = " ",
                        info = " ",
                    },
                    first_line_only = true,
                },
            },
            lualine_x = {
                -- mixed_indent,
                -- trailing_whitespace,
                tab_size,
                "encoding",
                {
                    "fileformat",
                    icons_enabled = true,
                    symbols = {
                        unix = " ",
                        dos = " ",
                        mac = " ",
                    },
                },
            },
            lualine_y = {
                "fancy_filetype",
                "fancy_lsp_servers",
            },
            lualine_z = {
                -- {
                --     require("noice").api.status.search.get,
                --     cond = function()
                --         return not vim.b.large_buf and require("noice").api.status.search.has()
                --     end,
                --     color = { fg = c.polar_night.origin },
                -- },
                "searchcount",
                "selectioncount",
                "location",
                "filesize",
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        winbar = {
            lualine_a = {},
            lualine_b = {
                -- {
                -- 	symbols.get,
                -- 	cond = symbols.has,
                -- },
            },
            lualine_c = {
                {
                    symbols.get,
                    cond = symbols.has,
                },
            },
            lualine_x = {
                {
                    "diagnostics",
                    update_in_insert = true,
                    symbols = {
                        error = " ",
                        warn = " ",
                        hint = " ",
                        info = " ",
                    },
                },
            },
            lualine_y = {
                { "filetype", icon_only = true },
                { "filename", fmt = trunc(90, 30, 50), path = 1 },
            },
            lualine_z = {},
        },

        inactive_winbar = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {
                { "filetype", icon_only = true },
                { "filename", fmt = trunc(90, 30, 50), path = 1 },
            },
            lualine_z = {},
        },
        tabline = {},
        extensions = {
            "aerial",
            "lazy",
            "mason",
            "neo-tree",
            "nvim-dap-ui",
            "oil",
            "overseer",
            "quickfix",
            "toggleterm",
            "trouble",
            minimap_extension,
        },
    })
end

return M
