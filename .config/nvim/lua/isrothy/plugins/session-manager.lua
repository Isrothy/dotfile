return {
  {
    "olimorris/persisted.nvim",
    event = { "BufReadPre" },
    enabled = false,
    keys = {
      { "<leader>qd", "<cmd>SessionDelete<cr>", desc = "Delete session" },
      { "<leader>ql", "<cmd>SessionLoad<cr>", desc = "Load session" },
      { "<leader>qf", "<cmd>SessionLoadFromFile<cr>", desc = "Load session" },
      { "<leader>qr", "<cmd>SessionLoadLast<cr>", desc = "Load last session" },
      { "<leader>qs", "<cmd>SessionSave<cr>", desc = "Save session" },
      { "<leader>qp", "<cmd>SessionSelect<cr>", desc = "Pick a session" },
    },
    cmd = {
      "SessionDelete",
      "SessionLoad",
      "SessionLoadFromFile",
      "SessionLoadLast",
      "SessionSave",
      "SessionSelect",
      "SessionStart",
      "SessionStop",
      "SessionToggle",
    },
    priority = 1000,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedLoadPost",
        group = vim.api.nvim_create_augroup("delete buffer if it is snacks_dashboard", { clear = true }),
        callback = function()
          if vim.bo.filetype == "snacks_dashboard" then
            vim.schedule(function() Snacks.bufdelete() end)
          end
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        group = vim.api.nvim_create_augroup("toggle session", { clear = true }),
        callback = function()
          Snacks.toggle({
            name = "session",
            get = function() return vim.g.persisting end,
            set = function(state)
              if state then
                vim.cmd("SessionStart")
              else
                vim.cmd("SessionStop")
              end
            end,
          }):map("<leader>qq")
        end,
      })
    end,
    opts = {
      should_save = function()
        local ignore = { "alpha", "snacks_dashboard" }
        return not vim.tbl_contains(ignore, vim.bo.filetype)
      end,
      autostart = true,
      autosave = true,
      follow_cwd = true,
      use_git_branch = true,
      silent = true,
      on_autoload_no_session = function() vim.notify("No existing session to load.", vim.log.levels.ERROR) end,
    },
  },
}
