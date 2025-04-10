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
      select = { enable = false },
    },
    indent = {
      enable = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<S-CR>",
        scope_incremental = false,
        -- scope_incremental = "<c-s>",
      },
    },
    endwise = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    vim.treesitter.language.register("bash", "zsh")
  end,
}
