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
