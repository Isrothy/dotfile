return {
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
    cmd = { "JqxList", "JqxQuery" },
    keys = {
      { "<localleader>j", "", desc = "+Jqx", ft = { "json", "yaml" } },
      { "<localleader>jl", "<cmd>JqxList<cr>", desc = "Jqx list", ft = { "json", "yaml" } },
    },
  },
  {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc", "yaml" },
  },
}
