local swift = {
    { "keith/swift.vim", ft = { "swift" } },
}

local kotlin = {
    { "udalov/kotlin-vim", ft = { "kotlin" } },
}

local kitty = {
    { "fladson/vim-kitty", ft = { "kitty" } },
}

local typst = {
    { "kaarmu/typst.vim", ft = { "typst" } },
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        lazy = true,
        version = "0.3.*",
        -- version = "0.1.*",
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
    { "mtdl9/vim-log-highlighting", ft = { "log" } },
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
}

local yaml = {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
    },
}

return {
    swift,
    kotlin,
    kitty,
    typst,
    log,
    pkl,
    markdown,
    yaml,
}
