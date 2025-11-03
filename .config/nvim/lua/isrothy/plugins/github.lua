return {
  {
    "topaxi/pipeline.nvim",
    cmd = { "Pipeline" },
    build = "make",
    opts = {},
  },
  {
    "moyiz/git-dev.nvim",
    cmd = {
      "GitDevClean",
      "GitDevCleanAll",
      "GitDevCloseBuffers",
      "GitDevOpen",
      "GitDevPersist",
      "GitDevRecents",
      "GitDevToggleUI",
      "GitDevXDGHandle",
    },
    keys = {
      { "<leader>Gd", "", desc = "+Git-dev" },
      {
        "<leader>Gdo",
        function()
          local repo = vim.fn.input("Repository name / URI: ")
          if repo ~= "" then
            vim.env.GIT_DIR = nil
            vim.env.GIT_WORK_TREE = nil
            require("git-dev").open(repo)
          end
        end,
        desc = "Open a remote git repository",
      },
      {
        "<leader>Gdd",
        function() require("git-dev").close_buffers() end,
        desc = "Close buffers of current repository",
      },
      {
        "<leader>Gdc",
        function() require("git-dev").clean() end,
        desc = "Clean current repository",
      },
    },
    opts = {
      cd_type = "tab",
      verbose = false,
      ui = {
        enabled = false,
      },
      opener = function(dir, _, selected_path)
        vim.cmd("tabnew")
        vim.cmd("Neotree " .. dir)
        if selected_path then
          vim.cmd("edit " .. selected_path)
        end
      end,
    },
  },
}
