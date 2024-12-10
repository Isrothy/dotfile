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
      vim.keymap.set("i", "<C-;>", neocodeium.accept)
      vim.keymap.set("i", "<C-O>", neocodeium.accept_word)
      vim.keymap.set("i", "<C-L>", neocodeium.accept_line)
      vim.keymap.set("i", "<C-.>", neocodeium.cycle_or_complete)
      vim.keymap.set("i", "<C-,>", function()
        neocodeium.cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<C-'>", neocodeium.clear)
    end,
  },
}
