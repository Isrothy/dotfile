return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      { "<LEADER>ab", "<CMD>AvanteBuild<CR>", desc = "Build dependencies" },
      { "<LEADER>ac", "<CMD>AvanteChat<CR>", desc = "Chat" },
      { "<LEADER>ae", "<CMD>AvanteEdit<CR>", desc = "Edit", mode = { "x" } },
      { "<LEADER>af", "<CMD>AvanteFocus<CR>", desc = "Focus" },
      { "<LEADER>ak", "<CMD>AvanteClear<CR>", desc = "Clear" },
      { "<LEADER>aq", "<CMD>AvanteAsk<CR>", desc = "Ask AI", mode = { "n", "x" } },
      { "<LEADER>ar", "<CMD>AvanteRefresh<CR>", desc = "Refresh" },
      { "<LEADER>as", "<CMD>AvanteShowRepoMap<CR>", desc = "Show repo map" },
      { "<LEADER>at", "<CMD>AvanteToggle<CR>", desc = "Toggle" },
    },
    opts = {
      provider = "claude",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet-20250219",
        timeout = 30000,
        temperature = 0,
        max_tokens = 64000,
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",
        timeout = 30000,
        temperature = 0.25,
        max_tokens = 4096,
      },
      behaviour = {
        auto_set_highlight_group = true,
        auto_set_keymaps = false,
        auto_apply_diff_after_generation = true,
        support_paste_from_clipboard = true,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
        enable_token_counting = false, -- Whether to enable token counting. Default to true.
      },
      mappings = {
        diff = {
          ours = "<LOCALLEADER>co",
          theirs = "<LOCALLEADER>ct",
          all_theirs = "<LOCALLEADER>cT",
          both = "<LOCALLEADER>cd",
          cursor = "<LOCALLEADER>cc",
          next = "]c",
          prev = "[c",
        },
        jump = {
          next = "]a",
          prev = "[a",
        },
        submit = {
          normal = "<CR>",
          insert = nil,
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
          remove_file = "d",
          add_file = "p",
          close = {},
          close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
        },
        files = {
          add_current = "<LOCALLEADER>aa", -- Add current buffer to selected files
        },
      },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "left",
        sidebar_header = {
          enabled = true,
          align = "left",
          rounded = false,
        },
        edit = {
          border = "rounded",
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = false,
          border = "rounded",
          focus_on_apply = "ours",
        },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
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
      filter = function()
        local blink = require("blink.cmp")
        return not blink.is_visible()
      end,
    },
  },
}
