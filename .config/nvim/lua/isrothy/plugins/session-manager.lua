return {
  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    priority = 100,
    opts = {
      should_save = function()
        if vim.bo.filetype == "alpha" then
          return false
        end
        if vim.bo.filetype == "snacks_dashboard" then
          return false
        end
        if vim.bo.filetype == "neominimap" then
          return false
        end
        return true
      end,
      autostart = true,
      autosave = true,
      follow_cwd = true,
      use_git_branch = true,
      silent = true,
      on_autoload_no_session = function()
        vim.notify("No existing session to load.", vim.log.levels.ERROR)
      end,
    },
    config = function(_, opts)
      local persisted = require("persisted")
      persisted.branch = function()
        local branch = vim.fn.systemlist("git branch --show-current")[1]
        return vim.v.shell_error == 0 and branch or nil
      end
      persisted.setup(opts)
    end,
  },
}
