return {
  {
    "saghen/blink.cmp",
    version = "v0.*",
    build = "cargo build --release",
    event = { "InsertEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saghen/blink.compat",
      "mikavilpas/blink-ripgrep.nvim",
      "kristijanhusak/vim-dadbod-completion",
    },

    init = function()
      vim.keymap.set("i", "<C-B>", "<NOP>", { silent = true })
      vim.keymap.set("i", "<C-F>", "<NOP>", { silent = true })
    end,

    opts = {
      keymap = {
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-K>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      enabled = function() return not vim.tbl_contains({ "bigfile" }, vim.bo.filetype) and vim.bo.buftype ~= "prompt" end,
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },

      completion = {
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        accept = {
          create_undo_point = true,
          auto_brackets = {
            enabled = true,
            default_brackets = { "(", ")" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 50,
          update_delay_ms = 50,
          treesitter_highlighting = true,
          window = {
            border = "rounded",
            winblend = 0,
            scrollbar = true,
          },
        },
      },

      signature = {
        enabled = true,
        window = {
          border = "rounded",
          scrollbar = true, -- Note that the gutter will be disabled when border ~= 'none'
        },
      },

      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "ripgrep",
          "ecolog",
        },
        per_filetype = {
          lua = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "ripgrep",
            "lazydev",
          },
          sql = {
            "snippets",
            "ripgrep",
            "dadbod",
          },
          mysql = {
            "snippets",
            "ripgrep",
            "dadbod",
          },
        },
        providers = {
          lsp = {},
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              -- the minimum length of the current word to start searching
              -- (if the word is shorter than this, the search will not start)
              prefix_min_len = 3,
              -- The number of lines to show around each match in the preview window
              context_size = 5,
            },
            score_offset = -3,
          },
          snippets = {
            name = "Snippets",
            module = "blink.cmp.sources.snippets",
            score_offset = -3,
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 9,
          },
          buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            -- fallbacks = { "lsp" },
          },
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
          },
          ecolog = {
            name = "ecolog",
            module = "ecolog.integrations.cmp.blink_cmp",
          },
        },
      },
    },
  },
  {
    "saghen/blink.compat",
    version = "*",
    optional = true,
  },
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {
      map_bs = true,
      map_c_h = true,
      check_ts = true,
      map_c_w = true,
      map_cr = true,
      enable_check_bracket_line = true,
      ignored_next_char = "[%w%.]",
      disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
      },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      -- local cmp = require("cmp")
      -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "RRethy/nvim-treesitter-endwise",
    event = { "InsertEnter" },
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
    opts = {
      opts = {
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    init = function()
      local get_option = vim.filetype.get_option
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "Wansmer/treesj",
    cmd = { "TSJSplit", "TSJSplit", "TSJToggle" },
    keys = {
      { "<LEADER>js", "<CMD>lua require('treesj').split()<CR>", desc = "Split" },
      { "<LEADER>jj", "<CMD>lua require('treesj').join()<CR>", desc = "Join" },
      { "<LEADER>jt", "<CMD>lua require('treesj').toggle()<CR>", desc = "Toggle" },
      {
        "<LEADER>jS",
        "<CMD>lua require('treesj').split({ split = { recursive = true } })<CR>",
        desc = "Split recursively",
      },
      {
        "<LEADER>jT",
        "<CMD>lua require('treesj').toggle({ split = { recursive = true } })<CR>",
        desc = "Toggle split/join recursively",
      },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 0xffffffff,
    },
  },
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "Neogen",
    opts = {
      snippet_engine = "nvim",
    },
  },
}
