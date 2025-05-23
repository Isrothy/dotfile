return {
  {
    "nmac427/guess-indent.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "ModeChanged *:[vV\22]",
    keys = {
      {
        "<leader><space>v",
        function() require("visual-whitespace").toggle() end,
        desc = "Visual Whitespace: Toggle",
      },
    },
    init = function()
      vim.g.visual_whitespace = {
        space_char = "·",
        tab_char = "→",
        nl_char = "↲",
        unix_char = "↲",
        mac_char = "←",
        dos_char = "↙",
        excluded = {
          filetypes = { "toggleterm" },
          buftypes = { "terminal" },
        },
      }
    end,
  },

  {
    "Isrothy/indent-blankline.nvim",
    enabled = false,
    main = "ibl",
    keys = {
      {
        "ai",
        function() require("ibl.textobjects").around() end,
        desc = "Around indent",
        mode = { "o", "x" },
      },
      {
        "aI",
        function() require("ibl.textobjects").around({ entire_line = true }) end,
        desc = "Around indent",
        mode = { "o", "x" },
      },
      {
        "ii",
        function() require("ibl.textobjects").inside() end,
        desc = "Inside indent",
        mode = { "o", "x" },
      },
    },
    opts = {
      indent = {
        char = "▎",
        tab_char = "▎",
        smart_indent_cap = true,
      },
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        include = {
          node_type = {
            c = {
              "enum_specifier",
            },
            cpp = {
              "enum_specifier",
            },
            lua = {
              "do_statement",
              "arguments",
              "while_statement",
              "if_statement",
              "for_statement",
              "function_declaration",
              "function_definition",
              "table_constructor",
              "assignment_statement",
            },
            python = {
              "if_statement",
              "for_statement",
              "while_statement",
              "function_definition",
              "dictionary",
              "list",
            },
            rust = {
              "if_statement",
              "for_statement",
              "while_statement",
              "function_definition",
            },
            typescript = {
              "statement_block",
              "function",
              "arrow_function",
              "function_declaration",
              "method_definition",
              "for_statement",
              "for_in_statement",
              "catch_clause",
              "object_pattern",
              "arguments",
              "switch_case",
              "switch_statement",
              "switch_default",
              "object",
              "object_type",
              "ternary_expression",
            },
          },
        },
      },
    },
    config = function(_, opts)
      local hooks = require("ibl.hooks")
      -- hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
    init = function() vim.opt.list = true end,
  },
}
