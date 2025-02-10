return {
  {
    "Darazaki/indent-o-matic",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      max_lines = -1,
      filetype_bigfile = {
        max_lines = 0,
      },
      standard_widths = { 2, 4, 8 },
      skip_multiline = true,
    },
  },
  {
    "tenxsoydev/tabs-vs-spaces.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = {
      "TabsVsSpacesToggle",
      "TabsVsSpacesStandardize",
      "TabsVsSpacesConvert",
    },
    keys = {
      { "<LEADER><SPACE>o", ":TabsVsSpacesToggle<CR>", mode = "n", desc = "TabsVsSpaces: Toggle globally" },
      { "<LEADER><SPACE>O", ":TabsVsSpacesToggle on<CR>", mode = "n", desc = "TabsVsSpaces: Turn on globally" },
      { "<LEADER><SPACE><C-O>", ":TabsVsSpacesToggle off<CR>", mode = "n", desc = "TabsVsSpaces: Turn off globally" },
      { "<LEADER><SPACE>bo", ":TabsVsSpacesToggle buf<CR>", mode = "n", desc = "TabsVsSpaces: Toggle current buffer" },
      {
        "<LEADER><SPACE>bO",
        ":TabsVsSpacesToggle buf_on<CR>",
        mode = "n",
        desc = "TabsVsSpaces: Turn on for current buffer",
      },
      {
        "<LEADER><SPACE>b<C-O>",
        ":TabsVsSpacesToggle buff_off<CR>",
        mode = "n",
        desc = "TabsVsSpaces: Turn off for current buffer",
      },

      {
        "<LEADER><SPACE>s",
        ":TabsVsSpacesStandardize<CR>",
        mode = "n",
        desc = "TabsVsSpaces: Standardize current buffer",
      },
      {
        "<LEADER><SPACE>s",
        ":'<,'>TabsVsSpacesStandardize<CR>",
        mode = "v",
        desc = "TabsVsSpaces: Standardize selected range",
      },

      {
        "<LEADER><SPACE>c",
        ":TabsVsSpacesConvert spaces_to_tabs<CR>",
        mode = "n",
        desc = "TabsVsSpaces: Convert spaces to tabs",
      },
      {
        "<LEADER><SPACE>c",
        ":'<,'>TabsVsSpacesConvert spaces_to_tabs<CR>",
        mode = "v",
        desc = "TabsVsSpaces: Convert spaces to tabs",
      },
      {
        "<LEADER><SPACE>C",
        ":TabsVsSpacesConvert tabs_to_spaces<CR>",
        mode = "n",
        desc = "TabsVsSpaces: Convert tabs to spaces",
      },
      {
        "<LEADER><SPACE>C",
        ":'<,'>TabsVsSpacesConvert tabs_to_spaces<CR>",
        mode = "v",
        desc = "TabsVsSpaces: Convert tabs to spaces",
      },
    },
    opts = {
      highlight = "DiagnosticUnderlineHint",
      ignore = {
        filetypes = {},
        buftypes = {
          "acwrite",
          "help",
          "nofile",
          "nowrite",
          "quickfix",
          "terminal",
          "prompt",
        },
      },
      standartize_on_save = false,
      user_commands = true,
    },
  },
  {
    "echasnovski/mini.trailspace",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<LEADER><SPACE>t",
        function() require("mini.trailspace").trim() end,
        desc = "MiniTrailspace: Trim trailing whitespace",
      },
      {
        "<LEADER><SPACE>T",
        function() require("mini.trailspace").trim_last_lines() end,
        desc = "MiniTrailspace: Trim last lines",
      },
    },
    init = function()
      vim.api.nvim_create_user_command("MiniTrailspace", "lua MiniTrailspace.trim()", {})
      vim.api.nvim_create_user_command("MiniTrailspaceLastlines", "lua MiniTrailspace.trim_last_lines()", {})
    end,
    opts = {
      only_in_normal_buffers = true,
    },
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<LEADER><SPACE>v",
        function() require("visual-whitespace").toggle() end,
        desc = "Visual Whitespace: Toggle",
      },
    },
    opts = function()
      -- local c = require("nord.colors").palette ---@type Nord.Palette
      local c = require("nordify.palette")["dark"]
      return {
        highlight = { fg = c.polar_night.light, bg = c.polar_night.brighter },
        space_char = "·",
        tab_char = "→",
        nl_char = "↲",
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
