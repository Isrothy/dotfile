return {
  {
    "pwntester/octo.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Octo" },
    keys = {
      { "<leader>Gi", "<cmd>Octo issue list<cr>", desc = "List issues (Octo)" },
      { "<leader>GI", "<cmd>Octo issue search<cr>", desc = "Search issues (Octo)" },
      { "<leader>Gp", "<cmd>Octo pr list<cr>", desc = "List PRs (Octo)" },
      { "<leader>GP", "<cmd>Octo pr search<cr>", desc = "Search PRs (Octo)" },
      { "<leader>Gr", "<cmd>Octo repo list<cr>", desc = "List repos (Octo)" },
      { "<leader>GS", "<cmd>Octo search<cr>", desc = "Search (Octo)" },

      { "<localleader>a", "", desc = "+assignee (Octo)", ft = "octo" },
      { "<localleader>c", "", desc = "+comment/code (Octo)", ft = "octo" },
      { "<localleader>l", "", desc = "+label (Octo)", ft = "octo" },
      { "<localleader>i", "", desc = "+issue (Octo)", ft = "octo" },
      { "<localleader>r", "", desc = "+react (Octo)", ft = "octo" },
      { "<localleader>p", "", desc = "+pr (Octo)", ft = "octo" },
      { "<localleader>pr", "", desc = "+rebase (Octo)", ft = "octo" },
      { "<localleader>ps", "", desc = "+squash (Octo)", ft = "octo" },
      { "<localleader>v", "", desc = "+review (Octo)", ft = "octo" },
      { "<localleader>g", "", desc = "+goto_issue (Octo)", ft = "octo" },
      { "@", "@<c-x><c-o>", mode = "i", ft = "octo", silent = true },
      { "#", "#<c-x><c-o>", mode = "i", ft = "octo", silent = true },
    },
    opts = function()
      local c = require("nordify.palette")["dark"]
      -- local c = require("nord.colors").palette ---@type Nord.Palette
      return {
        picker = "snacks",
        colors = {
          white = c.snow_storm.origin,
          grey = c.polar_night.brighter,
          black = c.polar_night.origin,
          red = c.aurora.orange,
          dark_red = c.aurora.red,
          green = c.aurora.red,
          dark_green = "#238636",
          yellow = c.aurora.yellow,
          dark_yellow = "#735c0f",
          blue = c.frost.artic_water,
          dark_blue = c.frost.artic_ocean,
          purple = c.aurora.purple,
        },
      }
    end,
  },
}
