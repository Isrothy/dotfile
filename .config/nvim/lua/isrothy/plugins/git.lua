return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "VeryLazy" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = false,
      },
      sign_priority = 7,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local wk = require("which-key")
        wk.add({
          buffer = buffer,
          {
            "]h",
            function()
              if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
              else
                gs.nav_hunk("next")
              end
            end,
            desc = "Next Hunk",
          },
          {
            "[h",
            function()
              if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
              else
                gs.nav_hunk("next")
              end
            end,
            desc = "Previous Hunk",
          },
          { "]H", function() gs.nav_hunk("last") end, desc = "Last hunk" },
          { "[H", function() gs.nav_hunk("last") end, desc = "First hunk" },
          {
            mode = { "n", "x" },
            { "<leader>hs", ":Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
            { "<leader>hr", ":Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
          },

          { "<leader>hS", gs.stage_buffer, desc = "Stage Buffer" },
          { "<leader>hu", gs.undo_stage_hunk, desc = "Undo Stage Hunk" },
          { "<leader>hR", gs.reset_buffer, desc = "Reset Buffer" },
          { "<leader>hp", gs.preview_hunk_inline, desc = "Preview Hunk Inline" },
          { "<leader>hb", function() gs.blame_line({ full = true }) end, desc = "Blame Line" },
          { "<leader>hB", function() gs.blame() end, desc = "Blame Buffer" },
          { "<leader>hd", gs.diffthis, desc = "Diff This" },
          { "<leader>hD", function() gs.diffthis("~") end, desc = "Diff This ~" },
          { "ih", ":<c-U>Gitsigns select_hunk<cr>", desc = "GitSigns Select Hunk", mode = { "o", "x" } },
        })
      end,
      trouble = false,
    },
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
      { "<leader>gr", "", desc = "+Git-dev" },
      {
        "<leader>gro",
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
        "<leader>grd",
        function() require("git-dev").close_buffers() end,
        desc = "Close buffers of current repository",
      },
      {
        "<leader>grc",
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
