return {
  {
    "nmac427/guess-indent.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "ModeChanged *:[vV\22]",
    keys = {
      {
        "<leader><space>v",
        function() require("visual-whitespace").toggle() end,
        desc = "Visual Whitespace: Toggle",
      },
    },
    init = function()
      vim.g.visual_whitespace = {
        space_char = "·",
        tab_char = "→",
        nl_char = "↲",
        unix_char = "↲",
        mac_char = "←",
        dos_char = "↙",
        excluded = {
          filetypes = { "toggleterm" },
          buftypes = { "terminal" },
        },
      }
    end,
  },
}
