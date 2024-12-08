return {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    opts = {
      enabled = true,
      show_label = true,
      debounce = true,
      silent = true,
      max_lines = -1,
      filetypes = {
        help = false,
        gitcommit = false,
        gitrebase = false,
        DressingInput = false,
        bigfile = false,
        ["."] = false,
      },
    },
    config = function(_, opts)
      local neocodeium = require("neocodeium")
      neocodeium.setup(opts)
      vim.keymap.set("i", "<c-;>", neocodeium.accept)
      vim.keymap.set("i", "<c-o>", neocodeium.accept_word)
      vim.keymap.set("i", "<c-l>", neocodeium.accept_line)
      vim.keymap.set("i", "<c-.>", neocodeium.cycle_or_complete)
      vim.keymap.set("i", "<c-,>", function()
        neocodeium.cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<c-'>", neocodeium.clear)
    end,
  },
}
