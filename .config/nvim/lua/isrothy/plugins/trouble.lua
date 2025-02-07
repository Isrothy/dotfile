return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    { "<LEADER>xx", "<CMD>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
    {
      "<LEADER>xX",
      "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
      desc = "Buffer diagnostics (Trouble)",
    },
    { "<LEADER>xL", "<CMD>Trouble loclist toggle<CR>", desc = "Location list (Trouble)" },
    { "<LEADER>xQ", "<CMD>Trouble qflist toggle<CR>", desc = "Quickfix list (Trouble)" },

    -- { "<LEADER><LEADER>s", "<CMD>Trouble symbols toggle<CR>", desc = "Symbols (Trouble)" },
    -- {
    --   "<LEADER><LEADER>S",
    --   "<CMD>Trouble lsp toggle<CR>",
    --   desc = "LSP references/definitions/... (Trouble)",
    -- },

    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").prev({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous Trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next Trouble/quickfix item",
    },
  },
  opts = {
    modes = {
      symbols = {
        desc = "document symbols",
        mode = "lsp_document_symbols",
        focus = false,
        win = { position = "right" },
        filter = {
          -- remove Package since luals uses it for control flow structures
          ["not"] = { ft = "lua", kind = "Package" },
          any = {
            -- all symbol kinds for help / markdown files
            ft = { "help", "markdown" },
            -- default set of symbol kinds
            kind = {
              "Array",
              "Boolean",
              "Class",
              "Constructor",
              "Constant",
              "Enum",
              "EnumMember",
              "Event",
              "Field",
              "File",
              "Function",
              "Interface",
              "Key",
              "Module",
              "Method",
              "Namespace",
              "Number",
              "Object",
              "Package",
              "Property",
              "String",
              "Struct",
              "TypeParameter",
              "Variable",
            },
          },
        },
      },
    },
  },
}
