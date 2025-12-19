return {
  {
    "gbprod/yanky.nvim",
    dependencies = {
      {
        "kkharji/sqlite.lua",
        enabled = not jit.os:find("Windows"),
      },
    },
    opts = {
      highlight = { timer = 200 },
      ring = {
        storage = jit.os:find("Windows") and "shada" or "sqlite",
      },
    },
    keys = {
      { "<leader>y", '"+<plug>(YankyYank)', mode = { "n", "x" }, desc = "Yank text to system clipboard" },
      { "<leader>Y", 'V"+<plug>(YankyYank)', mode = { "x" }, desc = "Yank selected lines to system clipboard" },
      { "<leader>Y", '"+<plug>(YankyYank)$', mode = { "n" }, desc = "Yank EOL to system clipboard" },
      {
        "<leader>p",
        '"+<plug>(YankyPutAfter)',
        mode = { "n", "x" },
        desc = "Put text from system clipboard after cursor",
      },
      {
        "<leader>P",
        '"+<plug>(YankyPutBefore)',
        mode = { "n", "x" },
        desc = "Put text from system clipboard before cursor",
      },
      { "y", "<plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
      { "Y", "<plug>(YankyYank)$", mode = { "n" }, desc = "Yank EOL" },
      { "Y", "V<plug>(YankyYank)", mode = { "x" }, desc = "Yank selected lines" },
      { "p", "<plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
      { "P", "<plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
      {
        "gp",
        "<plug>(YankyGPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after selection",
      },
      {
        "gP",
        "<plug>(YankyGPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before selection",
      },
      { "[y", "<plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
      { "]y", "<plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
      { "]p", "<plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[p", "<plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { "]P", "<plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[P", "<plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { ">p", "<plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      { "<p", "<plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      { ">P", "<plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      { "=p", "<plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      { "=P", "<plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },

      { "gyc", "<plug>(YankyYank)y<cmd>normal gcc<cr>p", desc = "Duplicate a line and comment out the first line" },
      { "gyr", ":call setreg('+', getreg('@'))<cr>", desc = "Yank register to system clipboard" },
      {
        "gyp",
        ":call setreg('+', expand('%:.') .. ':' .. line('.'))<cr>",
        desc = "Yank filename and line number to system clipboard",
      },
    },
  },
  {
    "gbprod/substitute.nvim",
    keys = {
      {
        "s",
        function() require("substitute").operator() end,
        desc = "Substitute",
      },
      {
        "<leader>s",
        function() require("substitute").operator({ register = "+" }) end,
        desc = "Substitute with system clipboard",
      },
      {
        "ss",
        function() require("substitute").line() end,
        desc = "Substitute line",
      },
      {
        "<leader>ss",
        function() require("substitute").line({ register = "+" }) end,
        desc = "Substitute line with system clipboard",
      },
      {
        "S",
        function() require("substitute").eol() end,
        desc = "Substitute EOL",
      },
      {
        "<leader>S",
        function() require("substitute").eol({ register = "+" }) end,
        desc = "Substitute EOL with system clipboard",
      },
      {
        "s",
        function() require("substitute").visual() end,
        desc = "Substitute visual",
        mode = { "x" },
      },
      {
        "<leader>s",
        function() require("substitute").visual({ register = "+" }) end,
        desc = "Substitute visual with system clipboard",
        mode = "x",
      },
      {
        "S",
        function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("V", true, true, true), "n", false)
          vim.schedule_wrap(require("substitute").visual)()
        end,
        desc = "Substitute selected lines",
        mode = { "x" },
      },
      {
        "<leader>S",
        function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("V", true, true, true), "n", false)
          vim.schedule_wrap(require("substitute").visual)({ register = "+" })
        end,
        desc = "Substitute selected lines with system clipboard",
        mode = "x",
      },
      { "x", function() require("substitute.exchange").operator() end, desc = "Exchange" },
      { "xx", function() require("substitute.exchange").line() end, desc = "Exchange line" },
      { "X", function() require("substitute.exchange").operator({ motion = "$" }) end, desc = "Exchange EOL" },
      { "x", function() require("substitute.exchange").visual() end, mode = "x", desc = "Exchange visual" },
      {
        "X",
        function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("V", true, true, true), "n", false)
          vim.schedule_wrap(require("substitute.exchange").visual)()
        end,
        mode = "x",
        desc = "Exchange selected lines",
      },
    },
    opts = {
      on_substitute = function() require("yanky.integration").substitute() end,
      highlight_substituted_text = {
        enabled = true,
        timer = 500,
      },
      preserve_cursor_position = false,
      range = {
        prefix = "",
        prompt_current_text = false,
        confirm = false,
        complete_word = false,
        motion1 = false,
        motion2 = false,
        suffix = "",
      },
      exchange = {
        motion = false,
        use_esc_to_cancel = true,
        preserve_cursor_position = false,
      },
    },
  },

  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<c-a>",
        function() require("dial.map").manipulate("increment", "normal") end,
        desc = "Increment",
      },
      {
        "<c-x>",
        function() require("dial.map").manipulate("decrement", "normal") end,
        desc = "Decrement",
      },
      {
        "g<c-a>",
        function() require("dial.map").manipulate("increment", "gnormal") end,
        mode = "n",
        desc = "G increment",
      },
      {
        "g<c-x>",
        function() require("dial.map").manipulate("decrement", "gnormal") end,
        mode = "n",
        desc = "G decrement",
      },
      {
        "<c-a>",
        function() require("dial.map").manipulate("increment", "visual") end,
        mode = "x",
        desc = "Increment",
      },
      {
        "<c-x>",
        function() require("dial.map").manipulate("decrement", "visual") end,
        mode = "x",
        desc = "Decrement",
      },
      {
        "g<c-a>",
        function() require("dial.map").manipulate("increment", "gvisual") end,
        mode = "x",
        desc = "G Increment",
      },
      {
        "g<c-x>",
        function() require("dial.map").manipulate("decrement", "gvisual") end,
        mode = "x",
        desc = "G Decrement",
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.integer.alias.octal,
          augend.integer.alias.binary,
          augend.constant.alias.bool,
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.semver.alias.semver,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%m/%d"],
          augend.date.alias["%H:%M"],
          augend.constant.new({
            elements = { "and", "or" },
            word = true,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "min", "max" },
            word = true,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "True", "False" },
            word = true,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "lower", "upper" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "&", "|" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "+", "-" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "++", "--" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { ">>", "<<" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { ">", "<" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { ">=", "<=" },
            word = false,
            cyclic = true,
          }),
          augend.hexcolor.new({
            case = "lower",
          }),
          augend.hexcolor.new({
            case = "upper",
          }),
        },
      })
    end,
  },

  {
    "nvim-mini/mini.move",
    enabled = false,
    keys = {
      { "<m-h>", mode = { "n", "x" }, desc = "Move left" },
      { "<m-k>", mode = { "n", "x" }, desc = "Move up" },
      { "<m-l>", mode = { "n", "x" }, desc = "Move right" },
      { "<m-j>", mode = { "n", "x" }, desc = "Move down" },
    },
    opts = {
      mappings = {
        down = "<m-j>",
        left = "<m-h>",
        right = "<m-l>",
        up = "<m-k>",

        line_left = "<m-h>",
        line_right = "<m-l>",
        line_up = "<m-k>",
        line_down = "<m-j>",
      },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    keys = {
      { "ds", "<cmd><plug>(nvim-surround-delete)<cr>", desc = "Delete a surrounding pair" },
      { "cs", "<cmd><plug>(nvim-surround-change)<cr>", desc = "Change a surrounding pair" },
      {
        "cS",
        "<cmd><plug>(nvim-surround-change-line)<cr>",
        desc = "Change a surrounding pair, putting replacements on new lines",
      },
      { "gs", "<plug>(nvim-surround-normal)", desc = "Add a surrounding pair around a motion" },
      { "gss", "<plug>(nvim-surround-normal-cur)", desc = "Add a surrounding pair around the current line" },
      { "gS", "<plug>(nvim-surround-normal-line)", desc = "Add a surrounding pair around a motion, on new lines" },
      {
        "gSS",
        "<plug>(nvim-surround-normal-cur-line)",
        desc = "Add a surrounding pair around the current line, on new lines",
      },
      { "gs", "<plug>(nvim-surround-visual)", mode = "x", desc = "Add a surrounding pair around a Visual selection" },
      {
        "gS",
        "<plug>(nvim-surround-visual-line)",
        mode = "x",
        desc = "Add a surrounding pair around a visual selection, on new lines",
      },
      {
        "<c-g>s",
        "<plug>(nvim-surround-insert)",
        mode = "i",
        desc = "Add a surrounding pair Around the cursor",
      },
      {
        "<c-g>s",
        "<plug>(nvim-surround-insert-line)",
        mode = "i",
        desc = "Add a surrounding pair around the cursor, on new lines",
      },
    },
    opts = {
      keymaps = {},
      move_cursor = false,
      alias = {
        ["a"] = ">", --angle bracket
        ["A"] = "<",
        ["p"] = ")", -- parenthesis
        ["P"] = "(",
        ["c"] = "}", -- curly bracket
        ["C"] = "{",
        ["b"] = "]", -- bracket
        ["B"] = "[",
        ["q"] = { '"', "'", "`" },
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
      },
    },
  },

  {
    "johmsalas/text-case.nvim",
    cmd = { "TextCaseStartReplacingCommand" },
    keys = {
      { "ga", "", desc = "+Convert text case", mode = { "n", "x" } },
      {
        "gac",
        function() require("textcase").operator("to_camel_case") end,
        desc = "toCamelCase",
        mode = { "n", "x" },
      },
      {
        "gad",
        function() require("textcase").operator("to_dash_case") end,
        desc = "to-dash-case",
        mode = { "n", "x" },
      },
      {
        "gaf",
        function() require("textcase").operator("to_phrase_case") end,
        desc = "To phrase case",
        mode = { "n", "x" },
      },
      {
        "gal",
        function() require("textcase").operator("to_lower_case") end,
        desc = "to lower case",
        mode = { "n", "x" },
      },
      {
        "gan",
        function() require("textcase").operator("to_constant_case") end,
        desc = "Convert to CONSTANT_CASE",
        mode = { "n", "x" },
      },
      {
        "gap",
        function() require("textcase").operator("to_pascal_case") end,
        desc = "ToPascalCase",
        mode = { "n", "x" },
      },
      {
        "gas",
        function() require("textcase").operator("to_snake_case") end,
        desc = "to_snake_case",
        mode = { "n", "x" },
      },
      {
        "gat",
        function() require("textcase").operator("to_title_case") end,
        desc = "To Title Case",
        mode = { "n", "x" },
      },
      {
        "gau",
        function() require("textcase").operator("to_upper_case") end,
        desc = "TO UPPER CASE",
        mode = { "n", "x" },
      },
      {
        "gax",
        function() require("textcase").operator("to_title_dash_case") end,
        desc = "To-Title-Dash-Case",
        mode = { "n", "x" },
      },
      {
        "ga.",
        function() require("textcase").operator("to_dot_case") end,
        desc = "to.dot.case",
        mode = { "n", "x" },
      },
      {
        "ga,",
        function() require("textcase").operator("to_comma_case") end,
        desc = "to,comma,case",
        mode = { "n", "x" },
      },
      {
        "ga/",
        function() require("textcase").operator("to_path_case") end,
        desc = "to/path/case",
        mode = { "n", "x" },
      },

      { "<leader>kc", function() require("textcase").lsp_rename("to_camel_case") end, desc = "toCamelCase" },
      { "<leader>kd", function() require("textcase").lsp_rename("to_dashed_case") end, desc = "to-dashed-case" },
      { "<leader>ke", function() require("textcase").lsp_rename("to_phrase_case") end, desc = "To Phrase case" },
      { "<leader>kl", function() require("textcase").lsp_rename("to_lower_case") end, desc = "to lower case" },
      { "<leader>kn", function() require("textcase").lsp_rename("to_constant_case") end, desc = "TO_CONSTANT_CASE" },
      { "<leader>kp", function() require("textcase").lsp_rename("to_pascal_case") end, desc = "ToPascalCase" },
      { "<leader>ks", function() require("textcase").lsp_rename("to_snake_case") end, desc = "to_snake_case" },
      { "<leader>kt", function() require("textcase").lsp_rename("to_title_case") end, desc = "To Title Case" },
      { "<leader>ku", function() require("textcase").lsp_rename("to_upper_case") end, desc = "TO UPPER CASE" },
      {
        "<leader>kx",
        function() require("textcase").lsp_rename("to_title_dash_case") end,
        desc = "To-Title-Dash-Case",
      },
      { "<leader>k.", function() require("textcase").lsp_rename("to_dot_case") end, desc = "to.dot.case" },
      { "<leader>k,", function() require("textcase").lsp_rename("to_comma_case") end, desc = "to,comma,case" },
      { "<leader>k/", function() require("textcase").lsp_rename("to_path_case") end, desc = "to/path/case" },
    },
    config = function()
      require("textcase").setup({
        default_keymappings_enabled = false,
      })
    end,
  },
}
