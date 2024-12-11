return {
  {
    "Isrothy/satellite.nvim",
    -- dir = "~/satellite.nvim",
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
    opts = {
      current_only = false,
      winblend = 40,
      zindex = 40,
      excluded_filetypes = {
        "",
        "prompt",
        "TelescopePrompt",
        "noice",
        "neominimap",
        "neo-tree",
        "oil",
        "grug-far",
        "bigfile",
        "dbout",
      },
      width = 2,
      handlers = {
        cursor = {
          enable = false,
        },
        search = {
          enable = true,
        },
        diagnostic = {
          enable = true,
          signs = { "-", "=", "≡" },
          min_severity = vim.diagnostic.severity.HINT,
        },
        gitsigns = {
          enable = true,
          signs = { -- can only be a single character (multibyte is okay)
            add = "│",
            change = "│",
            delete = "-",
          },
        },
        marks = {
          enable = true,
          show_builtins = true, -- shows the builtin marks like [ ] < >
        },
      },
    },
  },
}
