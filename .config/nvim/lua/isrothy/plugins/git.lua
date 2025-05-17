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
            { "<LEADER>hs", ":Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
            { "<LEADER>hr", ":Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
          },

          { "<LEADER>hS", gs.stage_buffer, desc = "Stage Buffer" },
          { "<LEADER>hu", gs.undo_stage_hunk, desc = "Undo Stage Hunk" },
          { "<LEADER>hR", gs.reset_buffer, desc = "Reset Buffer" },
          { "<LEADER>hp", gs.preview_hunk_inline, desc = "Preview Hunk Inline" },
          { "<LEADER>hb", function() gs.blame_line({ full = true }) end, desc = "Blame Line" },
          { "<LEADER>hB", function() gs.blame() end, desc = "Blame Buffer" },
          { "<LEADER>hd", gs.diffthis, desc = "Diff This" },
          { "<LEADER>hD", function() gs.diffthis("~") end, desc = "Diff This ~" },
          { "ih", ":<C-U>Gitsigns select_hunk<CR>", desc = "GitSigns Select Hunk", mode = { "o", "x" } },
        })
      end,
      trouble = true,
    },
  },
  {
    "moyiz/git-dev.nvim",
    cmd = { "GitDevOpen" },
    keys = {
      {
        "<LEADER>go",
        function()
          local repo = vim.fn.input("Repository name / URI: ")
          if repo ~= "" then
            require("git-dev").open(repo)
          end
        end,
        desc = "Open a remote git repository",
      },
    },
    opts = {
      cd_type = "tab",
    },
  },
  {
    "isakbm/gitgraph.nvim",
    opts = {
      symbols = {
        merge_commit = "",
        commit = "",
        merge_commit_end = "",
        commit_end = "",

        -- Advanced symbols
        GVER = "",
        GHOR = "",
        GCLD = "",
        GCRD = "╭",
        GCLU = "",
        GCRU = "",
        GLRU = "",
        GLRD = "",
        GLUD = "",
        GRUD = "",
        GFORKU = "",
        GFORKD = "",
        GRUDCD = "",
        GRUDCU = "",
        GLUDCD = "",
        GLUDCU = "",
        GLRDCL = "",
        GLRDCR = "",
        GLRUCL = "",
        GLRUCR = "",
      },
      format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
      hooks = {
        on_select_commit = function(commit) print("selected commit:", commit.hash) end,
        on_select_range_commit = function(from, to) print("selected range:", from.hash, to.hash) end,
      },
    },
    keys = {
      {
        "<LEADER>gl",
        function() require("gitgraph").draw({}, { all = true, max_count = 5000 }) end,
        desc = "GitGraph - draw",
      },
    },
  },
}
