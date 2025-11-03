return {
  {
    "MrcJkb/haskell-tools.nvim",
    version = "^6",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    keys = {
      { "<localleader>h", "", desc = "+Haskell tools", ft = { "haskell", "lhaskell" } },
      {
        "<localleader>he",
        function() require("haskell-tools").lsp.buf_eval_all() end,
        desc = "Evaluate all",
        ft = { "haskell", "lhaskell" },
      },
      { "<localleader>hr", "", desc = "+REPL", ft = { "haskell", "lhaskell" } },
      {
        "<localleader>hh",
        function() require("haskell-tools").hoogle.hoogle_signature() end,
        desc = "Hoogle signature",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<localleader>hrt",
        function() require("haskell-tools").repl.toggle() end,
        desc = "Toggle repl",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<localleader>hrb",
        function() require("haskell-tools").repl.toggle(vim.api.nvim_buf_get_name(0)) end,
        desc = "Toggle repl for current buffer",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<localleader>hrr",
        function() require("haskell-tools").repl.reload() end,
        desc = "Reload repl",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<localleader>hrq",
        function() require("haskell-tools").repl.quit() end,
        desc = "Quit repl",
        ft = { "haskell", "lhaskell" },
      },

      { "<localleader>hp", "", desc = "+Project", ft = { "haskell", "lhaskell" } },
      {
        "<localleader>hpp",
        function() require("haskell-tools").project.open_project_file() end,
        desc = "Open project file",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<localleader>hpy",
        function() require("haskell-tools").project.open_package_yaml() end,
        desc = "Open project yaml",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<localleader>hpc",
        function() require("haskell-tools").project.open_package_cabal() end,
        desc = "Open project cabal",
        ft = { "haskell", "lhaskell" },
      },
    },
    init = function()
      vim.g.haskell_tools = {
        tools = {
          repl = {
            -- 'builtin': Use the simple builtin repl
            -- 'toggleterm': Use akinsho/toggleterm.nvim
            handler = "toggleterm",
            builtin = {
              create_repl_window = function(view) return view.create_repl_split({ size = vim.o.lines / 3 }) end,
            },
          },
          hover = {
            stylize_markdown = true,
            auto_focus = false,
          },
          tags = {
            enable = false,
            package_events = { "BufWritePost" },
          },
        },
        hls = {
          default_settings = {
            haskell = {
              formattingProvider = "ormolu",
              checkProject = true,
            },
          },
        },
      }
    end,
  },
}
