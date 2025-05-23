return {
  {
    "pmizio/typescript-tools.nvim",
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
      { "<localleader>t", "", desc = "+ Typescriptreact tool" },
      { "<localleader>ti", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize imports" },
      { "<localleader>tf", "<cmd>TSToolsFixAll<cr>", desc = "Fix all" },
      { "<localleader>ts", "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "Go to source" },
      { "<localleader>tr", "<cmd>TSToolsFileReferences<cr>", desc = "File reference" },
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
