return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    enabled = true,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {},
      ignore_install = {},
      modules = {},
      auto_install = true,
      sync_install = false,
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Around a function" },
            ["if"] = { query = "@function.inner", desc = "Inside a function" },
            ["ac"] = { query = "@class.outer", desc = "Around a class" },
            ["ic"] = { query = "@class.inner", desc = "Inside a class" },
            ["al"] = { query = "@loop.outer", desc = "Around a loop" },
            ["il"] = { query = "@loop.inner", desc = "Inside a loop" },
          },
        },
      },
      indent = {
        enable = false,
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-n>",
          node_incremental = "<c-n>",
          node_decremental = "<c-p>",
          scope_incremental = false,
          -- scope_incremental = "<c-s>",
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("start_treesitter", { clear = true }),
        pattern = {
          "bash",
          "c",
          "cmake",
          "css",
          "cpp",
          "diff",
          "haskell",
          "html",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "lua",
          "luadoc",
          "luap",
          "makefile",
          "markdown",
          "markdown_inline",
          "mysql",
          "ocaml",
          "printf",
          "python",
          "query",
          "regex",
          "rust",
          "sh",
          "sql",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
          "zsh",
        },
        callback = function() vim.treesitter.start() end,
      })
    end,
    -- config = function(_, opts)
    -- require("nvim-treesitter").setup(opts)
    -- vim.treesitter.language.register("bash", "zsh")
    -- end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    enabled = true,
    keys = {
      {
        "af",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end,
        mode = { "x", "o" },
        desc = "Around function",
      },
      {
        "if",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end,
        mode = { "x", "o" },
        desc = "Inside function",
      },
      {
        "ac",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end,
        mode = { "x", "o" },
        desc = "Around class",
      },
      {
        "ic",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end,
        mode = { "x", "o" },
        desc = "Inside class",
      },
      {
        "al",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects") end,
        mode = { "x", "o" },
        desc = "Around loop",
      },
      {
        "il",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects") end,
        mode = { "x", "o" },
        desc = "Inside loop",
      },
    },
    opts = {
      move = {
        set_jumps = true,
      },
      select = {
        lookahead = true,
      },
    },
  },
}
