local custom_textobjects = {
  f = {
    a = "@function.outer",
    i = "@function.inner",
  },
  o = {
    a = { "@conditional.outer", "@loop.outer" },
    i = { "@conditional.inner", "@loop.inner" },
  },
  c = {
    a = "@class.outer",
    i = "@class.inner",
  },
  C = {
    a = "@comment.outer",
    i = "@comment.inner",
  },
  s = {
    a = "@statement.outer",
    i = "@statement.inner",
  },
  b = {
    a = "@block.outer",
    i = "@block.inner",
  },
  p = {
    a = "@parameter.outer",
    i = "@parameter.inner",
  },
  t = {
    a = "@call.outer",
    i = "@call.inner",
  },
  m = {
    a = "@method.outer",
    i = "@method.inner",
  },
}

return {
  {
    "kiyoon/treesitter-indent-object.nvim",
    enabled = true,
    dependencies = {
      "lukas-reineke/indent-blankline.nvim",
    },
    keys = {
      {
        "ai",
        function()
          require("treesitter_indent_object.textobj").select_indent_outer()
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer)",
      },
      {
        "aI",
        function()
          require("treesitter_indent_object.textobj").select_indent_outer(true)
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer, line-wise)",
      },
      {
        "ii",
        function()
          require("treesitter_indent_object.textobj").select_indent_inner()
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, partial range)",
      },
      {
        "iI",
        function()
          require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
      },
    },
  },
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
        chainMember = "m",
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
          "<cmd>lua require('various-textobjs')." .. objName .. "()<CR>",
          { desc = objName .. " textobj" }
        )
      end

      for objName, map in pairs(innerOuterMaps) do
        local name = " " .. objName .. " textobj"
        keymap(
          { "o", "x" },
          "a" .. map,
          "<cmd>lua require('various-textobjs')." .. objName .. "('outer')<CR>",
          { desc = "outer" .. name }
        )
        keymap(
          { "o", "x" },
          "i" .. map,
          "<cmd>lua require('various-textobjs')." .. objName .. "('inner')<CR>",
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
              local name = " " .. objName .. " textobj"
              keymap(
                { "o", "x" },
                "a" .. map,
                ("<cmd>lua require('various-textobjs').%s('%s')<CR>"):format(objName, "outer"),
                { desc = "outer" .. name, buffer = true }
              )
              keymap(
                { "o", "x" },
                "i" .. map,
                ("<cmd>lua require('various-textobjs').%s('%s')<CR>"):format(objName, "inner"),
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
    enabled = true,
    event = { "BufReadPost", "BufNewFile" },
    depenencies = {
      "nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local spec_treesitter = require("mini.ai").gen_spec.treesitter
      local custom_textobj = {}
      for key, val in pairs(custom_textobjects) do
        custom_textobj[key] = spec_treesitter(val)
      end

      require("mini.ai").setup({
        -- Table with textobject id as fields, textobject specification as values.
        -- Also use this to disable builtin textobjects. See |MiniAi.config|.
        custom_textobjects = custom_textobj,

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Main textobject prefixes
          around = "a",
          inside = "i",
          -- Next/last variants
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",

          -- Move cursor to corresponding edge of `a` textobject
          goto_left = "g[",
          goto_right = "g]",
        },

        -- Number of lines within which textobject is searched
        n_lines = 50,

        -- How to search for object (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
        search_method = "cover_or_next",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
  },
}
