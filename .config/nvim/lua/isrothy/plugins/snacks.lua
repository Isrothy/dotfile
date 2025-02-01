local header = ""
  .. "██████   █████                   █████   █████  ███                  \n"
  .. "░░██████ ░░███                   ░░███   ░░███  ░░░                  \n"
  .. " ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████  \n"
  .. " ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███ \n"
  .. " ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███ \n"
  .. " ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███ \n"
  .. " █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████\n"
  .. "░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ \n"

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  enabled = true,
  ---@type snacks.Config
  opts = {
    picker = {
      prompt = " ",
      layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function() return vim.o.columns >= 120 and "default" or "vertical" end,
      },
    },
    input = {
      enabled = true,
    },
    scroll = {
      enabled = false,
    },
    statuscolumn = {
      left = { "mark", "sign" },
      right = { "fold", "git" },
      folds = {
        open = true, -- show open fold icons
        git_hl = true, -- use Git Signs hl for fold icons
      },
      git = {
        patterns = { "GitSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    scope = {
      enabled = true,
      cursor = false,
      treesitter = {
        enabled = true,
        blocks = {
          "chunk",
          "table_constructor",
          "function_declaration",
          "function_definition",
          "method_declaration",
          "method_definition",
          "class_declaration",
          "class_definition",
          "do_statement",
          "while_statement",
          "repeat_statement",
          "switch_statement",
          "case_statement",
          "if_statement",
          "for_statement",
          "arguments",
        },
      },
      keys = {
        ---@type table<string, snacks.scope.TextObject|{desc?:string}>
        textobject = {
          ii = {
            min_size = 2,
            edge = false,
            treesitter = { blocks = { enabled = true } },
            desc = "Inner Scope",
          },
          ai = {
            min_size = 2,
            treesitter = { blocks = { enabled = true } },
            desc = "Full Scope",
          },
        },
        ---@type table<string, snacks.scope.Jump|{desc?:string}>
        jump = {
          ["[i"] = {
            min_size = 2,
            bottom = false,
            edge = true,
            treesitter = { blocks = { enabled = true } },
            desc = "Jump to Top Edge of Scope",
          },
          ["]i"] = {
            min_size = 2,
            bottom = true,
            edge = true,
            treesitter = { blocks = { enabled = true } },
            desc = "Jump to Bottom Edge of Scope",
          },
        },
      },
    },
    indent = {
      enabled = true,
      indent = {
        char = "▎",
        blank = " ",
        only_scope = false, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = "SnacksIndent",
      },
      animate = { enabled = false },
      scope = {
        char = "▎",
        underline = true, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = "SnacksIndentScope",
      },
      blank = {
        char = "▎",
        hl = "SnacksIndentBlank", ---@type string|string[] hl group for blank spaces
      },
      treesitter = { enabled = true },
    },
    bigfile = {
      enabled = true,
      ---@param ctx {buf: number, ft:string}
      setup = function(ctx)
        Snacks.util.wo(0, {
          foldmethod = "manual",
          statuscolumn = "",
          conceallevel = 0,
        })
        vim.b.minianimate_disable = true
        vim.opt_local.swapfile = false
        vim.opt_local.foldmethod = "manual"
        vim.opt_local.undoreload = 0
        vim.opt_local.list = false

        vim.cmd("syntax clear")
        vim.opt_local.syntax = "OFF"
      end,
    },
    dashboard = {
      enabled = true,
      width = 60,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        {
          pane = 2,
          align = "right",
          section = "terminal",
          cmd = "macchina -c ~/.config/nvim/minimalist.toml",
          padding = 1,
          ttl = 60 * 60 * 24,
        },
        {
          pane = 2,
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          limit = 5,
          indent = 2,
          padding = 1,
        },
        {
          pane = 2,
          icon = " ",
          title = vim.fn.fnamemodify(".", ":~"),
          section = "recent_files",
          cwd = true,
          indent = 2,
          limit = 5,
          padding = 1,
        },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function() return Snacks.git.get_root() ~= nil end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 0,
          indent = 3,
        },
      },

      preset = {
        keys = {
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = ":lua Snacks.dashboard.pick('files')",
          },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          {
            icon = " ",
            key = "/",
            desc = "Grep",
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          -- {
          --   icon = " ",
          --   key = "p",
          --   desc = "Projects",
          --   action = ":Telescope projects",
          -- },
          {
            icon = " ",
            key = "s",
            desc = "Restore Session",
            section = "session",
          },
          {
            icon = "󰒲 ",
            key = "l",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = header,
      },
    },
    dim = {
      enabled = true,
      animate = {
        enabled = false,
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    words = { enabled = true },
    profiler = {
      pick = {
        picker = "auto",
      },
    },
    zen = {
      enabled = true,
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        diagnostics = false,
        inlay_hints = false,
      },
    },
  },
  keys = {
    { "<LEADER>fa", function() Snacks.picker.autocmds() end, desc = "Autocommands" },
    { "<LEADER>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<LEADER>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config File" },
    { "<LEADER>ff", function() Snacks.picker.files() end, desc = "Files" },
    { "<LEADER>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<LEADER>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<LEADER>fH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<LEADER>fi", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<LEADER>fj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<LEADER>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<LEADER>fl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<LEADER>fm", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<LEADER>fn", function() Snacks.picker.notifications() end, desc = "Man Pages" },
    { "<LEADER>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<LEADER>fq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<LEADER>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<LEADER>fs", function() Snacks.picker.smart() end, desc = "Smart" },
    { "<LEADER>fS", function() Snacks.picker.spelling() end, desc = "Spelling" },
    { "<LEADER>fu", function() Snacks.picker.undo() end, desc = "Undo" },
    { "<LEADER>fx", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<LEADER>fX", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics" },
    { "<LEADER>fz", function() Snacks.picker.zoxide() end, desc = "Zoxide" },
    { '<LEADER>f"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<LEADER>f:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<LEADER>f'", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<LEADER>f.", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<LEADER>f/", function() Snacks.picker.search_history() end, desc = "Search" },

    { "<LEADER>//", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<LEADER>/b", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<LEADER>/B", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    {
      "<LEADER>/w",
      function() Snacks.picker.grep_word() end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },

    {
      "<LEADER><LEADER>d",
      function() Snacks.picker.lsp_definitions({ auto_confirm = false }) end,
      desc = "Find Definition",
    },
    {
      "<LEADER><LEADER>D",
      function() Snacks.picker.lsp_declarations({ auto_confirm = false }) end,
      desc = "Find Declaration",
    },
    {
      "<LEADER><LEADER>t",
      function() Snacks.picker.lsp_type_definitions({ auto_confirm = false }) end,
      desc = "Find Type Definition",
    },
    {
      "<LEADER><LEADER>i",
      function() Snacks.picker.lsp_implementations({ auto_confirm = false }) end,
      desc = "Find Implementation",
    },
    {
      "<LEADER><LEADER>r",
      function() Snacks.picker.lsp_references({ auto_confirm = false }) end,
      desc = "Find References",
    },
    {
      "<LEADER><LEADER>s",
      function() Snacks.picker.lsp_workspace_symbols() end,
      desc = "Find Workspace Symbols",
    },

    -- { "<LEADER>ee", function() Snacks.explorer({ cwd = LazyVim.root() }) end, desc = "Explorer Snacks (root dir)" },
    -- { "<LEADER>eE", function() Snacks.explorer() end, desc = "Explorer Snacks (cwd)" },

    { "<LEADER>qs", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Bufer" },
    { "<LEADER>..", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<LEADER>.s", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

    { "<LEADER>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

    { "<LEADER>bd", function() Snacks.bufdelete() end, desc = "Delete Current Buffer" },

    { "<LEADER>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<LEADER>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<LEADER>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<LEADER>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<LEADER>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<LEADER>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<LEADER>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },

    { "<LEADER><LEADER>N", function() Snacks.rename.rename_file() end, desc = "Rename File" },

    { "<LEADER>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<LEADER>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },

    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<LEADER>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<LEADER>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<LEADER>uL")
        Snacks.toggle.diagnostics():map("<LEADER>ud")
        Snacks.toggle.line_number():map("<LEADER>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<LEADER>uc")
        Snacks.toggle
          .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
          :map("<LEADER>uA")
        Snacks.toggle.treesitter():map("<LEADER>uT")
        Snacks.toggle.inlay_hints():map("<LEADER>uh")
        Snacks.toggle.profiler():map("<LEADER>qp")
        Snacks.toggle.profiler_highlights():map("<LEADER>qh")
        Snacks.toggle.indent():map("<LEADER>ug")
        Snacks.toggle.dim():map("<LEADER>uD")
      end,
    })
  end,
}
