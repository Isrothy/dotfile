return {
  {
    "chrisgrieser/nvim-various-textobjs",
    event = { "BufRead", "BufNewFile" },
    enabled = true,
    init = function()
      local innerOuterMaps = {
        number = "n",
        value = "v",
        key = "k",
        subword = "S", -- lowercase taken for sentence textobj
        notebookCell = "N",
        closedFold = "z", -- z is the common prefix for folds
        chainMember = ".",
        lineCharacterwise = "_",
        greedyOuterIndentation = "g",
        anyQuote = "q",
        anyBracket = "o",
      }
      local oneMaps = {
        nearEoL = "n", -- does override the builtin "to next search match" textobj, but nobody really uses that
        visibleInWindow = "gw",
        toNextClosingBracket = "C", -- % has a race condition with vim's builtin matchit plugin
        toNextQuotationMark = "Q",
        restOfParagraph = "r",
        restOfIndentation = "R",
        restOfWindow = "gW",
        diagnostic = "!",
        column = "|",
        entireBuffer = "gG", -- G + gg
        url = "L", -- gu, gU, and U would conflict with gugu, gUgU, and gUU. u would conflict with gcu (undo comment)
        lastChange = "g;", -- consistent with g; movement
      }
      local ftMaps = {
        { map = { mdlink = "l" }, fts = { "markdown", "toml" } },
        { map = { mdEmphasis = "e" }, fts = { "markdown" } },
        { map = { pyTripleQuotes = "y" }, fts = { "python" } },
        { map = { mdFencedCodeBlock = "C" }, fts = { "markdown" } },
        {
          map = { doubleSquareBrackets = "D" },
          fts = { "lua", "norg", "sh", "fish", "zsh", "bash", "markdown" },
        },
        { map = { cssSelector = "c" }, fts = { "css", "scss" } },
        { map = { cssColor = "#" }, fts = { "css", "scss" } },
        { map = { shellPipe = "P" }, fts = { "sh", "bash", "zsh", "fish" } },
        { map = { htmlAttribute = "x" }, fts = { "html", "css", "scss", "xml", "vue" } },
      }
      local keymap = vim.keymap.set

      for objName, map in pairs(oneMaps) do
        keymap(
          { "o", "x" },
          map,
          "<CMD>lua require('various-textobjs')." .. objName .. "()<CR>",
          { desc = objName .. " textobj" }
        )
      end

      for objName, map in pairs(innerOuterMaps) do
        local name = " " .. objName .. " Textobj"
        keymap(
          { "o", "x" },
          "a" .. map,
          "<CMD>lua require('various-textobjs')." .. objName .. "('outer')<CR>",
          { desc = "outer" .. name }
        )
        keymap(
          { "o", "x" },
          "i" .. map,
          "<CMD>lua require('various-textobjs')." .. objName .. "('inner')<CR>",
          { desc = "inner" .. name }
        )
      end

      local group = vim.api.nvim_create_augroup("VariousTextobjs", {})
      for _, textobj in pairs(ftMaps) do
        vim.api.nvim_create_autocmd("FileType", {
          group = group,
          pattern = textobj.fts,
          callback = function()
            for objName, map in pairs(textobj.map) do
              local name = " " .. objName .. " Textobj"
              keymap(
                { "o", "x" },
                "a" .. map,
                ("<CMD>lua require('various-textobjs').%s('%s')<CR>"):format(objName, "outer"),
                { desc = "outer" .. name, buffer = true }
              )
              keymap(
                { "o", "x" },
                "i" .. map,
                ("<CMD>lua require('various-textobjs').%s('%s')<CR>"):format(objName, "inner"),
                { desc = "inner" .. name, buffer = true }
              )
            end
          end,
        })
      end
    end,
    opts = {
      keymaps = {
        useDefaults = false,
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          C = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          -- t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },

        search_method = "cover_or_next",
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
  },
}
