local telescope = {
  enabled = false,
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-frecency.nvim", dependencies = { "kkharji/sqlite.lua" } },
    { "jvgrootveld/telescope-zoxide" },
    { "debugloop/telescope-undo.nvim" },
  },
}

telescope.keys = {
  { "<LEADER>fa", "<CMD>Telescope Autocommands<CR>", desc = "Autocommands" },
  { "<LEADER>fb", "<CMD>Telescope Buffers<CR>", desc = "Buffers" },
  {
    "<LEADER>fB",
    "<CMD>Telescope current_buffer_fuzzy_find<CR>",
    desc = "Current Buffer Fuzzy Find",
  },
  { "<LEADER>fc", "<CMD>Telescope commands history<CR>", desc = "Commands History" },
  { "<LEADER>fC", "<CMD>Telescope commands<CR>", desc = "Commands" },

  { "<LEADER>ff", "<CMD>Telescope find_files<CR>", desc = "Find Files" },

  { "<LEADER>fg", "<CMD>Telescope live_grep<CR>", desc = "Live Grep" },
  { "<LEADER>fG", "<CMD>Telescope git_files<CR>", desc = "Git Files" },

  { "<LEADER>fh", "<CMD>Telescope help_tags<CR>", desc = "Help Tags" },
  { "<LEADER>fH", "<CMD>Telescope highlights<CR>", desc = "Highlight Groups" },

  { "<LEADER>fj", "<CMD>Telescope jumplist<CR>", desc = "Jumplist" },
  { "<LEADER>fk", "<CMD>Telescope keymaps<CR>", desc = "Keymaps" },
  { "<LEADER>fl", "<CMD>Telescope loclist<CR>", desc = "Local List" },
  { "<LEADER>fm", "<CMD>Telescope marks<CR>", desc = "Marks" },
  { "<LEADER>fM", "<CMD>Telescope man_page<CR>", desc = "Man Page" },
  { "<LEADER>fn", "<CMD>Telescope noice<CR>", desc = "Noice" },
  { "<LEADER>fo", "<CMD>Telescope frecency<CR>", desc = "Oldfiles" },
  { "<LEADER>fp", "<CMD>Telescope projects<CR>", desc = "Projects" },
  { "<LEADER>fq", "<CMD>Telescope quickfix<CR>", desc = "Quickfix" },
  { "<LEADER>fR", "<CMD>Telescope resume<CR>", desc = "Resume" },
  { "<LEADER>fs", "<CMD>Telescope persisted<CR>", desc = "Sessions" },
  { "<LEADER>fu", "<CMD>Telescope undo<CR>", desc = "Undo" },
  { "<LEADER>fv", "<CMD>Telescope vim_options<CR>", desc = "Vim Options" },

  { "<LEADER>fy", "<CMD>Telescope yank_history<CR>", desc = "Yank History" },
  { "<LEADER>fz", "<CMD>Telescope zoxide list<CR>", desc = "Zoxide" },

  { "<LEADER>f\"", "<CMD>Telescope registers<CR>", desc = "Registers" },

  {
    "<LEADER>xt",
    "<CMD>Telescope diagnostics bufnr=0<CR>",
    desc = "Buffer Diagnostics (Telescopt)",
  },
  { "<LEADER>xT", "<CMD>Telescope diagnostics<CR>", desc = "Diagnostics (Telescopt)" },
}

