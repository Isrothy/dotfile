return {
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Octo" },
    keys = {
      { "<LEADER>gi", "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
      { "<LEADER>gI", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
      { "<LEADER>gp", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
      { "<LEADER>gP", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
      { "<LEADER>gr", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
      { "<LEADER>gS", "<cmd>Octo search<CR>", desc = "Search (Octo)" },

      { "<LOCALLEADER>a", "", desc = "+assignee (Octo)", ft = "octo" },
      { "<LOCALLEADER>c", "", desc = "+comment/code (Octo)", ft = "octo" },
      { "<LOCALLEADER>l", "", desc = "+label (Octo)", ft = "octo" },
      { "<LOCALLEADER>i", "", desc = "+issue (Octo)", ft = "octo" },
      { "<LOCALLEADER>r", "", desc = "+react (Octo)", ft = "octo" },
      { "<LOCALLEADER>p", "", desc = "+pr (Octo)", ft = "octo" },
      { "<LOCALLEADER>pr", "", desc = "+rebase (Octo)", ft = "octo" },
      { "<LOCALLEADER>ps", "", desc = "+squash (Octo)", ft = "octo" },
      { "<LOCALLEADER>v", "", desc = "+review (Octo)", ft = "octo" },
      { "<LOCALLEADER>g", "", desc = "+goto_issue (Octo)", ft = "octo" },
      { "@", "@<C-X><C-O>", mode = "i", ft = "octo", silent = true },
      { "#", "#<C-X><C-O>", mode = "i", ft = "octo", silent = true },
    },
    config = function()
      local c = require("nordify.palette")["dark"]
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
      { "<LEADER>ga", "<CMD>GhActions<CR>", desc = "Open Github Actions" },
    },
    -- optional, you can also install and use `yq` instead.
    build = "make",
    opts = {},
  },
}
