local swift = {
    { "keith/swift.vim", ft = { "swift" } },
}

local kitty = {
    { "fladson/vim-kitty", ft = { "kitty" } },
}

local typst = {
    { "kaarmu/typst.vim", ft = { "typst" } },
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "0.3.*",
        build = function()
            require("typst-preview").update()
        end,
        opts = {
            debug = false,
            get_root = function(path_of_main_file)
                return vim.fn.fnamemodify(path_of_main_file, ":p:h")
            end,
        },
    },
}

local log = {
    {
        "fei6409/log-highlight.nvim",
        ft = { "log" },
    },
}

local pkl = {
    {
        "https://github.com/apple/pkl-neovim",
        event = "BufReadPre *.pkl",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        build = function()
            vim.cmd("TSInstall! pkl")
        end,
    },
}

local markdown = {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        config = function()
            local home = os.getenv("HOME")
            vim.g.mkdp_markdown_css = home .. "/.config/nvim/style/markdown.css"
            vim.g.mkdp_highlight_css = home .. "/.config/nvim/style/highlight.css"
            vim.g.mkdp_theme = "dark"
            vim.g.mkdp_auto_close = 1
        end,
    },
    {
        "Kicamon/markdown-table-mode.nvim",
        ft = { "markdown" },
        config = function()
            require("markdown-table-mode").setup()
        end,
    },

    {
        "OXY2DEV/markview.nvim",
        ft = { "markdown", "quarto", "rmd" }, -- If you decide to lazy-load anyway
        enabled = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            initial_state = false,
        },
    },
    {
        "jmbuhr/otter.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        init = function()
            vim.api.nvim_create_user_command("OtterActivate", function()
                require("otter").activate()
            end, {
                desc = "Activate Otter",
            })
        end,
        config = function()
            require("otter").setup({
                lsp = {
                    diagnostic_update_events = { "BufWritePost" },
                    -- function to find the root dir where the otter-ls is started
                    root_dir = function(_, bufnr)
                        return vim.fs.root(bufnr or 0, {
                            ".git",
                            "_quarto.yml",
                            "package.json",
                        }) or vim.fn.getcwd(0)
                    end,
                },
                buffers = {
                    -- if set to true, the filetype of the otterbuffers will be set.
                    -- otherwise only the autocommand of lspconfig that attaches
                    -- the language server will be executed without setting the filetype
                    set_filetype = false,
                    -- write <path>.otter.<embedded language extension> files
                    -- to disk on save of main buffer.
                    -- usefule for some linters that require actual files
                    -- otter files are deleted on quit or main buffer close
                    write_to_disk = false,
                },
                strip_wrapping_quote_characters = { "'", "\"", "`" },
                handle_leading_whitespace = true,
            })
        end,
    },
}

local yaml = {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
    },
}
local help = {
    "OXY2DEV/helpview.nvim",
    ft = "help",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
}

local cmake = {
    "Civitasv/cmake-tools.nvim",
    init = function()
        local loaded = false
        local function check()
            local cwd = vim.uv.cwd()
            if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
                require("lazy").load({ plugins = { "cmake-tools.nvim" } })
                loaded = true
            end
        end
        check()
        vim.api.nvim_create_autocmd("DirChanged", {
            callback = function()
                if not loaded then
                    check()
                end
            end,
        })
    end,
    opts = {},
}

return {
    swift,
    cmake,
    kitty,
    typst,
    log,
    pkl,
    markdown,
    yaml,
    help,
}
