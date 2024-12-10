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
    bigfile = {
      enabled = true,
      ---@param ctx {buf: number, ft:string}
      setup = function(ctx)
        Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
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
      width = 52,
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
        -- {
        --     pane = 2,
        --     icon = " ",
        --     title = "Projects",
        --     section = "projects",
        --     indent = 2,
        --     limit = 5,
        --     padding = 1,
        -- },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
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
            key = "g",
            desc = "Find Text",
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
          {
            icon = " ",
            key = "p",
            desc = "Projects",
            action = ":Telescope projects",
          },
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
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },
    profiler = {
      pick = {
        picker = "auto",
      },
    },
  },
  keys = {
    {
      "<LEADER>qs",
      function()
        Snacks.profiler.scratch()
      end,
      desc = "Profiler Scratch Bufer",
    },
    {
      "<LEADER>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    -- {
    --   "<LEADER>S",
    --   function()
    --     Snacks.scratch.select()
    --   end,
    --   desc = "Select Scratch Buffer",
    -- },
    {
      "<LEADER>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<LEADER>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Current Buffer",
    },
    {
      "<LEADER>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<LEADER>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<LEADER>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<LEADER>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<LEADER>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    {
      "<LEADER>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
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
          .option(
            "showtabline",
            { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }
          )
          :map("<LEADER>uA")
        Snacks.toggle.treesitter():map("<LEADER>uT")
        Snacks.toggle.inlay_hints():map("<LEADER>uh")

        Snacks.toggle.profiler():map("<LEADER>qp")
        Snacks.toggle.profiler_highlights():map("<LEADER>qh")
      end,
    })
  end,
}
