return {
  {
    "pwntester/octo.nvim",
    cmd = { "Octo" },
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local c = require("nord.colors").palette
      require("octo").setup({
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
      })
    end,
  },
  {
    "topaxi/gh-actions.nvim",
    keys = {
      { "<leader>ga", "<cmd>GhActions<cr>", desc = "Open Github Actions" },
    },
    -- optional, you can also install and use `yq` instead.
    build = "make",
    opts = {},
  },
}
