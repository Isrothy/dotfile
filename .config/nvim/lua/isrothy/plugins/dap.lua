return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        { "nvim-neotest/nvim-nio" },
      },
      keys = {
        { "<LEADER>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
        { "<LEADER>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "x" } },
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
    { "<LEADER>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest" },
  },

  config = function()
    require("dap-python").setup("/opt/homebrew/bin/python3.11", {})

    local dap = require("dap")

    dap.adapters.haskell = {
      type = "executable",
      command = "haskell-debug-adapter",
      args = { "--hackage-version=0.0.33.0" },
    }
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
        ghciPrompt = "ghci> ",
        -- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
        ghciInitialPrompt = "ghci> ",
        ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
      },
    }

    dap.adapters.lldb = {
      type = "executable",
      command = "/opt/homebrew/opt/llvm/bin/lldb-dap", -- adjust as needed, must be absolute path
      name = "lldb",
    }

    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = true,
        args = {},
        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        -- runInTerminal = false,
      },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end,
}
