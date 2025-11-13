return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", desc = "Add to chat" },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat buffer" },
      { "<leader>ae", "<cmd>CodeCompanion /explain<cr>", desc = "Explain", mode = { "n", "x" } },
      { "<leader>af", "<cmd>CodeCompanion /fix<cr>", desc = "Fix", mode = { "n", "x" } },
      { "<leader>ak", "<cmd>CodeCompanion /commit<cr>", desc = "Commit" },
      { "<leader>ax", "<cmd>CodeCompanion /lsp<cr>", desc = "Diagnostics", mode = { "n", "x" } },
      { "<leader>an", "<cmd>CodeCompanionChat<cr>", desc = "New chat buffer" },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", desc = "Pick an action" },
      { "<leader>at", "<cmd>CodeCompanion /test<cr>", desc = "Test", mode = { "n", "x" } },
      { "<leader>aw", "<cmd>CodeCompanion /workspace<cr>", desc = "Wrokspace" },
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanionRequestStarted",
        group = vim.api.nvim_create_augroup("codecompanion_request_started", { clear = true }),
        callback = function() vim.notify("Request sent", vim.log.levels.INFO, { title = "CodeCompanion" }) end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanionRequestFinished",
        group = vim.api.nvim_create_augroup("codecompanion_request_finished", { clear = true }),
        callback = function() vim.notify("Request finished", vim.log.levels.INFO, { title = "CodeCompanion" }) end,
      })
    end,
    opts = {
      strategies = {
        chat = {
          adapter = "gemini_cli",
          keymaps = {
            send = {
              modes = { n = "<cr>" },
            },
            close = {
              modes = { n = "<c-c>" },
            },
          },
        },
        inline = {
          adapter = "gemini",
          keymaps = {
            always_accept = {
              modes = { n = "y" },
              opts = { nowait = true },
              description = "Always Accept",
            },
            accept_change = {
              modes = { n = "a" },
              opts = { nowait = true },
              description = "Accept",
            },
            reject_change = {
              modes = { n = "r" },
              opts = { nowait = true },
              description = "Reject",
            },
          },
        },
        cmd = {
          adapter = "gemini",
        },
        display = {
          diff = {
            enabled = true,
            layout = "vertical",
            opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
            provider = "default",
          },
          action_palette = {
            provider = "snacks",
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

        acp = {
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              env = {
                api_key = "GEMINI_API_KEY",
              },
              defaults = {
                auth_method = "gemini-api-key",
              },
            })
          end,
        },
        http = {
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = "GEMINI_API_KEY",
              },
            })
          end,
          ["gemma"] = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "gemma",
              schema = {
                model = {
                  default = "gemma3:27b-it-qat",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
        },
      },
      memory = {
        opts = {
          chat = {
            enabled = true,
          },
        },
      },
    },
  },
  {
    "Exafunction/windsurf.nvim",
    enabled = true,
    event = "VeryLazy",
    cmds = { "Codeium" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    name = "codeium",
    opts = {
      enable_chat = false,
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        filetypes = {
          help = false,
          gitcommit = false,
          gitrebase = false,
          DressingInput = false,
          bigfile = false,
          snacks_picker_input = false,
          ["."] = false,
        },
        default_filetype_enabled = true,
        map_keys = true,
        key_bindings = {
          accept = "<c-;>",
          accept_word = "<c-o>",
          accept_line = "<c-l>",
          clear = "<c-'>",
          next = "<c-.>",
          prev = "<c-,>",
        },
      },
    },
  },
}
