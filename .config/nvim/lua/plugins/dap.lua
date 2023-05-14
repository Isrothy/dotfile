return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {

		-- fancy UI for the debugger
		{
			"rcarriga/nvim-dap-ui",
			keys = {
				{
					"<leader>du",
					function()
						require("dapui").toggle({})
					end,
					desc = "Dap UI",
				},
				{
					"<leader>de",
					function()
						require("dapui").eval()
					end,
					desc = "Eval",
					mode = { "n", "v" },
				},
			},
			opts = {},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end
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
			"<leader>DB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Breakpoint Condition",
		},
		{
			"<leader>Db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>Dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>DC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<leader>Dg",
			function()
				require("dap").goto_()
			end,
			desc = "Go to line (no execute)",
		},
		{
			"<leader>Di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>Dj",
			function()
				require("dap").down()
			end,
			desc = "Down",
		},
		{
			"<leader>Dk",
			function()
				require("dap").up()
			end,
			desc = "Up",
		},
		{
			"<leader>Dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>Do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>DO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>Dp",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<leader>Dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<leader>Ds",
			function()
				require("dap").session()
			end,
			desc = "Session",
		},
		{
			"<leader>Dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<leader>Dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Widgets",
		},

		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<F29>", -- <s-F5>
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<F6>",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<F7>",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<F8>",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<F31>", -- <s-F7>
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
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
			command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed, must be absolute path
			name = "lldb",
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
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
