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
      display = {
        diff = {
          enabled = true,
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "default",
        },
        action_palette = {
          provider = "snacks",
        },
        chat = {
          window = {
            layout = "buffer", -- float|vertical|horizontal|buffer
          },
          intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
          show_header_separator = false,
          show_references = true,
          show_settings = true,
          show_token_count = true,
          start_in_insert_mode = false,
        },
      },
      strategies = {
        chat = {
          adapter = "gemini",
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
              schema = {
                model = {
                  default = "gemini-3-flash-preview",
                },
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
    "monkoose/neocodeium",
    event = "VeryLazy",
    keys = {
      { "<c-l>", function() require("neocodeium").accept() end, desc = "Accept", mode = "i" },
      { "<c-]>", function() require("neocodeium").cancel() end, desc = "Cancel", mode = "i" },
      { "<c-j>", function() require("neocodeium").cycle(1) end, desc = "Next", mode = "i" },
      { "<c-k>", function() require("neocodeium").cycle(-1) end, desc = "Prev", mode = "i" },
      { "<leader>as", function() end },
    },
    opts = {
      show_label = true,
      debounce = true,
    },
    init = function()
      vim.api.nvim_create_user_command("NeoCodeiumStatus", function()
        local ok, neocodeium = pcall(require, "neocodeium")
        if not ok then
          vim.notify("NeoCodeium plugin not found!", vim.log.levels.ERROR)
          return
        end

        local status, server_status = neocodeium.get_status()

        local plugin_states = {
          [0] = { text = "Enabled", icon = " ", hl = "DiagnosticOk" },
          [1] = { text = "Globally Disabled", icon = " ", hl = "Comment" },
          [2] = { text = "Buffer Disabled (Command)", icon = "󰅙 ", hl = "DiagnosticWarn" },
          [3] = { text = "Buffer Disabled (Filetype)", icon = " ", hl = "DiagnosticWarn" },
          [4] = { text = "Buffer Disabled (Filter)", icon = " ", hl = "DiagnosticWarn" },
          [5] = { text = "Encoding Error", icon = "𝓐 ", hl = "DiagnosticError" },
          [6] = { text = "Special Buftype", icon = " ", hl = "Comment" },
        }

        local server_states = {
          [0] = { text = "Running", icon = " ", hl = "DiagnosticOk" },
          [1] = { text = "Connecting...", icon = " ", hl = "DiagnosticWarn" },
          [2] = { text = "Stopped", icon = " ", hl = "Comment" },
        }

        local p_info = plugin_states[status] or { text = "Unknown", icon = "?", hl = "DiagnosticError" }
        local s_info = server_states[server_status] or { text = "Unknown", icon = "?", hl = "DiagnosticError" }

        local lines = {
          "",
          "  Plugin Status: " .. p_info.icon .. " " .. p_info.text,
          "  Server Status: " .. s_info.icon .. " " .. s_info.text,
          "",
          "  [q] to close",
        }

        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

        local width = 40
        local height = #lines
        local ui = vim.api.nvim_list_uis()[1]
        local row = math.floor((ui.height - height) / 2)
        local col = math.floor((ui.width - width) / 2)

        vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          row = row,
          col = col,
          style = "minimal",
          border = "rounded",
          title = " NeoCodeium ",
          title_pos = "center",
        })

        local ns_id = vim.api.nvim_create_namespace("NeoCodeiumStatus")
        vim.api.nvim_buf_set_extmark(buf, ns_id, 1, 17, {
          end_col = #lines[2],
          hl_group = p_info.hl,
        })

        vim.api.nvim_buf_set_extmark(buf, ns_id, 2, 17, {
          end_col = #lines[3],
          hl_group = s_info.hl,
        })

        vim.api.nvim_buf_set_extmark(buf, ns_id, 4, 2, {
          end_col = #lines[5],
          hl_group = "Comment",
        })

        local opts = { buffer = buf, nowait = true, silent = true }
        vim.keymap.set("n", "q", "<cmd>close<cr>", opts)
        vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", opts)

        vim.bo[buf].modifiable = false
        vim.bo[buf].bufhidden = "wipe"
      end, {})
    end,
  },
  {
    "Exafunction/windsurf.nvim",
    enabled = false,
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
          accept = "<c-l>",
          -- accept_word = "<m-o>",
          -- accept_line = "<m-l>",
          clear = "<c-]>",
          next = "<c-j>",
          prev = "<c-k>",
        },
      },
    },
  },
}
