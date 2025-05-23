return {
  "pogyomo/submode.nvim",
  dependencies = {
    "mrjones2014/smart-splits.nvim",
  },
  keys = {
    { "<leader>wr", desc = "Enter resize mode" },
    { "<leader>dd", desc = "Enter debug mode" },
  },
  config = function()
    local submode = require("submode")
    submode.create("WinResize", {
      mode = "n",
      enter = "<leader>wr",
      leave = { "<esc>", "q", "<c-c>" },
      hook = {
        on_enter = function()
          vim.notify("Use { h, j, k, l } or { <Left>, <Down>, <Up>, <Right> } to resize the window")
        end,
        on_leave = function() vim.notify("Exit resize mode") end,
      },
      default = function(register)
        register("h", require("smart-splits").resize_left, { desc = "Resize left" })
        register("j", require("smart-splits").resize_down, { desc = "Resize down" })
        register("k", require("smart-splits").resize_up, { desc = "Resize up" })
        register("l", require("smart-splits").resize_right, { desc = "Resize right" })
        register("<Left>", require("smart-splits").resize_left, { desc = "Resize left" })
        register("<Down>", require("smart-splits").resize_down, { desc = "Resize down" })
        register("<Up>", require("smart-splits").resize_up, { desc = "Resize up" })
        register("<Right>", require("smart-splits").resize_right, { desc = "Resize right" })
        register("=", "<c-w>=", { desc = "Resize equal" })
        register("+", "<c-w>+", { desc = "Increase hright" })
        register("-", "<c-w>-", { desc = "Decrease height" })
        register("_", "<c-w>_", { desc = "Maximize height" })
        register(">", "<c-w>>", { desc = "Increase width" })
        register("<", "<c-w><", { desc = "Decrease width" })
        register("|", "<c-w>|", { desc = "Maximize width" })
      end,
    })
    submode.create("Debug", {
      mode = "n",
      enter = "<leader>dd",
      leave = { "<esc>", "q", "<c-c>" },
      hook = {
        on_enter = function() vim.notify("Enter debug mode") end,
        on_leave = function() vim.notify("Exit debug mode") end,
      },
      default = function(register)
        register("c", function() require("dap").continue() end, { desc = "Continue" })
        register("C", function() require("dap").run_to_cursor() end, { desc = "Run to cursor" })
        register("g", function() require("dap").goto_() end, { desc = "Go to line (no execute)" })
        register("i", function() require("dap").step_into() end, { desc = "Step into" })
        register("j", function() require("dap").down() end, { desc = "Down" })
        register("k", function() require("dap").up() end, { desc = "Up" })
        register("l", function() require("dap").run_last() end, { desc = "Run last" })
        register("o", function() require("dap").step_out() end, { desc = "Step out" })
        register("O", function() require("dap").step_over() end, { desc = "Step over" })
        register("p", function() require("dap").pause() end, { desc = "Pause" })
        register("s", function() require("dap").session() end, { desc = "Session" })
      end,
    })
  end,
}
