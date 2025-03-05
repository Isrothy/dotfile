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
      preview_config = {
        border = "rounded",
      },
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
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<LEADER>gd", "", desc = "+Diff" },
      { "<LEADER>gdd", "<CMD>DiffviewOpen<CR>", desc = "Open Diff View" },
      { "<LEADER>gdc", "<CMD>DiffviewClose<CR>", desc = "Close Diff View" },
      { "<LEADER>gdr", "<CMD>DiffviewRefresh<CR>", desc = "Refresh Diff View" },
      { "<LEADER>gdf", "<CMD>DiffviewFileHistory<CR>", desc = "File History" },
    },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("setup_diffview", { clear = true }),
        callback = function()
          if vim.opt.diff:get() then
            require("diffview").open({})
          end
        end,
      })
    end,
    opts = function()
      local actions = require("diffview.actions")
      return {
        view = {
          enhanced_diff_hl = true,
          merge_tool = {
            layout = "diff3_mixed",
          },
        },
        keymaps = {
          disable_defaults = true,
          view = {
            ["<leader>e"] = false,
            ["<leader>b"] = false,
            { "n", "<LOCALLEADER>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
            { "n", "<LOCALLEADER>b", actions.toggle_files, { desc = "Toggle the file panel." } },

            ["[x"] = false,
            ["]x"] = false,
            { "n", "[k", actions.prev_conflict, { desc = "In the merge-tool: jump to the previous conflict" } },
            { "n", "]k", actions.next_conflict, { desc = "In the merge-tool: jump to the next conflict" } },

            ["<leader>co"] = false,
            ["<leader>ct"] = false,
            ["<leader>cb"] = false,
            ["<leader>ca"] = false,
            ["<leader>dx"] = false,
            ["<leader>cO"] = false,
            ["<leader>cT"] = false,
            ["<leader>cB"] = false,
            ["<leader>cA"] = false,
            ["<leader>dX"] = false,
            {
              "n",
              "<LOCALLEADER>co",
              actions.conflict_choose("ours"),
              { desc = "Choose the OURS version of a conflict" },
            },
            {
              "n",
              "<LOCALLEADER>ct",
              actions.conflict_choose("theirs"),
              { desc = "Choose the THEIRS version of a conflict" },
            },
            {
              "n",
              "<LOCALLEADER>cb",
              actions.conflict_choose("base"),
              { desc = "Choose the BASE version of a conflict" },
            },
            {
              "n",
              "<LOCALLEADER>ca",
              actions.conflict_choose("all"),
              { desc = "Choose all the versions of a conflict" },
            },
            {
              "n",
              "<LOCALLEADER>cn",
              actions.conflict_choose("none"),
              { desc = "Delete the conflict region" },
            },
            {
              "n",
              "<LOCALLEADER>cO",
              actions.conflict_choose_all("ours"),
              { desc = "Choose the OURS version of a conflict for the whole file" },
            },
            {
              "n",
              "<LOCALLEADER>cT",
              actions.conflict_choose_all("theirs"),
              { desc = "Choose the THEIRS version of a conflict for the whole file" },
            },
            {
              "n",
              "<LOCALLEADER>cB",
              actions.conflict_choose_all("base"),
              { desc = "Choose the BASE version of a conflict for the whole file" },
            },
            {
              "n",
              "<LOCALLEADER>cA",
              actions.conflict_choose_all("all"),
              { desc = "Choose all the versions of a conflict for the whole file" },
            },
            {
              "n",
              "<LOCALLEADER>cN",
              actions.conflict_choose_all("none"),
              { desc = "Delete the conflict region for the whole file" },
            },
          },

          file_panel = {
            ["<leader>e"] = false,
            ["<leader>b"] = false,
            { "n", "<LOCALLEADER>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
            { "n", "<LOCALLEADER>b", actions.toggle_files, { desc = "Toggle the file panel" } },
            ["[x"] = false,
            ["]x"] = false,
            { "n", "[k", actions.prev_conflict, { desc = "Go to the previous conflict" } },
            { "n", "]k", actions.next_conflict, { desc = "Go to the next conflict" } },
            ["<leader>co"] = false,
            ["<leader>ct"] = false,
            ["<leader>cb"] = false,
            ["<leader>ca"] = false,
            ["<leader>dx"] = false,
            ["<leader>cO"] = false,
            ["<leader>cT"] = false,
            ["<leader>cB"] = false,
            ["<leader>cA"] = false,
            ["<leader>dX"] = false,
            {
              "n",
              "<LOCALLEADER>cO",
              actions.conflict_choose_all("ours"),
              { desc = "Choose the OURS version of a conflict for the whole file" },
            },
            {
              "n",
              "<LOCALLEADER>cT",
              actions.conflict_choose_all("theirs"),
              { desc = "Choose the THEIRS version of a conflict for the whole file" },
            },
            {
              "n",
              "<LOCALLEADER>cB",
              actions.conflict_choose_all("base"),
              { desc = "Choose the BASE version of a conflict for the whole file" },
            },
            {
              "n",
              "<LOCALLEADER>cA",
              actions.conflict_choose_all("all"),
              { desc = "Choose all the versions of a conflict for the whole file" },
            },
            {
              "n",
              "<LOCALLEADER>cN",
              actions.conflict_choose_all("none"),
              { desc = "Delete the conflict region for the whole file" },
            },
          },
          file_history_panel = {
            ["<leader>e"] = false,
            ["<leader>b"] = false,
            { "n", "<LOCALLEADER>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
            { "n", "<LOCALLEADER>b", actions.toggle_files, { desc = "Toggle the file panel" } },
          },
        },
      }
    end,
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
    "ejrichards/baredot.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      git_dir = "~/.cfg",
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
