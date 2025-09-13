-- local header = ""
--   .. "██████   █████                   █████   █████  ███                  \n"
--   .. "░░██████ ░░███                   ░░███   ░░███  ░░░                  \n"
--   .. " ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████  \n"
--   .. " ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███ \n"
--   .. " ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███ \n"
--   .. " ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███ \n"
--   .. " █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████\n"
--   .. "░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ \n"
local header = ""
  .. "                                                                     \n"
  .. "                                                                   \n"
  .. "      ████ ██████           █████      ██                    \n"
  .. "     ███████████             █████                            \n"
  .. "     █████████ ███████████████████ ███   ███████████  \n"
  .. "    █████████  ███    █████████████ █████ ██████████████  \n"
  .. "   █████████ ██████████ █████████ █████ █████ ████ █████  \n"
  .. " ███████████ ███    ███ █████████ █████ █████ ████ █████ \n"
  .. "██████  █████████████████████ ████ █████ █████ ████ ██████\n"
  .. "                                                                     \n"

return {
  "folke/snacks.nvim",
  priority = 1001,
  lazy = false,
  ---@type snacks.Config
  opts = {
    input = { enabled = false },
    image = { enabled = false },
    scroll = { enabled = false },
    picker = {
      prompt = " ",
      layout = {
        cycle = true,
        preset = function() return vim.o.columns >= 120 and "default" or "vertical" end,
      },
    },
    statuscolumn = {
      enabled = true,
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
    styles = {
      ---@diagnostic disable-next-line: missing-fields
      notification_history = {
        wo = {
          winhighlight = "Normal:SnacksNotifierHistory",
          wrap = true,
          breakindent = true,
        },
      },
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
            desc = "Inner scope",
          },
          ai = {
            min_size = 2,
            treesitter = { blocks = { enabled = true } },
            desc = "Full scope",
          },
        },
        ---@type table<string, snacks.scope.Jump|{desc?:string}>
        jump = {
          ["[i"] = {
            min_size = 2,
            bottom = false,
            edge = true,
            treesitter = { blocks = { enabled = true } },
            desc = "Top edge of scope",
          },
          ["]i"] = {
            min_size = 2,
            bottom = true,
            edge = true,
            treesitter = { blocks = { enabled = true } },
            desc = "Bottom edge of scope",
          },
        },
      },
    },
    indent = {
      enabled = true,
      indent = {
        char = "▎",
        blank = " ",
        only_scope = false, -- Only show indent guides of the scope
        only_current = false, -- Only show indent guides in the current window
        hl = "SnacksIndent",
      },
      animate = { enabled = false },
      scope = {
        char = "▎",
        underline = true, -- Underline the start of the scope
        only_current = false, -- Only show scope in the current window
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
      width = 70,
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        {
          pane = 2,
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          limit = 5,
          indent = 2,
          padding = 1,
        },
        {
          pane = 2,
          icon = "󱉮 ",
          title = vim.fn.fnamemodify(".", ":~"),
          section = "recent_files",
          cwd = true,
          indent = 2,
          limit = 5,
          padding = 1,
        },
        {
          pane = 2,
          icon = "󰸖 ",
          title = "Projects",
          section = "projects",
          indent = 2,
          limit = 5,
          padding = 1,
        },
        -- {
        --   pane = 2,
        --   icon = " ",
        --   title = "Git Status",
        --   section = "terminal",
        --   enabled = function() return Snacks.git.get_root() ~= nil end,
        --   cmd = "git status --short --branch --renames",
        --   height = 5,
        --   padding = 1,
        --   ttl = 0,
        --   indent = 3,
        -- },
      },

      preset = {
        keys = {
          {
            icon = "󰱽 ",
            key = "f",
            desc = "Find file",
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            icon = " ",
            key = "n",
            desc = "New file",
            action = ":ene | startinsert",
          },
          {
            icon = "󰺯 ",
            key = "/",
            desc = "Grep",
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = "󱋢 ",
            key = "r",
            desc = "Recent files",
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
      animate = { enabled = false },
    },
    notifier = {
      enabled = true,
      timeout = 5000,
    },
    quickfile = { enabled = true },
    words = { enabled = true },
    profiler = { pick = { picker = "auto" } },
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
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config file" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Search files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent file" },
    { "<leader>fs", function() Snacks.picker.smart() end, desc = "Smart search" },
    { "<leader>fz", function() Snacks.picker.zoxide() end, desc = "Zoxide" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },

    { "<leader>ia", function() Snacks.picker.autocmds() end, desc = "Autocommands" },
    { "<leader>ic", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>ih", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>ii", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>ij", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>ik", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>il", function() Snacks.picker.loclist() end, desc = "Location list" },
    { "<leader>iq", function() Snacks.picker.qflist() end, desc = "Quickfix list" },
    { "<leader>i'", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>i/", function() Snacks.picker.search_history() end, desc = "Search history" },
    { "<leader>i:", function() Snacks.picker.command_history() end, desc = "Command history" },
    { '<leader>i"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>i<F1>", function() Snacks.picker.help() end, desc = "Help pages" },

    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file" },
    { "<leader>jd", function() Snacks.picker.lsp_definitions({ auto_confirm = false }) end, desc = "Definition" },
    { "<leader>jD", function() Snacks.picker.lsp_declarations({ auto_confirm = false }) end, desc = "Declaration" },
    {
      "<leader>ji",
      function() Snacks.picker.lsp_implementations({ auto_confirm = false }) end,
      desc = "Implementation",
    },
    { "<leader>jr", function() Snacks.picker.lsp_references({ auto_confirm = false }) end, desc = "References" },
    { "<leader>js", function() Snacks.picker.lsp_symbols() end, desc = "Symbols" },
    {
      "<leader>jt",
      function() Snacks.picker.lsp_type_definitions({ auto_confirm = false }) end,
      desc = "Type definition",
    },
    { "<leader>jw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },

    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete current buffer" },
    { "<leader>b/", function() Snacks.picker.buffers() end, desc = "Picker" },

    { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git log" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
    { "<leader>gf", function() Snacks.picker.git_files() end, desc = "Search git files" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git blame line" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse" },

    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dissmiss" },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "History" },
    { "<leader>n/", function() Snacks.picker.notifications() end, desc = "Search" },

    { "<leader>u/", function() Snacks.picker.undo() end, desc = "Search" },

    { "<leader>x/", function() Snacks.picker.diagnostics() end, desc = "Picker" },
    { "<leader>x?", function() Snacks.picker.diagnostics_buffer() end, desc = "Search buffer picker" },

    { "<leader>zz", function() Snacks.zen() end, desc = "Toggle zen mode" },
    { "<leader>zo", function() Snacks.zen.zoom() end, desc = "Toggle zoom" },

    { "<leader>//", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>/l", function() Snacks.picker.lines() end, desc = "Buffer lines" },
    { "<leader>/b", function() Snacks.picker.grep_buffers() end, desc = "Grep open buffers" },
    { "<leader>/w", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

    { "<leader>..", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>.s", function() Snacks.scratch.select() end, desc = "Select scratch buffer" },

    { "<leader>;", function() Snacks.picker.resume() end, desc = "Resume" },

    { "]]", function() Snacks.words.jump(vim.v.count1, true) end, desc = "Next reference", mode = { "n" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev reference", mode = { "n" } },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end ---@diagnostic disable-line
        _G.bt = function() Snacks.debug.backtrace() end ---@diagnostic disable-line
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>os")
        Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>ow")
        Snacks.toggle.option("relativenumber", { name = "relative number" }):map("<leader>or")
        Snacks.toggle.line_number({ name = "line number" }):map("<leader>ol")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>oc")
        Snacks.toggle
          .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "tabline" })
          :map("<leader>ot")
        Snacks.toggle.treesitter({ name = "treesitter" }):map("<leader>oT")
        Snacks.toggle.diagnostics({ name = "diagnostics" }):map("<leader>xu")
        Snacks.toggle.inlay_hints({ name = "inlay hints" }):map("<leader>li")
        Snacks.toggle.indent():map("<leader><space>i")
        Snacks.toggle.dim():map("<leader>zd")
        Snacks.toggle({
          name = "LSP",
          get = function() return #vim.lsp.get_clients() ~= 0 end,
          set = function(state)
            if state then
              vim.cmd("LspStart")
            else
              vim.cmd("LspStop")
            end
          end,
        }):map("<leader>L")
      end,
    })
  end,
}
