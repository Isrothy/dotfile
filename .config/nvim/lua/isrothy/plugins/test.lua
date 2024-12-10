local neotest = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "mrcjkb/neotest-haskell",
    "rcasia/neotest-java",
    "alfaix/neotest-gtest",
    "nvim-neotest/neotest-python",
  },
  keys = {
    {
      "<LEADER>tt",
      function()
        vim.notify("Running current test file")
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run File",
    },
    {
      "<LEADER>tT",
      function()
        vim.notify("Running all test files")
        require("neotest").run.run(vim.loop.cwd())
      end,
      desc = "Run All Test Files",
    },
    {
      "<LEADER>tr",
      function()
        vim.notify("Running nearest test")
        require("neotest").run.run()
      end,
      desc = "Run Nearest",
    },
    {
      "<LEADER>tl",
      function()
        vim.notify("Running last test")
        require("neotest").run.run_last()
      end,
      desc = "Run Last",
    },
    {
      "<LEADER>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Summary",
    },
    {
      "<LEADER>to",
      function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end,
      desc = "Show Output",
    },
    {
      "<LEADER>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle Output Panel",
    },
    {
      "<LEADER>tS",
      function()
        vim.notify("Stopping tests")
        require("neotest").run.stop()
      end,
      desc = "Stop",
    },
  },
  opts = function()
    return {
      status = {
        virtual_text = false,
        signs = true,
      },
      output = {
        enabled = true,
        open_on_run = true,
      },
      quickfix = {
        enabled = true,
        open = true,
      },
      consumers = {
        overseer = require("neotest.consumers.overseer"),
      },
      adapters = {
        require("rustaceanvim.neotest"),
        require("neotest-python"),
        require("neotest-gtest").setup({}),
        require("neotest-java")({
          ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
        }),
        require("neotest-haskell")({
          build_tools = { "stack", "cabal" },
          frameworks = { "hspec" },
        }),
      },
    }
  end,
}

return {
  neotest,
}
