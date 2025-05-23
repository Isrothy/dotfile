local clangdft = { "c", "cpp", "objc", "objcpp", "cuda" }

return {
  {
    "p00f/clangd_extensions.nvim",
    ft = clangdft,
    cmd = {
      "ClangdSwitchSourceHeader",
      "ClangdAST",
      "ClangdSymbolInfo",
      "ClangdTypeHierarchy",
      "ClangdMemoryUsage",
    },
    keys = {
      { "<localleader>c", "", desc = "+Clangd", ft = clangdft },
      { "<localleader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch source header", ft = clangdft },
      { "<localleader>ca", "<cmd>ClangdAST<cr>", desc = "AST", ft = clangdft },
      { "<localleader>ci", "<cmd>ClangdSymbolInfo<cr>", desc = "Symbol info", ft = clangdft },
      { "<localleader>ct", "<cmd>ClangdTypeHierarchy<cr>", desc = "Type hierarchy", ft = clangdft },
      { "<localleader>cm", "<cmd>ClangdMemoryUsage<cr>", desc = "Memory usage", ft = clangdft },
    },
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = {
          inline = vim.fn.has("nvim-0.10") == 1,
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_parameter_hints = true,
          parameter_hints_prefix = "<- ",
          other_hints_prefix = "=> ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 7,
          highlight = "Comment",
          priority = 100,
        },
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },

          kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
          },

          highlights = { detail = "Comment" },
        },
      })
    end,
  },
}