telescope.config = function()
  local previewers = require("telescope.previewers")
  local Job = require("plenary.job")

  local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    ---@diagnostic disable-next-line: missing-fields
    Job:new({
      command = "file",
      args = { "--mime-type", "-b", filepath },
      on_exit = function(j)
        local mime_type = vim.split(j:result()[1], "/")[1]
        if mime_type == "text" then
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        else
          -- maybe we want to write something to the buffer here
          vim.schedule(function()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
          end)
        end
      end,
    }):sync()
  end

  require("telescope").setup({
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      },
    },
    defaults = {
      buffer_previewer_maker = new_maker,
      dynamic_preview_title = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
        -- require("telescope.themes").get_cursor({}),
      },
      frecency = {
        show_scores = false,
        show_unindexed = true,
        db_safe_mode = false,
        ignore_patterns = { "*.git/*", "*/tmp/*" },
        disable_devicons = false,
      },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      aerial = {
        -- Display symbols as <root>.<parent>.<symbol>
        show_nesting = true,
      },
      persisted = {
        layout_config = { width = 0.55, height = 0.55 },
      },
      undo = {
        use_delta = true,
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = {
          -- preview_height = 0.8,
        },
        mappings = { -- this whole table is the default
          i = {
            -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
            -- you want to use the following actions. This means installing as a dependency of
            -- telescope in it's `requirements` and loading this extension from there instead of
            -- having the separate plugin definition as outlined above. See issue #6.
            ["<CR>"] = require("telescope-undo.actions").yank_additions,
            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
            ["<C-cr>"] = require("telescope-undo.actions").restore,
          },
        },
      },
      zoxide = {
        prompt_title = "[ Walking on the shoulders of TJ ]",
        list_command = "zoxide query -ls",
        mappings = {
          default = {
            action = function(selection)
              vim.cmd("cd " .. selection.path)
            end,
            after_action = function(selection)
              print("Directory changed to " .. selection.path)
            end,
          },
        },
      },
      lazy = {
        -- Optional theme (the extension doesn't set a default theme)
        theme = "ivy",
        -- Whether or not to show the icon in the first column
        show_icon = true,
        -- Mappings for the actions
        mappings = {
          open_in_browser = "<C-o>",
          open_in_find_files = "<C-f>",
          open_in_live_grep = "<C-g>",
          open_plugins_picker = "<C-b>", -- Works only after having called first another action
          open_lazy_root_find_files = "<C-r>f",
          open_lazy_root_live_grep = "<C-r>g",
        },
        -- Other telescope configuration options
      },
      advanced_git_search = {
        -- fugitive or diffview
        diff_plugin = "diffview",
        -- customize git in previewer
        -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
        git_flags = {},
        -- customize git diff in previewer
        -- e.g. flags such as { "--raw" }
        git_diff_flags = {},
        -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
        show_builtin_git_pickers = false,
        entry_default_author_or_date = "author", -- one of "author" or "date"
        keymaps = {
          -- following keymaps can be overridden
          toggle_date_author = "<C-W>",
          open_commit_in_browser = "<C-o>",
          copy_commit_hash = "<C-y>",
        },
        -- Telescope layout setup
        telescope_theme = {
          function_name_1 = {
            -- Theme options
          },
          function_name_2 = "dropdown",
          -- e.g. realistic example
          show_custom_functions = {
            layout_config = { width = 0.4, height = 0.4 },
          },
        },
      },
    },
  })

  require("telescope").load_extension("fzf")
  require("telescope").load_extension("zoxide")
  require("telescope").load_extension("frecency")
  require("telescope").load_extension("noice")
  require("telescope").load_extension("undo")
  require("telescope").load_extension("smart_open")
  require("telescope").load_extension("projects")
  require("telescope").load_extension("advanced_git_search")
end

return {
  -- telescope,
  -- {
  --   "luc-tielen/telescope_hoogle",
  --   ft = "haskell",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     require("telescope").load_extension("hoogle")
  --   end,
  -- },
  -- {
  --   "danielfalk/smart-open.nvim",
  --   branch = "0.1.x",
  --   dependencies = { "kkharji/sqlite.lua" },
  -- },
  -- {
  --   "wintermute-cell/gitignore.nvim",
  --   cmd = { "GitIgnore" },
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  -- {
  --   "ahmedkhalf/project.nvim",
  --   event = "VeryLazy",
  --   cmd = { "ProjectRoot", "AddProject" },
  --   opts = {
  --     manual_mode = true,
  --   },
  --   config = function(_, opts)
  --     require("project_nvim").setup(opts)
  --   end,
  -- },
  -- {
  --   "LukasPietzschmann/telescope-tabs",
  --   event = "VeryLazy",
  --   config = function()
  --     require("telescope").load_extension("telescope-tabs")
  --     require("telescope-tabs").setup({
  --       show_preview = true,
  --     })
  --   end,
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  -- },
  -- {
  --   "aaronhallaert/advanced-git-search.nvim",
  --   cmd = { "AdvancedGitSearch" },
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "sindrets/diffview.nvim",
  --   },
  -- },
}
