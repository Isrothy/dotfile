local map = vim.keymap.set

local yanky = {
  "gbprod/yanky.nvim",
  enabled = true,
  dependencies = {
    {
      "kkharji/sqlite.lua",
      enabled = not jit.os:find("Windows"),
    },
  },
  opts = function()
    local mapping = require("yanky.telescope.mapping")
    local mappings = mapping.get_defaults()
    mappings.i["<c-p>"] = nil
    return {
      highlight = { timer = 200 },
      ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
      picker = {
        telescope = {
          use_default_mappings = false,
          mappings = mappings,
        },
      },
    }
  end,
  keys = {
    {
      "<leader>y",
      "\"+<Plug>(YankyYank)",
      mode = { "n", "x" },
      desc = "Yank text to system clipboard",
    },
    {
      "<leader>Y",
      "\"+<Plug>(YankyYank)",
      mode = { "x" },
      desc = "Yank text to system clipboard",
    },
    {
      "<leader>Y",
      "\"+<Plug>(YankyYank)$",
      mode = { "n" },
      desc = "Yank text to system clipboard until end of line",
    },
    {
      "<leader>p",
      "\"+<Plug>(YankyPutAfter)",
      mode = { "n", "x" },
      desc = "Put text from system clipboard after cursor",
    },
    {
      "<leader>P",
      "\"+<Plug>(YankyPutBefore)",
      mode = { "n", "x" },
      desc = "Put text from system clipboard before cursor",
    },
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
    {
      "gp",
      "<Plug>(YankyGPutAfter)",
      mode = { "n", "x" },
      desc = "Put yanked text after selection",
    },
    {
      "gP",
      "<Plug>(YankyGPutBefore)",
      mode = { "n", "x" },
      desc = "Put yanked text before selection",
    },
    { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
    { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    {
      "[p",
      "<Plug>(YankyPutIndentBeforeLinewise)",
      desc = "Put indented before cursor (linewise)",
    },
    { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    {
      "[P",
      "<Plug>(YankyPutIndentBeforeLinewise)",
      desc = "Put indented before cursor (linewise)",
    },
    { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
    { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
    { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
    { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
    { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
    { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },

    {
      "gyc",
      "<Plug>(YankyYank)y<cmd>normal gcc<CR>p",
      { desc = "Duplicate a line and comment out the first line" },
    },
  },
}

local substitute = {
  "gbprod/substitute.nvim",
  init = function()
    map(
      "n",
      "gr",
      "<cmd>lua require('substitute').operator()<cr>",
      { noremap = true, silent = true, desc = "substitute" }
    )
    map(
      "n",
      "<leader>gr",
      "<cmd>lua require('substitute').operator({register = '+'})<cr>",
      { noremap = true, silent = true, desc = "substitute with system clipboard" }
    )
    map(
      "n",
      "grr",
      "<cmd>lua require('substitute').line()<cr>",
      { noremap = true, silent = true, desc = "substitute line" }
    )
    map(
      "n",
      "<leader>grr",
      "<cmd>lua require('substitute').line({register = '+'})<cr>",
      { noremap = true, silent = true, desc = "substitute line with system clipboard" }
    )
    map(
      "n",
      "gR",
      "<cmd>lua require('substitute').eol()<cr>",
      { noremap = true, silent = true, desc = "substitute eol" }
    )
    map(
      "n",
      "<leader>gR",
      "<cmd>lua require('substitute').eol({register = '+'})<cr>",
      { noremap = true, silent = true, desc = "substitute eol with system clipboard" }
    )
    map(
      "x",
      "gr",
      "<cmd>lua require('substitute').visual()<cr>",
      { noremap = true, silent = true, desc = "substitute visual" }
    )
    map(
      "x",
      "<leader>gr",
      "<cmd>lua require('substitute').visual({register = '+'})<cr>",
      { noremap = true, silent = true, desc = "substitute visual with system clipboard" }
    )

    map(
      "n",
      "gx",
      "<cmd>lua require('substitute.exchange').operator()<cr>",
      { noremap = true, silent = true, desc = "exchange" }
    )
    map(
      "n",
      "gxx",
      "<cmd>lua require('substitute.exchange').line()<cr>",
      { noremap = true, silent = true, desc = "exchange line" }
    )
    map(
      "x",
      "gx",
      "<cmd>lua require('substitute.exchange').visual()<cr>",
      { noremap = true, silent = true, desc = "exchange visual" }
    )
    map(
      "n",
      "gxc",
      "<cmd>lua require('substitute.exchange').cancel()<cr>",
      { noremap = true, silent = true, desc = "cancel exchange" }
    )
  end,
  opts = {
    on_substitute = function()
      require("yanky.integration").substitute()
    end,
    highlight_substituted_text = {
      enabled = true,
      timer = 500,
    },
    range = {
      prefix = "gr",
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

local stay_in_place = {
  "gbprod/stay-in-place.nvim",
  keys = {
    { ">", mode = { "n", "x" } },
    { "<", mode = { "n", "x" } },
    { "=", mode = { "n", "x" } },
    { ">>", mode = { "n" } },
    { "<<", mode = { "n" } },
    { "==", mode = { "n" } },
  },
  opts = {
    set_keymaps = true,
    preserve_visual_selection = true,
  },
}

local dial = {
  "monaqa/dial.nvim",
  enabled = true,
  keys = {
    { "<C-a>", mode = "n", desc = "Increment" },
    { "<C-x>", mode = "n", desc = "Decrement" },
    { "<C-a>", mode = "v", desc = "Increment" },
    { "<C-x>", mode = "v", desc = "Decrement" },
    { "g<C-a>", mode = "v", desc = "G increment" },
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

    map("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
    map("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
    map("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
    map("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
    map("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
    map("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
  end,
}

local mini_move = {
  "echasnovski/mini.move",
  keys = {
    { "<M-left>", mode = { "n", "x" }, desc = "Move left" },
    { "<M-right>", mode = { "n", "x" }, desc = "Move right" },
    { "<M-up>", mode = { "n", "x" }, desc = "Move up" },
    { "<M-down>", mode = { "n", "x" }, desc = "Move down" },
  },
  opts = {
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = "<M-left>",
      right = "<M-right>",
      down = "<M-down>",
      up = "<M-up>",

      -- Move current line in Normal mode
      line_left = "<M-left>",
      line_right = "<M-right>",
      line_down = "<M-down>",
      line_up = "<M-up>",
    },
  },
}

local surround = {
  "kylechui/nvim-surround",
  keys = {
    {
      "ds",
      "<cmd><Plug>(nvim-surround-delete)<cr>",
      mode = "n",
      desc = "Delete a surrounding pair",
    },
    {
      "cs",
      "<cmd><Plug>(nvim-surround-change)<cr>",
      mode = "n",
      desc = "Change a surrounding pair",
    },
    {
      "cS",
      "<cmd><Plug>(nvim-surround-change-line)<cr>",
      mode = "n",
      desc = "Change a surrounding pair, putting replacements on new lines",
    },
    {
      "gs",
      "<Plug>(nvim-surround-normal)",
      mode = "n",
      desc = "Add a surrounding pair around a motion (normal mode)",
    },
    {
      "gss",
      "<Plug>(nvim-surround-normal-cur)",
      mode = "n",
      desc = "Add a surrounding pair around the current line (normal mode)",
    },
    {
      "gS",
      "<Plug>(nvim-surround-normal-line)",
      mode = "n",
      desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
    },
    {
      "gSS",
      "<Plug>(nvim-surround-normal-cur-line)",
      mode = "n",
      desc = "Add a surrounding pair around the current line, on new lines (normal mode)",
    },
    {
      "gs",
      "<Plug>(nvim-surround-visual)",
      mode = "x",
      desc = "Add a surrounding pair around a visual selection",
    },
    {
      "gS",
      "<Plug>(nvim-surround-visual-line)",
      mode = "x",
      desc = "Add a surrounding pair around a visual selection, on new lines",
    },
    {
      "<c-g>s",
      "<Plug>(nvim-surround-insert)",
      mode = "i",
      desc = "Add a surrounding pair around the cursor (insert mode)",
    },
    {
      "<c-g>s",
      "<Plug>(nvim-surround-insert-line)",
      mode = "i",
      desc = "Add a surrounding pair around the cursor, on new lines (insert mode)",
    },
  },
  opts = {
    keymaps = {},
    move_cursor = false,
  },
}

local textcase = {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  cmd = {
    "TextCaseOpenTelescope",
    "TextCaseOpenTelescopeQuickChange",
    "TextCaseOpenTelescopeLSPChange",
    "TextCaseStartReplacingCommand",
  },
  keys = {
    {
      "gac",
      "<cmd>lua require('textcase').operator('to_camel_case')<CR>",
      desc = "Convert toCamelCase",
    },
    {
      "gad",
      "<cmd>lua require('textcase').operator('to_dashed_case')<CR>",
      desc = "Convert to-dashed-case",
    },
    {
      "gal",
      "<cmd>lua require('textcase').operator('to_lower_case')<CR>",
      desc = "Convert to lower case",
    },
    {
      "gap",
      "<cmd>lua require('textcase').operator('to_pascal_case')<CR>",
      desc = "Convert ToPascalCase",
    },
    {
      "gas",
      "<cmd>lua require('textcase').operator('to_snake_case')<CR>",
      desc = "Convert to_snake_case",
    },
    {
      "gau",
      "<cmd>lua require('textcase').operator('to_upper_case')<CR>",
      desc = "Convert To UPPER CASE",
    },
    {
      "gaC",
      "<cmd>lua require('textcase').lsp_rename('to_camel_case')<CR>",
      desc = "Rename toCamelCase",
    },
    {
      "gaD",
      "<cmd>lua require('textcase').lsp_rename('to_dashed_case')<CR>",
      desc = "Rename to-dashed-case",
    },
    {
      "gaL",
      "<cmd>lua require('textcase').lsp_rename('to_lower_case')<CR>",
      desc = "Rename to lower case",
    },
    {
      "gaP",
      "<cmd>lua require('textcase').lsp_rename('to_pascal_case')<CR>",
      desc = "Rename ToPascalCase",
    },
    {
      "gaS",
      "<cmd>lua require('textcase').lsp_rename('to_snake_case')<CR>",
      desc = "Rename to_snake_case",
    },
    {
      "gaU",
      "<cmd>lua require('textcase').lsp_rename('to_upper_case')<CR>",
      desc = "Rename To UPPER CASE",
    },
    {
      "gaoc",
      "<cmd>lua require('textcase').operator('to_camel_case')<CR>",
      desc = "toCamelCase",
      mode = { "n", "v" },
    },
    {
      "gaod",
      "<cmd>lua require('textcase').operator('to_dashed_case')<CR>",
      desc = "to-dashed-case",
      mode = { "n", "v" },
    },
    {
      "gaol",
      "<cmd>lua require('textcase').operator('to_lower_case')<CR>",
      desc = "to lower case",
      mode = { "n", "v" },
    },
    {
      "gaop",
      "<cmd>lua require('textcase').operator('to_pascal_case')<CR>",
      desc = "ToPascalCase",
      mode = { "n", "v" },
    },
    {
      "gaos",
      "<cmd>lua require('textcase').operator('to_snake_case')<CR>",
      desc = "to_snake_case",
      mode = { "n", "v" },
    },
    {
      "gaou",
      "<cmd>lua require('textcase').operator('to_upper_case')<CR>",
      desc = "To UPPER CASE",
      mode = { "n", "v" },
    },
  },
  config = function()
    require("textcase").setup({
      default_keymappings_enabled = false,
      prefix = "ga",
    })
    require("telescope").load_extension("textcase")
  end,
}

return {
  yanky,
  substitute,
  stay_in_place,
  dial,
  mini_move,
  surround,
  textcase,
}
