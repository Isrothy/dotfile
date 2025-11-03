return {
  {
    "stevearc/overseer.nvim",
    enabled = false,
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
          ["<c-h>"] = false,
          ["<c-j>"] = false,
          ["<c-k>"] = false,
          ["<c-l>"] = false,
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
      { "<leader>!w", "<cmd>OverseerToggle<cr>", desc = "Task list" },
      { "<leader>!o", "<cmd>OverseerRun<cr>", desc = "Run task" },
      { "<leader>!q", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
      { "<leader>!i", "<cmd>OverseerInfo<cr>", desc = "Overseer info" },
      { "<leader>!b", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
      { "<leader>!t", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
      { "<leader>!c", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
    },
  },
}
