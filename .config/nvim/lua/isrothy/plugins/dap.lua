return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        { "nvim-neotest/nvim-nio" },
      },
      keys = {
        { "<LOCALLEADER>pdu", function() require("dapui").toggle({}) end, desc = "Dap UI" },
        { "<LOCALLEADER>pde", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "x" } },
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
        require("overseer").enable_dap()
      end,
    },

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
      "mfussenegger/nvim-dap-python",
      keys = {
        { "<LOCALLEADER>p", "", desc = "+Python", ft = "python" },
        { "<LOCALLEADER>pd", "", desc = "+Debug", ft = "python" },
        { "<LOCALLEADER>pdt", function() require("dap-python").test_method() end, desc = "Method", ft = "python" },
        { "<LOCALLEADER>pdc", function() require("dap-python").test_class() end, desc = "Class", ft = "python" },
      },
    },
    {
      "williamboman/mason.nvim",
      optional = true,
      opts = {
        ensure_installed = {
          "codelldb",
          "haskell-debug-adapter",
        },
      },
    },
  },

  keys = {
    {
      "<LEADER>dB",
      function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
      desc = "Breakpoint condition",
    },
    { "<LEADER>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
    { "<LEADER>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<LEADER>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
    { "<LEADER>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<LEADER>di", function() require("dap").step_into() end, desc = "Step into" },
    { "<LEADER>dj", function() require("dap").down() end, desc = "Down" },
    { "<LEADER>dk", function() require("dap").up() end, desc = "Up" },
    { "<LEADER>dl", function() require("dap").run_last() end, desc = "Run last" },
    { "<LEADER>do", function() require("dap").step_out() end, desc = "Step out" },
    { "<LEADER>dO", function() require("dap").step_over() end, desc = "Step over" },
    { "<LEADER>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<LEADER>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<LEADER>ds", function() require("dap").session() end, desc = "Session" },
    { "<LEADER>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<LEADER>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    require("dap-python").setup("python3", {})

    local dap = require("dap")

    dap.adapters.codelldb = {
      type = "executable",
      command = "codelldb",
    }
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
      {
        type = "codelldb",
        request = "attach",
        name = "Attach to process",
        pid = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end,
}
