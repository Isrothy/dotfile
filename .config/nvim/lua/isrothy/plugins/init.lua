local is_windows = jit.os:find("Windows")
local packs = {
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },

  --- LSP
  { src = "https://github.com/williamboman/mason.nvim", build = ":MasonUpdate" },
  { src = "https://github.com/neovim/nvim-lspconfig" },

  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/mfussenegger/nvim-lint" },

  -- Treesitter
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
  },

  { src = "https://github.com/Isrothy/lualine-diagnostic-message" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },

  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },

  { src = "https://github.com/folke/which-key.nvim" },

  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  { src = "https://github.com/gbprod/yanky.nvim" },
  { src = "https://github.com/gbprod/substitute.nvim" },
  { src = "https://github.com/monaqa/dial.nvim" },
  { src = "https://github.com/kylechui/nvim-surround", tag = "v4.0.4" },
  { src = "https://github.com/johmsalas/text-case.nvim" },

  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/folke/ts-comments.nvim" },
  { src = "https://github.com/Wansmer/treesj" },

  { src = "https://github.com/gbprod/nord.nvim" },
  { src = "https://github.com/aileot/ex-colors.nvim" },
}
if not is_windows then
  table.insert(packs, { src = "https://github.com/kkharji/sqlite.lua" })
end

vim.pack.add(packs)

require("isrothy.plugins.snacks")
require("isrothy.plugins.treesitter")
require("isrothy.plugins.lsp")
require("isrothy.plugins.filer")
require("isrothy.plugins.lualine")
require("isrothy.plugins.git")
require("isrothy.plugins.which_key")
require("isrothy.plugins.formatter")
require("isrothy.plugins.linter")
require("isrothy.plugins.operators")
require("isrothy.plugins.editing")
require("isrothy.plugins.colorschemes")
