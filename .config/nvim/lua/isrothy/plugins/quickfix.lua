return {
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {
      keys = {
        {
          "<localleader>qq",
          function() require("quicker").toggle_expand({ before = 2, after = 2, add_to_existing = true }) end,
          desc = "Expand quickfix context",
        },
      },
      type_icons = {
        E = " ",
        W = " ",
        I = " ",
        N = " ",
        H = " ",
      },
    },
  },
}
