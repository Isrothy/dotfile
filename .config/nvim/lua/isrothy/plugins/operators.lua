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
      desc = "Yank Text to System Clipboard",
    },
    {
      "<LEADER>Y",
      "\"+<PLUG>(YankyYank)",
      mode = { "x" },
      desc = "Yank Text to System Clipboard",
    },
    {
      "<LEADER>Y",
      "\"+<PLUG>(YankyYank)$",
      mode = { "n" },
      desc = "Yank Text to System Clipboard Until End of Line",
    },
    {
      "<LEADER>p",
      "\"+<PLUG>(YankyPutAfter)",
      mode = { "n", "x" },
      desc = "Put Text from System Clipboard After Cursor",
    },
    {
      "<LEADER>P",
      "\"+<PLUG>(YankyPutBefore)",
      mode = { "n", "x" },
      desc = "Put Text from System Clipboard Before Cursor",
    },
    { "y", "<PLUG>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
    { "p", "<PLUG>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Yanked Text After Cursor" },
    { "P", "<PLUG>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Yanked Text Before Cursor" },
    {
      "gp",
      "<PLUG>(YankyGPutAfter)",
      mode = { "n", "x" },
      desc = "Put Yanked Text After Selection",
    },
    {
      "gP",
      "<PLUG>(YankyGPutBefore)",
      mode = { "n", "x" },
      desc = "Put Yanked Text Before Selection",
    },
    { "[y", "<PLUG>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
    { "]y", "<PLUG>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
    { "]p", "<PLUG>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
    {
      "[p",
      "<PLUG>(YankyPutIndentBeforeLinewise)",
      desc = "Put Indented Before Cursor (Linewise)",
    },
    { "]P", "<PLUG>(YankyPutIndentAfterLinewise)", desc = "Put indented After Cursor (Linewise)" },
    {
      "[P",
      "<PLUG>(YankyPutIndentBeforeLinewise)",
      desc = "Put Indented Before Cursor (linewise)",
    },
    { ">p", "<PLUG>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
    { "<p", "<PLUG>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
    { ">P", "<PLUG>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
    { "<P", "<PLUG>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
    { "=p", "<PLUG>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
    { "=P", "<PLUG>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },

    {
      "gyc",
      "<PLUG>(YankyYank)y<CMD>normal gcc<CR>p",
      desc = "Duplicate a Line and Comment Out the First Line",
    },
    {
      "gyr",
      ":call setreg('+', getreg('@'))<CR>",
      desc = "Yank Register to System Clipboard",
    },
    {
      "gyp",
      ":call setreg('+', expand('%:.') .. ':' .. line('.'))<CR>",
      desc = "Yank Filename and Line Number to System Clipboard",
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
      desc = "Substitute with System Clipboard",
    },
    {
      "ss",
      "<CMD>lua require('substitute').line()<CR>",
      desc = "Substitute Line",
    },
    {
      "<LEADER>ss",
      "<CMD>lua require('substitute').line({register = '+'})<CR>",
      desc = "Substitute Line with System Clipboard",
    },
    {
      "S",
      "<CMD>lua require('substitute').eol()<CR>",
      desc = "Substitute EOL",
    },
    {
      "<LEADER>S",
      "<CMD>lua require('substitute').eol({register = '+'})<CR>",
      desc = "Substitute EOL with System Clipboard",
    },
    {
      "s",
      "<CMD>lua require('substitute').visual()<CR>",
      desc = "Substitute Visual",
      mode = { "x" },
    },
    {
      "<LEADER>s",
      "<CMD>lua require('substitute').visual({register = '+'})<CR>",
      desc = "Substitute Visual with System Clipboard",
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
      desc = "Exchange Line",
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
      desc = "Exchange Visual",
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
    { "<M-H>", mode = { "n", "x" }, desc = "Move Left" },
    { "<M-L>", mode = { "n", "x" }, desc = "Move Right" },
    { "<M-K>", mode = { "n", "x" }, desc = "Move Up" },
    { "<M-J>", mode = { "n", "x" }, desc = "Move Down" },
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
      desc = "Delete a Surrounding Pair",
    },
    {
      "cs",
      "<CMD><PLUG>(nvim-surround-change)<CR>",
      mode = "n",
      desc = "Change a Surrounding Pair",
    },
    {
      "cS",
      "<CMD><PLUG>(nvim-surround-change-line)<CR>",
      mode = "n",
      desc = "Change a Surrounding Pair, Putting Replacements on New Lines",
    },
    {
      "gs",
      "<PLUG>(nvim-surround-normal)",
      mode = "n",
      desc = "Add a Surrounding Pair Around a Motion",
    },
    {
      "gss",
      "<PLUG>(nvim-surround-normal-cur)",
      mode = "n",
      desc = "Add a Surrounding Pair Around The Current Line",
    },
    {
      "gS",
      "<PLUG>(nvim-surround-normal-line)",
      mode = "n",
      desc = "Add a Surrounding Pair Around a Motion, on New Lines",
    },
    {
      "gSS",
      "<PLUG>(nvim-surround-normal-cur-line)",
      mode = "n",
      desc = "Add a Surrounding Pair Around The Current Line, on New Lines",
    },
    {
      "gs",
      "<PLUG>(nvim-surround-visual)",
      mode = "x",
      desc = "Add a Surrounding Pair Around a Visual Selection",
    },
    {
      "gS",
      "<PLUG>(nvim-surround-visual-line)",
      mode = "x",
      desc = "Add a Surrounding Pair Around a Visual Selection, on New Lines",
    },
    {
      "<c-g>s",
      "<PLUG>(nvim-surround-insert)",
      mode = "i",
      desc = "Add a Surrounding Pair Around the Cursor",
    },
    {
      "<c-g>s",
      "<PLUG>(nvim-surround-insert-line)",
      mode = "i",
      desc = "Add a Surrounding Pair Around the Cursor, on New Lines",
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
