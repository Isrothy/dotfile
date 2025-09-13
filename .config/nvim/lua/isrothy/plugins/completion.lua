return {
  {
    "saghen/blink.cmp",
    version = "v1.*",
    build = "cargo build --release",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saghen/blink.compat",
      "mikavilpas/blink-ripgrep.nvim",
      "kristijanhusak/vim-dadbod-completion",
      "philosofonusus/ecolog.nvim",
    },

    init = function()
      vim.keymap.set("i", "<c-b>", "<nop>", { silent = true })
      vim.keymap.set("i", "<c-f>", "<nop>", { silent = true })
    end,

    opts = {
      keymap = {
        ["<tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<s-tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<cr>"] = { "accept", "fallback" },
        ["<c-k>"] = { "show", "show_documentation", "hide_documentation" },
        ["<c-x>"] = { "cancel" },
        ["<c-p>"] = { "select_prev", "fallback" },
        ["<c-n>"] = { "select_next", "fallback" },

        -- ["<c-b>"] = { "scroll_documentation_up", "fallback" },
        -- ["<c-f>"] = { "scroll_documentation_down", "fallback" },
      },
      enabled = function() return not vim.tbl_contains({ "bigfile" }, vim.bo.filetype) and vim.bo.buftype ~= "prompt" end,
      cmdline = {
        enabled = true,
        completion = { ghost_text = { enabled = true } },
        keymap = {
          ["<m-l>"] = {
            function(cmp)
              if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
                return cmp.accept()
              end
            end,
            "fallback",
          },
          ["<cr>"] = {
            function(cmp)
              if not (cmp.is_ghost_text_visible() and not cmp.is_menu_visible()) then
                return cmp.accept()
              end
            end,
            "fallback",
          },
          ["<tab>"] = {
            "show_and_insert",
            "select_next",
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },
      completion = {
        menu = {
          border = "none",
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        triggers = {
          show_on_backspace = true,
          show_on_backspace_in_keyword = true,
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
            winblend = 0,
            scrollbar = true,
          },
        },
      },

      signature = {
        enabled = true,
        window = {
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
          tex = {
            "vimtex",
          },
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
          javascript = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "ripgrep",
            "ecolog",
            "ripgrep",
            "dadbod",
          },
          markdown = {
            "markdown",
          },
        },
        providers = {
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
          },
          vimtex = {
            name = "vimtex",
            module = "blink.compat.source",
          },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
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
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
        },
      },
    },
  },
}
