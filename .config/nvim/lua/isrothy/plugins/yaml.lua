return {
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
    dependencies = {
      "folke/snacks.nvim",
    },
    keys = {
      { "<localleader>y", "", desc = "+Yaml", ft = { "yaml" } },
      { "<localleader>yv", function() require("yaml_nvim").view() end, desc = "View", ft = { "yaml" } },
      { "<localleader>y/", function() require("yaml_nvim").snacks() end, desc = "Search", ft = { "yaml" } },
      {
        "<localleader>yq",
        function()
          require("yaml_nvim").quickfix()
          vim.cmd("copen")
        end,
        desc = "Quickfix",
        ft = { "yaml" },
      },
    },
  },
}
