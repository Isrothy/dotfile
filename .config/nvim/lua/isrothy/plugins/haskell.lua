return {
  {
    "MrcJkb/haskell-tools.nvim",
    version = "^4",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    keys = {
      { "<LOCALLEADER>h", "", desc = "+Haskell tools", ft = { "haskell", "lhaskell" } },
      {
        "<LOCALLEADER>he",
        function() require("haskell-tools").lsp.buf_eval_all() end,
        desc = "Evaluate all",
        ft = { "haskell", "lhaskell" },
      },
      { "<LOCALLEADER>hr", "", desc = "+REPL", ft = { "haskell", "lhaskell" } },
      {
        "<LOCALLEADER>hh",
        function() require("haskell-tools").hoogle.hoogle_signature() end,
        desc = "Hoogle signature",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<LOCALLEADER>hrt",
        function() require("haskell-tools").repl.toggle() end,
        desc = "Toggle repl",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<LOCALLEADER>hrb",
        function() require("haskell-tools").repl.toggle(vim.api.nvim_buf_get_name(0)) end,
        desc = "Toggle repl for current buffer",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<LOCALLEADER>hrr",
        function() require("haskell-tools").repl.reload() end,
        desc = "Reload repl",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<LOCALLEADER>hrq",
        function() require("haskell-tools").repl.quit() end,
        desc = "Quit repl",
        ft = { "haskell", "lhaskell" },
      },

      { "<LOCALLEADER>hp", "", desc = "+Project", ft = { "haskell", "lhaskell" } },
      {
        "<LOCALLEADER>hpp",
        function() require("haskell-tools").project.open_project_file() end,
        desc = "Open project file",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<LOCALLEADER>hpy",
        function() require("haskell-tools").project.open_package_yaml() end,
        desc = "Open project yaml",
        ft = { "haskell", "lhaskell" },
      },
      {
        "<LOCALLEADER>hpc",
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
