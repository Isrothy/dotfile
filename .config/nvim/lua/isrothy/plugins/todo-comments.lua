return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>T/", function() Snacks.picker.todo_comments() end, desc = "Search" },
    {
      "<leader>T?",
      function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end,
      desc = "Search Todo/Fix/Fixme",
    },
    { "]T", function() require("todo-comments").jump_next() end, desc = "Next todo Comment" },
    { "[T", function() require("todo-comments").jump_prev() end, desc = "Previous todo Comment" },
  },

  opts = {
    sign_priority = 30,
    merge_keywords = true,
    highlight = {
      exclude = { "qf" },
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#BF616A" },
      warning = { "DiagnosticWarn", "WarningMsg", "#EBCB8B" },
      info = { "DiagnosticInfo", "#5E81AC" },
      hint = { "DiagnosticHint", "#81A1C1" },
      default = { "Identifier", "#8FBCBB" },
      test = { "Identifier", "#A3BE8C" },
    },
  },
}
