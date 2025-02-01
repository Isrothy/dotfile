return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp", -- Use this branch for the new version
  ft = "python",
  cmd = "VenvSelect",
  opts = {
    settings = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
  },
}
