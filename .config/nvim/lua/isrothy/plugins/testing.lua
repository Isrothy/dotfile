return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rcasia/neotest-java",
      "alfaix/neotest-gtest",
      "nvim-neotest/neotest-python",
      "mfussenegger/nvim-dap",
    },
    keys = {
      {
        "<leader>tt",
        function()
          vim.notify("Running current test file")
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run file",
      },
      {
        "<leader>tT",
        function()
          vim.notify("Running all test files")
          require("neotest").run.run(vim.loop.cwd())
        end,
        desc = "Run all test files",
      },
      {
        "<leader>tr",
        function()
          vim.notify("Running nearest test")
          require("neotest").run.run()
        end,
        desc = "Run nearest",
      },
      {
        "<leader>tl",
        function()
          vim.notify("Running last test")
          require("neotest").run.run_last()
        end,
        desc = "Run last",
      },
      {
        "<leader>ts",
        function() require("neotest").summary.toggle() end,
        desc = "Toggle summary",
      },
      {
        "<leader>to",
        function() require("neotest").output.open({ enter = true, auto_close = true }) end,
        desc = "Show output",
      },
      {
        "<leader>tO",
        function() require("neotest").output_panel.toggle() end,
        desc = "Toggle output panel",
      },
      {
        "<leader>tS",
        function()
          vim.notify("Stopping tests")
          require("neotest").run.stop()
        end,
        desc = "Stop",
      },
      {
        "<leader>td",
        function() require("neotest").run.run({ strategy = "dap" }) end,
        desc = "Debug nearest",
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
        },
      }
    end,
  },
}
