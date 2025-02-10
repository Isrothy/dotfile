local map = vim.keymap.set

local yanky = {
  "gbprod/yanky.nvim",
  dependencies = {
    {
      "kkharji/sqlite.lua",
      enabled = not jit.os:find("Windows"),
    },
  },
  opts = {
    highlight = { timer = 200 },
    ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
  },
  keys = {
    { "<LEADER>y", '"+<PLUG>(YankyYank)', mode = { "n", "x" }, desc = "Yank text to system clipboard" },
    { "<LEADER>Y", '"+<PLUG>(YankyYank)', mode = { "x" }, desc = "Yank text to system clipboard" },
    { "<LEADER>Y", '"+<PLUG>(YankyYank)$', mode = { "n" }, desc = "Yank text to system clipboard until end of line" },
    {
      "<LEADER>p",
      '"+<PLUG>(YankyPutAfter)',
      mode = { "n", "x" },
      desc = "Put text from system clipboard after cursor",
    },
    {
      "<LEADER>P",
      '"+<PLUG>(YankyPutBefore)',
      mode = { "n", "x" },
      desc = "Put text from system clipboard before cursor",
    },
    { "y", "<PLUG>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
    { "p", "<PLUG>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
    { "P", "<PLUG>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
    {
      "gp",
      "<PLUG>(YankyGPutAfter)",
      mode = { "n", "x" },
      desc = "Put yanked text after selection",
    },
    {
      "gP",
      "<PLUG>(YankyGPutBefore)",
      mode = { "n", "x" },
      desc = "Put yanked text before selection",
    },
    { "[y", "<PLUG>(YankyCycleForward)", desc = "Cycle forward through yank history" },
    { "]y", "<PLUG>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
    { "]p", "<PLUG>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    { "[p", "<PLUG>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
    { "]P", "<PLUG>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    { "[P", "<PLUG>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
    { ">p", "<PLUG>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
    { "<p", "<PLUG>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
    { ">P", "<PLUG>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
    { "<P", "<PLUG>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
    { "=p", "<PLUG>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
    { "=P", "<PLUG>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },

    { "gyc", "<PLUG>(YankyYank)y<CMD>normal gcc<CR>p", desc = "Duplicate a line and comment out the first line" },
    { "gyr", ":call setreg('+', getreg('@'))<CR>", desc = "Yank register to system clipboard" },
    {
      "gyp",
      ":call setreg('+', expand('%:.') .. ':' .. line('.'))<CR>",
      desc = "Yank filename and line number to system clipboard",
    },
  },
}

local substitute = {
  "gbprod/substitute.nvim",
  keys = {
    { "s", function() require("substitute").operator() end, desc = "Substitute" },
    {
      "<LEADER>s",
      function() require("substitute").operator({ register = "+" }) end,
      desc = "Substitute with system clipboard",
    },
    { "ss", function() require("substitute").line() end, desc = "Substitute line" },
    {
      "<LEADER>ss",
      function() require("substitute").line({ register = "+" }) end,
      desc = "Substitute line with system clipboard",
    },
    { "S", function() require("substitute").eol() end, desc = "Substitute EOL" },
    {
      "<LEADER>S",
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
      "<LEADER>s",
      function() require("substitute").visual({ register = "+" }) end,
      desc = "Substitute visual with system clipboard",
      mode = "x",
    },
    { "x", function() require("substitute.exchange").operator() end, desc = "Exchange" },
    { "xx", function() require("substitute.exchange").line() end, desc = "Exchange line" },
    { "X", function() require("substitute.exchange").eol() end, desc = "Exchange EOL" },
    { "x", function() require("substitute.exchange").visual() end, mode = "x", desc = "Exchange visual" },
  },
  opts = {
    on_substitute = function() require("yanky.integration").substitute() end,
    highlight_substituted_text = {
      enabled = true,
      timer = 500,
    },
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
    },
  },
}

local dial = {
  "monaqa/dial.nvim",
  keys = {
    { "<C-A>", mode = "n", desc = "Increment" },
    { "<C-X>", mode = "n", desc = "Decrement" },
    { "<C-A>", mode = "v", desc = "Increment" },
    { "<C-X>", mode = "v", desc = "Decrement" },
    { "g<C-A>", mode = "v", desc = "G increment" },
    { "g<C-x>", mode = "v", desc = "G decrement" },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      -- default augends used when no group name is specified
      default = {
        augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
        augend.integer.alias.octal,
        augend.integer.alias.binary,
        augend.constant.alias.bool,
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        augend.constant.new({
          elements = { "and", "or" },
          word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
          cyclic = true, -- "or" is incremented into "and".
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
        augend.hexcolor.new({
          case = "lower",
        }),
        augend.hexcolor.new({
          case = "upper",
        }),
      },
    })

    map({ "n", "v" }, "<C-A>", require("dial.map").inc_normal(), { noremap = true, desc = "Increment" })
    map({ "n", "v" }, "<C-X>", require("dial.map").dec_normal(), { noremap = true, desc = "Decrement" })
    map("v", "g<C-A>", require("dial.map").inc_gvisual(), { noremap = true, desc = "G Increment" })
    map("v", "g<C-X>", require("dial.map").dec_gvisual(), { noremap = true, desc = "G Decrement" })
  end,
}

local mini_move = {
  "echasnovski/mini.move",
  keys = {
    { "<M-H>", mode = { "n", "x" }, desc = "Move left" },
    { "<M-K>", mode = { "n", "x" }, desc = "Move up" },
    { "<M-L>", mode = { "n", "x" }, desc = "Move right" },
    { "<M-J>", mode = { "n", "x" }, desc = "Move down" },
  },
  opts = {
    mappings = {
      left = "<M-H>",
      right = "<M-L>",
      up = "<M-K>",
      down = "<M-J>",

      line_left = "<M-H>",
      line_right = "<M-L>",
      line_up = "<M-K>",
      line_down = "<M-J>",
    },
  },
}

local surround = {
  "kylechui/nvim-surround",
  keys = {
    { "ds", "<CMD><PLUG>(nvim-surround-delete)<CR>", desc = "Delete a surrounding pair" },
    { "cs", "<CMD><PLUG>(nvim-surround-change)<CR>", desc = "Change a surrounding pair" },
    {
      "cS",
      "<CMD><PLUG>(nvim-surround-change-line)<CR>",
      desc = "Change a surrounding pair, putting replacements on new lines",
    },
    { "gs", "<PLUG>(nvim-surround-normal)", desc = "Add a surrounding pair around a motion" },
    { "gss", "<PLUG>(nvim-surround-normal-cur)", desc = "Add a surrounding pair around the current line" },
    { "gS", "<PLUG>(nvim-surround-normal-line)", desc = "Add a surrounding pair around a motion, on new lines" },
    {
      "gSS",
      "<PLUG>(nvim-surround-normal-cur-line)",
      desc = "Add a surrounding pair around the current line, on new lines",
    },
    { "gs", "<PLUG>(nvim-surround-visual)", mode = "x", desc = "Add a surrounding pair around a Visual selection" },
    {
      "gS",
      "<PLUG>(nvim-surround-visual-line)",
      mode = "x",
      desc = "Add a surrounding pair around a visual selection, on new lines",
    },
    {
      "<c-g>s",
      "<PLUG>(nvim-surround-insert)",
      mode = "i",
      desc = "Add a surrounding pair Around the cursor",
    },
    {
      "<c-g>s",
      "<PLUG>(nvim-surround-insert-line)",
      mode = "i",
      desc = "Add a surrounding pair around the cursor, on new lines",
    },
  },
  opts = {
    keymaps = {},
    move_cursor = false,
    alias = {
      ["a"] = ">",
      ["A"] = "<",
      ["b"] = ")",
      ["B"] = "(",
      ["c"] = "}",
      ["C"] = "{",
      ["r"] = "]",
      ["R"] = "[",
      ["q"] = { '"', "'", "`" },
      ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },
  },
}

local textcase = {
  "johmsalas/text-case.nvim",
  cmd = { "TextCaseStartReplacingCommand" },
  keys = {
    { "gac", function() require("textcase").operator("to_camel_case") end, desc = "Convert toCamelCase" },
    { "gad", function() require("textcase").operator("to_dashed_case") end, desc = "Convert to-dashed-case" },
    { "gal", function() require("textcase").operator("to_lower_case") end, desc = "Convert to lower case" },
    { "gap", function() require("textcase").operator("to_pascal_case") end, desc = "Convert ToPascalCase" },
    { "gas", function() require("textcase").operator("to_snake_case") end, desc = "Convert to_snake_case" },
    { "gau", function() require("textcase").operator("to_upper_case") end, desc = "Convert To UPPER CASE" },
    { "gaC", function() require("textcase").lsp_rename("to_camel_case") end, desc = "Rename toCamelCase" },
    { "gaD", function() require("textcase").lsp_rename("to_dashed_case") end, desc = "Rename to-dashed-case" },
    { "gaL", function() require("textcase").lsp_rename("to_lower_case") end, desc = "Rename to lower case" },
    { "gaP", function() require("textcase").lsp_rename("to_pascal_case") end, desc = "Rename ToPascalCase" },
    { "gaS", function() require("textcase").lsp_rename("to_snake_case") end, desc = "Rename to_snake_case" },
    { "gaU", function() require("textcase").lsp_rename("to_upper_case") end, desc = "Rename To UPPER CASE" },
    { "gaoc", function() require("textcase").operator("to_camel_case") end, desc = "toCamelCase", mode = { "n", "v" } },
    {
      "gaod",
      function() require("textcase").operator("to_dashed_case") end,
      desc = "to-dashed-case",
      mode = { "n", "v" },
    },
    { "gaol", function() require("textcase").operator("to_lower_case") end, desc = "to lower case", mode = { "n", "v" } },
    { "gaop", function() require("textcase").operator("to_pascal_case") end, desc = "ToPascalCase", mode = { "n", "v" } },
    { "gaos", function() require("textcase").operator("to_snake_case") end, desc = "to_snake_case", mode = { "n", "v" } },
    { "gaou", function() require("textcase").operator("to_upper_case") end, desc = "To UPPER CASE", mode = { "n", "v" } },
  },
  config = function()
    require("textcase").setup({
      default_keymappings_enabled = false,
      prefix = "ga",
    })
  end,
}

return {
  yanky,
  substitute,
  dial,
  mini_move,
  surround,
  textcase,
}
