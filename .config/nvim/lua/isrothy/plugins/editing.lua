return {
    {
        "iguanacucumber/magazine.nvim",
        name = "nvim-cmp", -- Otherwise highlighting gets messed up
        event = { "InsertEnter", "CmdlineEnter" },
        enabled = false,
        dependencies = {
            { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
            { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
            { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
            { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },

            "https://codeberg.org/FelipeLema/cmp-async-path",

            "hrsh7th/cmp-nvim-lsp-document-symbol",
            -- "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-calc",
            "dmitmel/cmp-cmdline-history",
            "ray-x/cmp-treesitter",
            {
                "tzachar/cmp-fuzzy-buffer",
                dependencies = { "tzachar/fuzzy.nvim" },
            },
            {
                "tzachar/cmp-fuzzy-path",
                dependencies = { "tzachar/fuzzy.nvim" },
            },
            { "lukas-reineke/cmp-under-comparator" },
            { "onsails/lspkind-nvim" },
            { "rcarriga/cmp-dap" },
            { "chrisgrieser/cmp_yanky" },
            {
                "tamago324/cmp-zsh",
                opts = {
                    zshrc = true,
                    filetypes = { "zsh" },
                },
            },
        },

        config = function()
            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            local function get_default_cmp_source()
                local cmp = require("cmp")
                return cmp.config.sources({
                    { name = "lazydev", group_index = 0 },
                    { name = "nvim_lsp" },
                    -- { name = "nvim_lsp_signature_help" },
                    { name = "nvim_lsp_document_symbol" },
                    -- { name = "luasnip" },
                }, {
                    { name = "calc" },
                    { name = "buffer" },
                    { name = "fuzzy_buffer" },
                    { name = "path" },
                    { name = "treesitter" },
                    { name = "cmp_yanky" },
                    { name = "fuzzy_path", option = { fd_timeout_msec = 100 } },
                })
            end

            local kind_icons = {
                Copilot = "",
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            }
            -- nvim-cmp setup
            local cmp = require("cmp")
            local compare = require("cmp.config.compare")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                        -- require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                    -- completion = {
                    -- 	col_offset = -3,
                    -- 	side_padding = 0,
                    -- },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<c-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<c-f>"] = cmp.mapping.scroll_docs(4),
                    ["<c-Space>"] = cmp.mapping.complete(),
                    ["<c-q>"] = cmp.mapping.abort(),
                    ["<cr>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.snippet.active({ direction = 1 }) then
                            vim.schedule(function()
                                vim.snippet.jump(1)
                            end)
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.snippet.active({ direction = -1 }) then
                            vim.schedule(function()
                                vim.snippet.jump(-1)
                            end)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                formatting = {
                    format = function(entry, item)
                        -- This concatonates the icons with the name of the item kind
                        item.kind = string.format("%s %s", kind_icons[item.kind], item.kind)
                        item.menu = ({
                            buffer = "[Buf]",
                            nvim_lsp = "[LSP]",
                            -- luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                            treesitter = "[TS]",
                            fuzzy_buffer = "[FZ]",
                            fuzzy_path = "[FZ]",
                            path = "[Path]",
                            calc = "[Calc]",
                            codeium = "[CDM]",
                            yanky = "[YANK]",
                            dap = "[DAP]",
                            zsh = "[ZSH]",
                        })[entry.source.name]

                        local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
                        item = require("lspkind").cmp_format({
                            with_text = false,
                            maxwidth = 64,
                            mode = "symbol_text",
                            ellipsis_char = "...",
                        })(entry, item)
                        if color_item.abbr_hl_group then
                            item.kind_hl_group = color_item.abbr_hl_group
                            item.kind = color_item.abbr
                        end
                        return item
                    end,
                    fields = { "abbr", "kind", "menu" },
                    expandable_indicator = true,
                },

                sources = get_default_cmp_source(),

                sorting = {
                    priority_weight = 2,
                    comparators = {
                        require("cmp_fuzzy_path.compare"),
                        require("cmp_fuzzy_buffer.compare"),
                        compare.offset,
                        compare.exact,
                        compare.score,
                        require("cmp-under-comparator").under,
                        compare.recently_used,
                        compare.kind,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                    },
                },
                enabled = function()
                    return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
                        or require("cmp_dap").is_dap_buffer()
                end,
            })

            cmp.setup.filetype("lua", {
                sources = cmp.config.sources((function()
                    local sources = get_default_cmp_source()
                    sources[#sources + 1] = { name = "nvim_lua", group_index = 1 }
                    return sources
                end)()),
            })

            cmp.setup.filetype("zsh", {
                sources = cmp.config.sources((function()
                    local sources = get_default_cmp_source()
                    sources[#sources + 1] = { name = "zsh", group_index = 1 }
                    return sources
                end)()),
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "cmp_git" },
                }, {
                    { name = "buffer" },
                }),
            })

            cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                sources = {
                    { name = "dap" },
                },
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "nvim_lsp_document_symbol" },
                    { name = "cmdline_history" },
                    { name = "buffer" },
                    { name = "fuzzy_buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "cmdline" },
                }, {
                    { name = "cmdline_history" },
                    { name = "path" },
                    { name = "fuzzy_path", option = { fd_timeout_msec = 100 } },
                }),
            })
        end,

        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "LargeBuf",
                group = vim.api.nvim_create_augroup("cmp_large_file", { clear = true }),
                callback = function()
                    local cmp = require("cmp")
                    cmp.setup.buffer({
                        sources = {
                            { name = "calc" },
                            -- { name = "buffer" },
                            -- { name = "fuzzy_buffer" },
                        },
                    })
                end,
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        opts = {
            map_bs = true,
            map_c_h = true,
            check_ts = true,
            map_c_w = true,
            map_cr = true,
            enable_check_bracket_line = true,
            ignored_next_char = "[%w%.]",
            disable_filetype = {
                "TelescopePrompt",
                "spectre_panel",
            },
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", "\"", "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                manual_position = true,
                highlight = "Search",
                highlight_grey = "Comment",
            },
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            -- local cmp = require("cmp")
            -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    {
        "saghen/blink.cmp",
        enabled = true,
        lazy = false,
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saghen/blink.compat",
            "mikavilpas/blink-ripgrep.nvim",
        },

        version = "*",
        init = function()
            vim.keymap.set("i", "<c-b>", "<nop>", { silent = true })
            vim.keymap.set("i", "<c-f>", "<nop>", { silent = true })
        end,

        opts = {
            keymap = {
                ["<C-k>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-z>"] = { "cancel" },
                ["<C-e>"] = { "hide" },
                ["<C-y>"] = { "select_and_accept" },
                ["<CR>"] = { "accept", "fallback" },

                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },

                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            },
            highlight = {
                use_nvim_cmp_as_default = true,
            },
            nerd_font_variant = "mono",

            trigger = { signature_help = { enabled = false } },
            accept = {
                create_undo_point = true,
                auto_brackets = {
                    enabled = true,
                    default_brackets = { "(", ")" },
                },
            },
            windows = {
                autocomplete = {
                    auto_show = true,
                    selection = "auto_insert",
                    winblend = vim.o.pumblend,
                    -- padding = { 1, 2 },
                    draw = {
                        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
                        components = {
                            kind_icon = { width = { fill = true } },
                        },
                    },
                },
                documentation = {
                    border = "rounded",
                    direction_priority = {
                        autocomplete_north = { "e", "w", "n", "s" },
                        autocomplete_south = { "e", "w", "s", "n" },
                    },
                    auto_show = true,
                    auto_show_delay_ms = 100,
                    update_delay_ms = 50,
                },
            },

            sources = {
                completion = {
                    enabled_providers = {
                        "lsp",
                        "path",
                        "snippets",
                        "buffer",
                        "ripgrep",
                        "lazydev",
                    },
                },
                providers = {
                    lsp = {
                        fallback_for = { "lazydev" },
                    },
                    ripgrep = {
                        module = "blink-ripgrep",
                        name = "Ripgrep",
                        -- the options below are optional, some default values are shown
                        ---@module "blink-ripgrep"
                        ---@type blink-ripgrep.Options
                        opts = {
                            -- the minimum length of the current word to start searching
                            -- (if the word is shorter than this, the search will not start)
                            prefix_min_len = 3,
                            -- The number of lines to show around each match in the preview window
                            context_size = 5,
                        },
                        score_offset = -3,
                    },
                    snippets = {
                        name = "Snippets",
                        module = "blink.cmp.sources.snippets",
                        score_offset = -3,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 6,
                    },
                    buffer = {
                        name = "Buffer",
                        module = "blink.cmp.sources.buffer",
                        allback_for = { "lsp" },
                    },
                },
            },
        },
    },

    {
        "RRethy/nvim-treesitter-endwise",
        enabled = true,
        event = { "InsertEnter" },
    },

    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            opts = {
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
            },
        },
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = { "BufReadPost", "BufNewFile" },
        init = function()
            local get_option = vim.filetype.get_option
            vim.filetype.get_option = function(filetype, option)
                return option == "commentstring"
                        and require("ts_context_commentstring.internal").calculate_commentstring()
                    or get_option(filetype, option)
            end
        end,
        opts = {
            enable_autocmd = false,
        },
    },
}
