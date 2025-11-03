return {
  "mfussenegger/nvim-dap",
  init = function()
    vim.fn.sign_define("DapBreakpoint", {
      text = " ",
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointCondition", {
      text = " ",
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapLogPoint", {
      text = " ",
      texthl = "DapLogPoint",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapStopped", {
      text = " ",
      texthl = "DapBreakpointStopped",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = " ",
      texthl = "DapBreakpointRejected",
      linehl = "",
      numhl = "",
    })
  end,
  dependencies = {
    {
      "igorlfs/nvim-dap-view",
      ---@module 'dap-view'
      ---@type dapview.Config
      opts = {},
      keys = {
        { "<leader>du", function() require("dap-view").toggle() end, desc = "Toggle Dap View" },
      },
    },

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
      "mfussenegger/nvim-dap-python",
      keys = {
        { "<localleader>pd", "", desc = "+Debug", ft = { "python" } },
        { "<localleader>pdt", function() require("dap-python").test_method() end, desc = "Method", ft = { "python" } },
        { "<localleader>pdc", function() require("dap-python").test_class() end, desc = "Class", ft = { "python" } },
      },
    },
    {
      "mason-org/mason.nvim",
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
      "<leader>dB",
      function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
      desc = "Breakpoint condition",
    },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    require("dap-python").setup("python3", {})

    local dap = require("dap")

    dap.adapters.haskell = {
      type = "executable",
      command = "haskell-debug-adapter",
      args = { "--hackage-version=0.0.33.0" },
    }
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
    dap.configurations.haskell = {
      {
        type = "haskell",
        request = "launch",
        name = "Debug",
        workspace = "${workspaceFolder}",
        startup = "${file}",
        stopOnEntry = true,
        logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
        logLevel = "WARNING",
        ghciEnv = vim.empty_dict(),
        ghciPrompt = "λ: ",
        -- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
        ghciInitialPrompt = "λ: ",
        ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
      },
    }
  end,
}
