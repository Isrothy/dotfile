local ft = {
  "typescript",
  "typescriptreact",
  "typescript.tsx",
  "javascript",
  "javascriptreact",
  "javascript.jsx",
}

return {
  {
    "pmizio/typescript-tools.nvim",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    cmd = {
      "TSToolsOrganizeImports",
      "TSToolsSortImports",
      "TSToolsRemoveUnusedImports",
      "TSToolsRemoveUnused",
      "TSToolsAddMissingImports",
      "TSToolsFixAll",
      "TSToolsGoToSourceDefinition",
      "TSToolsFileReferences",
    },
    keys = {
      { "<localleader>t", "", desc = "+ Typescriptreact tool", ft = ft },
      { "<localleader>ti", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize imports", ft = ft },
      { "<localleader>tf", "<cmd>TSToolsFixAll<cr>", desc = "Fix all", ft = ft },
      { "<localleader>ts", "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "Go to source", ft = ft },
      { "<localleader>tr", "<cmd>TSToolsFileReferences<cr>", desc = "File reference", ft = ft },
    },
    ft = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "javascript",
      "javascriptreact",
      "javascript.jsx",
    },
    opts = {},
  },
}
