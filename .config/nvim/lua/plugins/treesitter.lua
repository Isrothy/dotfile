local M = {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",
}

M.config = function()
    require("nvim-treesitter.configs").setup({
        -- One of "all", "maintained" (parsers with maintainers), or a list of languages
        ensure_installed = { "c", "cpp", "java" },

        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,

        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "gni",
                scope_incremental = "gsi",
                node_decremental = "gnd",
            },
        },
        indent = {
            enable = true,
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        -- autotag = {
        -- 	enable = true,
        -- },
        endwise = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]#"] = "@conditional.outer",
                    ["]l"] = "@loop.outer",
                    ["]b"] = "@block.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]B"] = "@block.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[#"] = "@conditional.outer",
                    ["[l"] = "@loop.outer",
                    ["[b"] = "@block.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[B"] = "@block.outer",
                },
            },
        },
    })
end

return M
