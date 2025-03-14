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
          ["<C-H>"] = false,
          ["<C-J>"] = false,
          ["<C-K>"] = false,
          ["<C-L>"] = false,
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
      { "<LEADER>Tw", "<CMD>OverseerToggle<CR>", desc = "Task list" },
      { "<LEADER>To", "<CMD>OverseerRun<CR>", desc = "Run task" },
      { "<LEADER>Tq", "<CMD>OverseerQuickAction<CR>", desc = "Action recent task" },
      { "<LEADER>Ti", "<CMD>OverseerInfo<CR>", desc = "Overseer info" },
      { "<LEADER>Tb", "<CMD>OverseerBuild<CR>", desc = "Task builder" },
      { "<LEADER>Tt", "<CMD>OverseerTaskAction<CR>", desc = "Task action" },
      { "<LEADER>Tc", "<CMD>OverseerClearCache<CR>", desc = "Clear cache" },
    },
  },
}
