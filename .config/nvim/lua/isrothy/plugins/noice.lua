return {
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },

  keys = {
    {
      "<S-ENTER>",
      function() require("noice").redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc = "Redirect cmdline",
    },
    {
      "<LEADER>nl",
      function() require("noice").cmd("last") end,
      desc = "Noice last message",
    },
    {
      "<LEADER>nh",
      function() require("noice").cmd("history") end,
      desc = "Noice history",
    },
    {
      "<LEADER>na",
      function() require("noice").cmd("all") end,
      desc = "Noice all",
    },
    {
      "<LEADER>nd",
      function() require("noice").cmd("dismiss") end,
      desc = "Dismiss all",
    },
    {
      "<LEADER>nt",
      function() require("noice").cmd("pick") end,
      desc = "Noice picker (Telescope/FzfLua)",
    },
    {
      "<C-F>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<C-F>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll forward",
      mode = { "i", "n", "s" },
    },
    {
      "<C-B>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<C-B>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll backward",
      mode = { "i", "n", "s" },
    },
  },

  opts = {
    cmdline = {
      enabled = true, -- enables the Noice cmdline UI
      view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      opts = {
        border = {
          -- style = vim.g.neovide and "soid" or "rounded",
        },
      }, -- global options for the cmdline. See section on views
      format = {
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
        calculator = { pattern = "^=", icon = "", lang = "vimnormal" },
        term_run = { pattern = "^:%s*TermRun%s+", icon = "", lang = "bash" },
        input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
      },
    },
    popupmenu = {
      enabled = true,
      backend = "nui",
    },
    messages = {
      enabled = true, -- enables the Noice messages UI
      view = "notify", -- default view for messages
      view_error = "notify", -- view for errors
      view_warn = "notify", -- view for warnings
      view_history = "messages", -- view for :messages
      view_search = false, -- view for search count messages. Set to `false` to disable
    },
    -- You can add any custom commands below that will be available with `:Noice command`
    commands = {
      history = {
        -- options for the message history that you get with `:Noice`
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            { event = "notify" },
            { error = true },
            { warning = true },
            { event = "msg_show", kind = { "" } },
            { event = "lsp", kind = "message" },
          },
        },
      },
      -- :Noice last
      last = {
        view = "popup",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            { event = "notify" },
            { error = true },
            { warning = true },
            { event = "msg_show", kind = { "" } },
            { event = "lsp", kind = "message" },
          },
        },
        filter_opts = { count = 1 },
      },
      -- :Noice errors
      errors = {
        -- options for the message history that you get with `:Noice`
        view = "popup",
        opts = { enter = true, format = "details" },
        filter = { error = true },
        filter_opts = { reverse = true },
      },
    },
    notify = {
      enabled = true,
    },
    lsp = {
      progress = {
        enabled = true,
        throttle = 1000 / 60, -- frequency to update lsp progress message
      },
      override = {
        -- override the default lsp markdown formatter with Noice
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        -- override the lsp markdown formatter with Noice
        ["vim.lsp.util.stylize_markdown"] = true,
        -- override cmp documentation with Noice (needs the other options to work)
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = true,
        silent = true,
        opts = {
          border = {
            style = "rounded",
          },
          scrollbar = true,
        },
      },
      signature = {
        enabled = false,
        opts = {
          border = {
            style = "rounded",
          }, -- merged with defaults from documentation
        },
      },
      message = {
        enabled = true,
        view = "notify",
        opts = {},
      },
      documentation = {
        view = "hover",
      },
    },
    presets = {
      -- you can enable a preset by setting it to true, or a table that will override the preset config
      -- you can also add custom presets that you can enable/disable with enabled=true
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    throttle = 1000 / 60, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.

    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "^nil$",
        },
        opts = { skip = true },
      },
    }, -- @see the section on routes below
  },
}
