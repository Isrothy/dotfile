return {
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
    cmd = { "JqxList", "JqxQuery" },
    keys = {
      { "<LOCALLEADER>j", "", desc = "+Jqx", ft = { "json", "yaml" } },
      { "<LOCALLEADER>jl", "<CMD>JqxList<CR>", desc = "Jqx list", ft = { "json", "yaml" } },
    },
  },
  {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc", "yaml" },
  },
}
