return {
  {
    "chrisgrieser/nvim-various-textobjs",
    event = { "BufRead", "BufNewFile" },
    enabled = true,
    init = function()
      local innerOuterMaps = {
        number = "n",
        value = "v",
        subword = "S", -- lowercase taken for sentence textobj
        -- notebookCell = "N",
        closedFold = "z",
        chainMember = ".",
        lineCharacterwise = "_",
        -- greedyOuterIndentation = "g",
        -- anyQuote = "q",
        -- anyBracket = "o",
      }
      local oneMaps = {
        nearEoL = "n", -- does override the builtin "to next search match" textobj, but nobody really uses that
        visibleInWindow = "gw",
        toNextClosingBracket = "C", -- % has a race condition with vim's builtin matchit plugin
        toNextQuotationMark = "Q",
        -- restOfParagraph = "r",
        -- restOfIndentation = "R",
        -- restOfWindow = "gW",
        -- diagnostic = "!",
        -- column = "|",
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
          "<cmd>lua require('various-textobjs')." .. objName .. "()<cr>",
          { desc = objName .. " textobj" }
        )
      end

      for objName, map in pairs(innerOuterMaps) do
        local name = " " .. objName .. " Textobj"
        keymap(
          { "o", "x" },
          "a" .. map,
          "<cmd>lua require('various-textobjs')." .. objName .. "('outer')<cr>",
          { desc = "outer" .. name }
        )
        keymap(
          { "o", "x" },
          "i" .. map,
          "<cmd>lua require('various-textobjs')." .. objName .. "('inner')<cr>",
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
                ("<cmd>lua require('various-textobjs').%s('%s')<cr>"):format(objName, "outer"),
                { desc = "outer" .. name, buffer = true }
              )
              keymap(
                { "o", "x" },
                "i" .. map,
                ("<cmd>lua require('various-textobjs').%s('%s')<cr>"):format(objName, "inner"),
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
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "af",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end,
        mode = { "x", "o" },
        desc = "Around function",
      },
      {
        "if",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end,
        mode = { "x", "o" },
        desc = "Inside function",
      },
      {
        "ac",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end,
        mode = { "x", "o" },
        desc = "Around class",
      },
      {
        "ic",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end,
        mode = { "x", "o" },
        desc = "Inside class",
      },
      {
        "al",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects") end,
        mode = { "x", "o" },
        desc = "Around loop",
      },
      {
        "il",
        function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects") end,
        mode = { "x", "o" },
        desc = "Inside loop",
      },
    },
    opts = {
      move = {
        set_jumps = true,
      },
      select = {
        lookahead = true,
      },
    },
  },
}
