local typescript_ft = {
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
      { "<localleader>t", "", desc = "+ Typescriptreact tool", ft = typescript_ft },
      { "<localleader>ti", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize imports", ft = typescript_ft },
      { "<localleader>tf", "<cmd>TSToolsFixAll<cr>", desc = "Fix all", ft = typescript_ft },
      { "<localleader>ts", "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "Go to source", ft = typescript_ft },
      { "<localleader>tr", "<cmd>TSToolsFileReferences<cr>", desc = "File reference", ft = typescript_ft },
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
