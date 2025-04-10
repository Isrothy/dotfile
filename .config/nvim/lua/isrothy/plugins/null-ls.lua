return {
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        border = "rounded",
        sources = {
          null_ls.builtins.diagnostics.checkmake,
          null_ls.builtins.diagnostics.cmake_lint,
          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.markdownlint_cli2,
          null_ls.builtins.diagnostics.zsh,

          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.cmake_format,
          null_ls.builtins.formatting.markdownlint,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.shellharden.with({ filetypes = { "sh", "bash", "zsh" } }),
          null_ls.builtins.formatting.sqlfluff.with({ extra_args = { "--dialect", "mysql" } }),
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.typstyle,
          null_ls.builtins.formatting.yamlfmt,
        },
      })
    end,
  },
}
