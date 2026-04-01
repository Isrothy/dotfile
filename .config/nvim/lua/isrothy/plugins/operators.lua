vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local map = vim.keymap.set
    local is_windows = jit.os:find("Windows")

    require("yanky").setup({
      highlight = { timer = 200 },
      ring = {
        storage = is_windows and "shada" or "sqlite",
      },
    })

    map({ "n", "x" }, "<leader>y", '"+<plug>(YankyYank)', { desc = "Yank text to system clipboard" })
    map("x", "<leader>Y", 'V"+<plug>(YankyYank)', { desc = "Yank selected lines to system clipboard" })
    map("n", "<leader>Y", '"+<plug>(YankyYank)$', { desc = "Yank EOL to system clipboard" })
    map({ "n", "x" }, "<leader>p", '"+<plug>(YankyPutAfter)', { desc = "Put text from system clipboard after cursor" })
    map(
      { "n", "x" },
      "<leader>P",
      '"+<plug>(YankyPutBefore)',
      { desc = "Put text from system clipboard before cursor" }
    )

    map({ "n", "x" }, "y", "<plug>(YankyYank)", { desc = "Yank text" })
    map("n", "Y", "<plug>(YankyYank)$", { desc = "Yank EOL" })
    map("x", "Y", "V<plug>(YankyYank)", { desc = "Yank selected lines" })
    map({ "n", "x" }, "p", "<plug>(YankyPutAfter)", { desc = "Put yanked text after cursor" })
    map({ "n", "x" }, "P", "<plug>(YankyPutBefore)", { desc = "Put yanked text before cursor" })
    map({ "n", "x" }, "gp", "<plug>(YankyGPutAfter)", { desc = "Put yanked text after selection" })
    map({ "n", "x" }, "gP", "<plug>(YankyGPutBefore)", { desc = "Put yanked text before selection" })

    map("n", "[y", "<plug>(YankyCycleForward)", { desc = "Cycle forward through yank history" })
    map("n", "]y", "<plug>(YankyCycleBackward)", { desc = "Cycle backward through yank history" })
    map("n", "]p", "<plug>(YankyPutIndentAfterLinewise)", { desc = "Put indented after cursor (linewise)" })
    map("n", "[p", "<plug>(YankyPutIndentBeforeLinewise)", { desc = "Put indented before cursor (linewise)" })
    map("n", "]P", "<plug>(YankyPutIndentAfterLinewise)", { desc = "Put indented after cursor (linewise)" })
    map("n", "[P", "<plug>(YankyPutIndentBeforeLinewise)", { desc = "Put indented before cursor (linewise)" })
    map("n", ">p", "<plug>(YankyPutIndentAfterShiftRight)", { desc = "Put and indent right" })
    map("n", "<p", "<plug>(YankyPutIndentAfterShiftLeft)", { desc = "Put and indent left" })
    map("n", ">P", "<plug>(YankyPutIndentBeforeShiftRight)", { desc = "Put before and indent right" })
    map("n", "<P", "<plug>(YankyPutIndentBeforeShiftLeft)", { desc = "Put before and indent left" })
    map("n", "=p", "<plug>(YankyPutAfterFilter)", { desc = "Put after applying a filter" })
    map("n", "=P", "<plug>(YankyPutBeforeFilter)", { desc = "Put before applying a filter" })

    map(
      "n",
      "gyc",
      "<plug>(YankyYank)y<cmd>normal gcc<cr>p",
      { desc = "Duplicate a line and comment out the first line" }
    )
    map("n", "gyr", ":call setreg('+', getreg('@'))<cr>", { desc = "Yank register to system clipboard" })
    map(
      "n",
      "gyp",
      ":call setreg('+', expand('%:.') .. ':' .. line('.'))<cr>",
      { desc = "Yank filename and line number to system clipboard" }
    )

    -- ==========================================
    -- 2. Substitute.nvim
    -- ==========================================
    require("substitute").setup({
      on_substitute = function() require("yanky.integration").substitute() end,
      highlight_substituted_text = { enabled = true, timer = 500 },
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
      exchange = { motion = false, use_esc_to_cancel = true, preserve_cursor_position = false },
    })

    local sub = require("substitute")
    local sub_exc = require("substitute.exchange")

    map("n", "s", function() sub.operator() end, { desc = "Substitute" })
    map(
      "n",
      "<leader>s",
      function() sub.operator({ register = "+" }) end,
      { desc = "Substitute with system clipboard" }
    )
    map("n", "ss", function() sub.line() end, { desc = "Substitute line" })
    map(
      "n",
      "<leader>ss",
      function() sub.line({ register = "+" }) end,
      { desc = "Substitute line with system clipboard" }
    )
    map("n", "S", function() sub.eol() end, { desc = "Substitute EOL" })
    map("n", "<leader>S", function() sub.eol({ register = "+" }) end, { desc = "Substitute EOL with system clipboard" })
    map("x", "s", function() sub.visual() end, { desc = "Substitute visual" })
    map(
      "x",
      "<leader>s",
      function() sub.visual({ register = "+" }) end,
      { desc = "Substitute visual with system clipboard" }
    )

    map("x", "S", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("V", true, true, true), "n", false)
      vim.schedule_wrap(sub.visual)()
    end, { desc = "Substitute selected lines" })

    map("x", "<leader>S", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("V", true, true, true), "n", false)
      vim.schedule_wrap(sub.visual)({ register = "+" })
    end, { desc = "Substitute selected lines with system clipboard" })

    map("n", "x", function() sub_exc.operator() end, { desc = "Exchange" })
    map("n", "xx", function() sub_exc.line() end, { desc = "Exchange line" })
    map("n", "X", function() sub_exc.operator({ motion = "$" }) end, { desc = "Exchange EOL" })
    map("x", "x", function() sub_exc.visual() end, { desc = "Exchange visual" })
    map("x", "X", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("V", true, true, true), "n", false)
      vim.schedule_wrap(sub_exc.visual)()
    end, { desc = "Exchange selected lines" })

    -- ==========================================
    -- 3. Dial.nvim
    -- ==========================================
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
        augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "min", "max" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "True", "False" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "lower", "upper" }, word = false, cyclic = true }),
        augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
        augend.constant.new({ elements = { "&", "|" }, word = false, cyclic = true }),
        augend.constant.new({ elements = { "+", "-" }, word = false, cyclic = true }),
        augend.constant.new({ elements = { "++", "--" }, word = false, cyclic = true }),
        augend.constant.new({ elements = { ">>", "<<" }, word = false, cyclic = true }),
        augend.constant.new({ elements = { ">", "<" }, word = false, cyclic = true }),
        augend.constant.new({ elements = { ">=", "<=" }, word = false, cyclic = true }),
        augend.hexcolor.new({ case = "lower" }),
        augend.hexcolor.new({ case = "upper" }),
      },
    })

    local dial_map = require("dial.map")
    map("n", "<c-a>", function() dial_map.manipulate("increment", "normal") end, { desc = "Increment" })
    map("n", "<c-x>", function() dial_map.manipulate("decrement", "normal") end, { desc = "Decrement" })
    map("n", "g<c-a>", function() dial_map.manipulate("increment", "gnormal") end, { desc = "G increment" })
    map("n", "g<c-x>", function() dial_map.manipulate("decrement", "gnormal") end, { desc = "G decrement" })
    map("x", "<c-a>", function() dial_map.manipulate("increment", "visual") end, { desc = "Increment" })
    map("x", "<c-x>", function() dial_map.manipulate("decrement", "visual") end, { desc = "Decrement" })
    map("x", "g<c-a>", function() dial_map.manipulate("increment", "gvisual") end, { desc = "G Increment" })
    map("x", "g<c-x>", function() dial_map.manipulate("decrement", "gvisual") end, { desc = "G Decrement" })

    vim.g.nvim_surround_no_mappings = true

    require("nvim-surround").setup({
      move_cursor = false,
      alias = {
        ["a"] = ">",
        ["A"] = "<",
        ["p"] = ")",
        ["P"] = "(",
        ["c"] = "}",
        ["C"] = "{",
        ["b"] = "]",
        ["B"] = "[",
        ["q"] = { '"', "'", "`" },
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
      },
    })

    map("n", "ds", "<plug>(nvim-surround-delete)", { desc = "Delete a surrounding pair" })
    map("n", "cs", "<plug>(nvim-surround-change)", { desc = "Change a surrounding pair" })
    map(
      "n",
      "cS",
      "<plug>(nvim-surround-change-line)",
      { desc = "Change a surrounding pair, putting replacements on new lines" }
    )
    map("n", "gs", "<plug>(nvim-surround-normal)", { desc = "Add a surrounding pair around a motion" })
    map("n", "gss", "(nvim-surround-normal-cur)", { desc = "Add a surrounding pair around the current line" })
    map("n", "gS", "(nvim-surround-normal-line)", { desc = "Add a surrounding pair around a motion, on new lines" })
    map(
      "n",
      "gSS",
      "(nvim-surround-normal-cur-line)",
      { desc = "Add a surrounding pair around the current line, on new lines" }
    )
    map("x", "gs", "(nvim-surround-visual)", { desc = "Add a surrounding pair around a Visual selection" })
    map(
      "x",
      "gS",
      "(nvim-surround-visual-line)",
      { desc = "Add a surrounding pair around a visual selection, on new lines" }
    )
    map("i", "<c-g>s", "(nvim-surround-insert)", { desc = "Add a surrounding pair Around the cursor" })
    map(
      "i",
      "<c-g>s",
      "(nvim-surround-insert-line)",
      { desc = "Add a surrounding pair around the cursor, on new lines" }
    )

    -- ==========================================
    -- 5. Text-Case
    -- ==========================================
    require("textcase").setup({
      default_keymappings_enabled = false,
    })

    local tc = require("textcase")
    map({ "n", "x" }, "gac", function() tc.operator("to_camel_case") end, { desc = "toCamelCase" })
    map({ "n", "x" }, "gad", function() tc.operator("to_dash_case") end, { desc = "to-dash-case" })
    map({ "n", "x" }, "gaf", function() tc.operator("to_phrase_case") end, { desc = "To phrase case" })
    map({ "n", "x" }, "gal", function() tc.operator("to_lower_case") end, { desc = "to lower case" })
    map({ "n", "x" }, "gan", function() tc.operator("to_constant_case") end, { desc = "Convert to CONSTANT_CASE" })
    map({ "n", "x" }, "gap", function() tc.operator("to_pascal_case") end, { desc = "ToPascalCase" })
    map({ "n", "x" }, "gas", function() tc.operator("to_snake_case") end, { desc = "to_snake_case" })
    map({ "n", "x" }, "gat", function() tc.operator("to_title_case") end, { desc = "To Title Case" })
    map({ "n", "x" }, "gau", function() tc.operator("to_upper_case") end, { desc = "TO UPPER CASE" })
    map({ "n", "x" }, "gax", function() tc.operator("to_title_dash_case") end, { desc = "To-Title-Dash-Case" })
    map({ "n", "x" }, "ga.", function() tc.operator("to_dot_case") end, { desc = "to.dot.case" })
    map({ "n", "x" }, "ga,", function() tc.operator("to_comma_case") end, { desc = "to,comma,case" })
    map({ "n", "x" }, "ga/", function() tc.operator("to_path_case") end, { desc = "to/path/case" })

    -- LSP Rename bindings
    map("n", "<leader>kc", function() tc.lsp_rename("to_camel_case") end, { desc = "toCamelCase" })
    map("n", "<leader>kd", function() tc.lsp_rename("to_dashed_case") end, { desc = "to-dashed-case" })
    map("n", "<leader>ke", function() tc.lsp_rename("to_phrase_case") end, { desc = "To Phrase case" })
    map("n", "<leader>kl", function() tc.lsp_rename("to_lower_case") end, { desc = "to lower case" })
    map("n", "<leader>kn", function() tc.lsp_rename("to_constant_case") end, { desc = "TO_CONSTANT_CASE" })
    map("n", "<leader>kp", function() tc.lsp_rename("to_pascal_case") end, { desc = "ToPascalCase" })
    map("n", "<leader>ks", function() tc.lsp_rename("to_snake_case") end, { desc = "to_snake_case" })
    map("n", "<leader>kt", function() tc.lsp_rename("to_title_case") end, { desc = "To Title Case" })
    map("n", "<leader>ku", function() tc.lsp_rename("to_upper_case") end, { desc = "TO UPPER CASE" })
    map("n", "<leader>kx", function() tc.lsp_rename("to_title_dash_case") end, { desc = "To-Title-Dash-Case" })
    map("n", "<leader>k.", function() tc.lsp_rename("to_dot_case") end, { desc = "to.dot.case" })
    map("n", "<leader>k,", function() tc.lsp_rename("to_comma_case") end, { desc = "to,comma,case" })
    map("n", "<leader>k/", function() tc.lsp_rename("to_path_case") end, { desc = "to/path/case" })
  end,
})
