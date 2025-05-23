return {
  "nvim-treesitter/nvim-treesitter",
  event = { "VeryLazy" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  lazy = vim.fn.argc(-1) == 0,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {},
    ignore_install = {},
    modules = {},
    auto_install = true,
    sync_install = false,
    matchup = {
      enable = false,
      disable_virtual_text = true,
      include_match_words = false,
    },
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
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    vim.treesitter.language.register("bash", "zsh")
  end,
}
