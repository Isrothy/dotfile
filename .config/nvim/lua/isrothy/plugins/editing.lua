return {
  {
    "windwp/nvim-autopairs",
    enabled = true,
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
        chars = { "{", "[", "(", "\"", "'" },
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
    "saghen/blink.compat",
    version = "*",
    optional = true,
  },
  {
    "saghen/blink.cmp",
    lazy = true,
    enabled = true,
    version = "v0.*",
    build = "cargo build --release",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saghen/blink.compat",
      "mikavilpas/blink-ripgrep.nvim",
      "kristijanhusak/vim-dadbod-completion",
    },

    init = function()
      vim.keymap.set("i", "<c-b>", "<nop>", { silent = true })
      vim.keymap.set("i", "<c-f>", "<nop>", { silent = true })
    end,

    opts = {
      keymap = {
        preset = "super-tab",
        ["<C-k>"] = { "show", "show_documentation", "hide_documentation" },
      },
      blocked_filetypes = {
        "bigfile",
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "normal",
      },

      completion = {
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
            -- columns = { { "item_idx" }, { "kind_icon" }, { "label", "label_description", gap = 1 } },
            -- components = {
            --     item_idx = {
            --         text = function(ctx)
            --             return tostring(ctx.idx)
            --         end,
            --     },
            -- },
          },
        },
        list = {
          selection = "manual",
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
        completion = {
          enabled_providers = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "ripgrep",
            "lazydev",
            "dadbod",
          },
        },
        providers = {
          lsp = {
            fallback_for = { "lazydev" },
          },
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
            score_offset = 6,
          },
          buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            fallback_for = { "lsp" },
          },
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
          },
        },
      },
    },
  },

  {
    "RRethy/nvim-treesitter-endwise",
    enabled = true,
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
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
    init = function()
      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring"
            and require("ts_context_commentstring.internal").calculate_commentstring()
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
      {
        "<leader>es",
        "<cmd>lua require('treesj').split()<cr>",
        desc = "Split lines",
      },
      {
        "<leader>ej",
        "<cmd>lua require('treesj').join()<cr>",
        desc = "Join lines",
      },
      {
        "<leader>et",
        "<cmd>lua require('treesj').toggle()<cr>",
        desc = "Toggle split/join",
      },
      {
        "<leader>eS",
        "<cmd>lua require('treesj').split({ split = { recursive = true } })<cr>",
        desc = "Split lines recursively",
      },
      {
        "<leader>eT",
        "<cmd>lua require('treesj').toggle({ split = { recursive = true } })<cr>",
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
  {
    "mizlan/iswap.nvim",
    cmd = {
      "ISwap",
      "ISwapWith",
      "ISwapNode",
      "ISwapNodeWith",
      "ISwapNodeWithLeft",
      "ISwapNodeWithRight",
    },
    keys = {
      { "<leader>is", [[<cmd>ISwap<cr>]], desc = "ISwap" },
      { "<leader>iw", [[<cmd>ISwapWith<cr>]], desc = "ISwap with" },
      { "<leader>in", [[<cmd>ISwapNode<cr>]], desc = "ISwap node" },
      { "<leader>im", [[<cmd>ISwapNodeWith<cr>]], desc = "ISwap node with" },
      {
        "<m-i>",
        [[<cmd>ISwapNodeWithLeft<cr>]],
        desc = "ISwap node with left",
        mode = { "n", "v" },
      },
      {
        "<m-o>",
        [[<cmd>ISwapNodeWithRight]],
        desc = "ISwap node with right",
        mode = { "n", "v" },
      },
    },
    opts = {
      flash_style = "simultaneous",
      move_cursor = true,
      autoswap = nil,
      debug = nil,
      hl_grey_priority = "1000",
    },
  },
}
