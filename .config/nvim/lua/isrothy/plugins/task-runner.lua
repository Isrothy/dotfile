return {
  {
    "CRAG666/code_runner.nvim",
    cmd = "RunCode",
    enabled = true,
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      mode = "toggleterm",
      startinsert = true,
      filetype = {
        c = "cd $dir && clang $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
        cpp = "cd $dir && clang++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
        dart = "dart",
        go = "go run",
        haskell = "runhaskell",
        lua = "luajit",
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        javascript = "node",
        ["objective-c"] = "cd $dir && gcc -framework Cocoa $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
        python = "python3 -u",
        r = "Rscript",
        rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
        swift = "swift",
        typescript = "ts-node",

        zsh = "$dir/$fileName",
        bash = "$dir/$fileName",
        shell = "$dir/$fileName",
      },
    },
  },
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    opts = {
      dap = false,
      strategy = "toggleterm",
      task_list = {
        bindings = {
          ["<C-h>"] = false,
          ["<C-j>"] = false,
          ["<C-k>"] = false,
          ["<C-l>"] = false,
        },
      },
      form = {
        win_opts = {
          winblend = 0,
        },
      },
      confirm = {
        win_opts = {
          winblend = 0,
        },
      },
      task_win = {
        win_opts = {
          winblend = 0,
        },
      },
    },
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Task list" },
      { "<leader>oo", "<cmd>OverseerRun<cr>", desc = "Run task" },
      { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
      { "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
      { "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
    },
  },
}
