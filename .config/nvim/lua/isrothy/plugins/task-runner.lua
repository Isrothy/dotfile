return {
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
      { "<LEADER>!w", "<CMD>OverseerToggle<CR>", desc = "Task list" },
      { "<LEADER>!o", "<CMD>OverseerRun<CR>", desc = "Run task" },
      { "<LEADER>!q", "<CMD>OverseerQuickAction<CR>", desc = "Action recent task" },
      { "<LEADER>!i", "<CMD>OverseerInfo<CR>", desc = "Overseer info" },
      { "<LEADER>!b", "<CMD>OverseerBuild<CR>", desc = "Task builder" },
      { "<LEADER>!t", "<CMD>OverseerTaskAction<CR>", desc = "Task action" },
      { "<LEADER>!c", "<CMD>OverseerClearCache<CR>", desc = "Clear cache" },
    },
  },
}
