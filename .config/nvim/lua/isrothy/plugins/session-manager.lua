return {
  {
    "olimorris/persisted.nvim",
    event = { "BufReadPre" },
    keys = {
      { "<LEADER>qd", "<CMD>SessionDelete<CR>", desc = "Delete session" },
      { "<LEADER>ql", "<CMD>SessionLoad<CR>", desc = "Load session" },
      { "<LEADER>qf", "<CMD>SessionLoadFromFile<CR>", desc = "Load session" },
      { "<LEADER>qr", "<CMD>SessionLoadLast<CR>", desc = "Load last session" },
      { "<LEADER>qs", "<CMD>SessionSave<CR>", desc = "Save session" },
      { "<LEADER>qp", "<CMD>SessionSelect<CR>", desc = "Pick a session" },
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
            vim.schedule(function()
              Snacks.bufdelete()
            end)
          end
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        group = vim.api.nvim_create_augroup("", { clear = true }),
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
          }):map("<LEADER>qq")
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
