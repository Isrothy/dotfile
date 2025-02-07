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
    {
      "<LEADER>y",
      "\"+<PLUG>(YankyYank)",
      mode = { "n", "x" },
      desc = "Yank text to system clipboard",
    },
    {
      "<LEADER>Y",
      "\"+<PLUG>(YankyYank)",
      mode = { "x" },
      desc = "Yank text to system clipboard",
    },
    {
      "<LEADER>Y",
      "\"+<PLUG>(YankyYank)$",
      mode = { "n" },
      desc = "Yank text to system clipboard until end of line",
    },
    {
      "<LEADER>p",
      "\"+<PLUG>(YankyPutAfter)",
      mode = { "n", "x" },
      desc = "Put text from system clipboard after cursor",
    },
    {
      "<LEADER>P",
      "\"+<PLUG>(YankyPutBefore)",
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
    -- { "[y", "<PLUG>(YankyCycleForward)", desc = "Cycle forward through yank history" },
    -- { "]y", "<PLUG>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
    -- { "]p", "<PLUG>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    -- {
    --   "[p",
    --   "<PLUG>(YankyPutIndentBeforeLinewise)",
    --   desc = "Put indented before cursor (linewise)",
    -- },
    -- { "]P", "<PLUG>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    -- {
    --   "[P",
    --   "<PLUG>(YankyPutIndentBeforeLinewise)",
    --   desc = "Put indented before cursor (linewise)",
    -- },
    { ">p", "<PLUG>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
    { "<p", "<PLUG>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
    { ">P", "<PLUG>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
    { "<P", "<PLUG>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
    { "=p", "<PLUG>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
    { "=P", "<PLUG>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },

    {
      "gyc",
      "<PLUG>(YankyYank)y<CMD>normal gcc<CR>p",
      desc = "Duplicate a line and comment out the first line",
    },
    {
      "gyr",
      ":call setreg('+', getreg('@'))<CR>",
      desc = "Yank register to system clipboard",
    },
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
    {
      "s",
      "<CMD>lua require('substitute').operator()<CR>",
      desc = "Substitute",
    },
    {
      "<LEADER>s",
      "<CMD>lua require('substitute').operator({register = '+'})<CR>",
      desc = "Substitute with system clipboard",
    },
    {
      "ss",
      "<CMD>lua require('substitute').line()<CR>",
      desc = "Substitute line",
    },
    {
      "<LEADER>ss",
      "<CMD>lua require('substitute').line({register = '+'})<CR>",
      desc = "Substitute line with system clipboard",
    },
    {
      "S",
      "<CMD>lua require('substitute').eol()<CR>",
      desc = "Substitute EOL",
    },
    {
      "<LEADER>S",
      "<CMD>lua require('substitute').eol({register = '+'})<CR>",
      desc = "Substitute EOL with system clipboard",
    },
    {
      "s",
      "<CMD>lua require('substitute').visual()<CR>",
      desc = "Substitute visual",
      mode = { "x" },
    },
    {
      "<LEADER>s",
      "<CMD>lua require('substitute').visual({register = '+'})<CR>",
      desc = "Substitute visual with system clipboard",
      mode = "x",
    },
    {
      "x",
      "<CMD>lua require('substitute.exchange').operator()<CR>",
      desc = "Exchange",
    },
    {
      "xx",
      "<CMD>lua require('substitute.exchange').line()<CR>",
      desc = "Exchange line",
    },
    {
      "X",
      "<CMD>lua require('substitute.exchange').eol()<CR>",
      desc = "Exchange EOL",
    },
    {
      "x",
      "<CMD>lua require('substitute.exchange').visual()<CR>",
      mode = "x",
      desc = "Exchange visual",
    },
  },
  opts = {
    on_substitute = function()
      require("yanky.integration").substitute()
    end,
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

    map("n", "<C-A>", require("dial.map").inc_normal(), { noremap = true, desc = "Increment" })
    map("n", "<C-X>", require("dial.map").dec_normal(), { noremap = true, desc = "Decrement" })
    map("v", "<C-A>", require("dial.map").inc_visual(), { noremap = true, desc = "Increment" })
    map("v", "<C-X>", require("dial.map").dec_visual(), { noremap = true, desc = "Decrement" })
    map("v", "g<C-A>", require("dial.map").inc_gvisual(), { noremap = true, desc = "G Increment" })
    map("v", "g<C-X>", require("dial.map").dec_gvisual(), { noremap = true, desc = "G Decrement" })
  end,
}

local mini_move = {
  "echasnovski/mini.move",
  keys = {
    { "<M-H>", mode = { "n", "x" }, desc = "Move left" },
    { "<M-L>", mode = { "n", "x" }, desc = "Move right" },
    { "<M-K>", mode = { "n", "x" }, desc = "Move up" },
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
    {
      "ds",
      "<CMD><PLUG>(nvim-surround-delete)<CR>",
      mode = "n",
      desc = "Delete a surrounding pair",
    },
    {
      "cs",
      "<CMD><PLUG>(nvim-surround-change)<CR>",
      mode = "n",
      desc = "Change a surrounding pair",
    },
    {
      "cS",
      "<CMD><PLUG>(nvim-surround-change-line)<CR>",
      mode = "n",
      desc = "Change a surrounding pair, putting replacements on new lines",
    },
    {
      "gs",
      "<PLUG>(nvim-surround-normal)",
      mode = "n",
      desc = "Add a surrounding pair around a motion",
    },
    {
      "gss",
      "<PLUG>(nvim-surround-normal-cur)",
      mode = "n",
      desc = "Add a surrounding pair around the current line",
    },
    {
      "gS",
      "<PLUG>(nvim-surround-normal-line)",
      mode = "n",
      desc = "Add a surrounding pair around a motion, on new lines",
    },
    {
      "gSS",
      "<PLUG>(nvim-surround-normal-cur-line)",
      mode = "n",
      desc = "Add a surrounding pair around the current line, on new lines",
    },
    {
      "gs",
      "<PLUG>(nvim-surround-visual)",
      mode = "x",
      desc = "Add a surrounding pair around a Visual selection",
    },
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
  },
}

local textcase = {
  "johmsalas/text-case.nvim",
  cmd = {
    "TextCaseStartReplacingCommand",
  },
  keys = {
    {
      "gac",
      "<CMD>lua require('textcase').operator('to_camel_case')<CR>",
      desc = "Convert toCamelCase",
    },
    {
      "gad",
      "<CMD>lua require('textcase').operator('to_dashed_case')<CR>",
      desc = "Convert to-dashed-case",
    },
    {
      "gal",
      "<CMD>lua require('textcase').operator('to_lower_case')<CR>",
      desc = "Convert to lower case",
    },
    {
      "gap",
      "<CMD>lua require('textcase').operator('to_pascal_case')<CR>",
      desc = "Convert ToPascalCase",
    },
    {
      "gas",
      "<CMD>lua require('textcase').operator('to_snake_case')<CR>",
      desc = "Convert to_snake_case",
    },
    {
      "gau",
      "<CMD>lua require('textcase').operator('to_upper_case')<CR>",
      desc = "Convert To UPPER CASE",
    },
    {
      "gaC",
      "<CMD>lua require('textcase').lsp_rename('to_camel_case')<CR>",
      desc = "Rename toCamelCase",
    },
    {
      "gaD",
      "<CMD>lua require('textcase').lsp_rename('to_dashed_case')<CR>",
      desc = "Rename to-dashed-case",
    },
    {
      "gaL",
      "<CMD>lua require('textcase').lsp_rename('to_lower_case')<CR>",
      desc = "Rename to lower case",
    },
    {
      "gaP",
      "<CMD>lua require('textcase').lsp_rename('to_pascal_case')<CR>",
      desc = "Rename ToPascalCase",
    },
    {
      "gaS",
      "<CMD>lua require('textcase').lsp_rename('to_snake_case')<CR>",
      desc = "Rename to_snake_case",
    },
    {
      "gaU",
      "<CMD>lua require('textcase').lsp_rename('to_upper_case')<CR>",
      desc = "Rename To UPPER CASE",
    },
    {
      "gaoc",
      "<CMD>lua require('textcase').operator('to_camel_case')<CR>",
      desc = "toCamelCase",
      mode = { "n", "v" },
    },
    {
      "gaod",
      "<CMD>lua require('textcase').operator('to_dashed_case')<CR>",
      desc = "to-dashed-case",
      mode = { "n", "v" },
    },
    {
      "gaol",
      "<CMD>lua require('textcase').operator('to_lower_case')<CR>",
      desc = "to lower case",
      mode = { "n", "v" },
    },
    {
      "gaop",
      "<CMD>lua require('textcase').operator('to_pascal_case')<CR>",
      desc = "ToPascalCase",
      mode = { "n", "v" },
    },
    {
      "gaos",
      "<CMD>lua require('textcase').operator('to_snake_case')<CR>",
      desc = "to_snake_case",
      mode = { "n", "v" },
    },
    {
      "gaou",
      "<CMD>lua require('textcase').operator('to_upper_case')<CR>",
      desc = "To UPPER CASE",
      mode = { "n", "v" },
    },
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
