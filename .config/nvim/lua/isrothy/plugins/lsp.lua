return {
  { "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "black",
        "checkmake",
        "cmakelang",
        "hadolint",
        "markdownlint",
        "markdownlint-cli2",
        "prettier",
        "shellharden",
        "shfmt",
        "sqlfluff",
        "stylua",
        "stylua",
        "typstyle",
        "yamlfmt",
      },
      ui = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(
          function()
            require("lazy.core.handler.event").trigger({
              event = "FileType",
              buf = vim.api.nvim_get_current_buf(),
            })
          end,
          100
        )
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "folke/noice.nvim",
    },
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
  },
}
