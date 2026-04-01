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
