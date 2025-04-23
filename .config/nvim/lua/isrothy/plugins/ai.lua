return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<LEADER>aa", "<cmd>CodeCompanionChat Add<cr>", desc = "Add to chat" },
      { "<LEADER>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat buffer" },
      { "<LEADER>ae", "<cmd>CodeCompanion /explain<cr>", desc = "Explain", mode = { "n", "x" } },
      { "<LEADER>af", "<cmd>CodeCompanion /fix<cr>", desc = "Fix", mode = { "n", "x" } },
      { "<LEADER>ak", "<cmd>CodeCompanion /commit<cr>", desc = "Commit" },
      { "<LEADER>ax", "<cmd>CodeCompanion /lsp<cr>", desc = "Diagnostics", mode = { "n", "x" } },
      { "<LEADER>an", "<cmd>CodeCompanionChat<cr>", desc = "New chat buffer" },
      { "<LEADER>ap", "<cmd>CodeCompanionActions<cr>", desc = "Pick an action" },
      { "<LEADER>at", "<cmd>CodeCompanion /test<cr>", desc = "Test", mode = { "n", "x" } },
      { "<LEADER>aw", "<cmd>CodeCompanion /workspace<cr>", desc = "Wrokspace" },
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "gemini-2.5-flash",
          keymaps = {
            send = {
              modes = { n = "<CR>" },
            },
            close = {
              modes = { n = "<C-c>" },
            },
          },
        },
        inline = {
          adapter = "gemini-2.5-flash",
        },
        cmd = {
          adapter = "gemini-2.5-flash",
        },
        display = {
          diff = {
            enabled = true,
            layout = "vertical",
            opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
            provider = "default",
          },
          chat = {
            intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
            show_header_separator = false,
            show_references = true,
            show_settings = true,
            show_token_count = true,
            start_in_insert_mode = false,
          },
        },
      },
      adapters = {
        ["gemini-2.5-pro"] = function()
          return require("codecompanion.adapters").extend("gemini", {
            name = "gemini-2.5-pro",
            schema = {
              model = {
                default = "gemini-2.5-pro-exp-03-25",
              },
            },
          })
        end,
        ["gemini-2.5-flash"] = function()
          return require("codecompanion.adapters").extend("gemini", {
            name = "gemini-2.5-flash",
            schema = {
              model = {
                default = "gemini-2.5-flash-preview-04-17",
              },
            },
          })
        end,
      },
    },
  },
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    keys = {
      { "<C-;>", function() require("neocodeium").accept() end, mode = { "i" } },
      { "<C-O>", function() require("neocodeium").accept_word() end, mode = { "i" } },
      { "<C-L>", function() require("neocodeium").accept_line() end, mode = { "i" } },
      { "<C-.>", function() require("neocodeium").cycle_or_complete() end, mode = { "i" } },
      { "<C-,>", function() require("neocodeium").cycle_or_complete(-1) end, mode = { "i" } },
      { "<C-'>", function() require("neocodeium").clear() end, mode = { "i" } },
    },
    opts = {
      enabled = true,
      show_label = false,
      debounce = true,
      silent = true,
      max_lines = -1,
      filetypes = {
        help = false,
        gitcommit = false,
        gitrebase = false,
        DressingInput = false,
        bigfile = false,
        snacks_picker_input = false,
        ["."] = false,
      },
    },
  },
}
