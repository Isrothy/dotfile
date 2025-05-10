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

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, noremap = true })
        end

        local wk = require("which-key")
        wk.add({ { "<LEADER>gh", group = "GitSigns" } })

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "x" }, "<LEADER>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "x" }, "<LEADER>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<LEADER>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<LEADER>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<LEADER>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<LEADER>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<LEADER>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<LEADER>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<LEADER>ghd", gs.diffthis, "Diff This")
        map("n", "<LEADER>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
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
