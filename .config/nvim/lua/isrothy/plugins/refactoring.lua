return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<LEADER>rs",
        mode = "v",
        desc = "Refactor",
      },
      {
        "<LEADER>ri",
        function() require("refactoring").refactor("Inline Variable") end,
        mode = { "n", "v" },
        desc = "Inline variable",
      },
      {
        "<LEADER>rb",
        function() require("refactoring").refactor("Extract Block") end,
        desc = "Extract block",
      },
      {
        "<LEADER>rf",
        function() require("refactoring").refactor("Extract Block To File") end,
        desc = "Extract block to file",
      },
      {
        "<LEADER>rP",
        function() require("refactoring").debug.printf({ below = false }) end,
        desc = "Debug print",
      },
      {
        "<LEADER>rp",
        function() require("refactoring").debug.print_var({ normal = true }) end,
        desc = "Debug print variable",
      },
      {
        "<LEADER>rc",
        function() require("refactoring").debug.cleanup({}) end,
        desc = "Debug cleanup",
      },
      {
        "<LEADER>rf",
        function() require("refactoring").refactor("Extract Function") end,
        mode = "v",
        desc = "Extract function",
      },
      {
        "<LEADER>rF",
        function() require("refactoring").refactor("Extract Function To File") end,
        mode = "v",
        desc = "Extract function to file",
      },
      {
        "<LEADER>rx",
        function() require("refactoring").refactor("Extract Variable") end,
        mode = "v",
        desc = "Extract variable",
      },
      {
        "<LEADER>rp",
        function() require("refactoring").debug.print_var() end,
        mode = "v",
        desc = "Debug print variable",
      },
    },
    opts = {
      prompt_func_return_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = true,
    },
  },
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    keys = { "<LEADER>rd", "<CMD>Neogen<CR>", desc = "Generate docstring" },
    cmd = "Neogen",
    opts = {
      snippet_engine = "nvim",
    },
  },
}
