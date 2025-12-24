local diagnostic_goto = function(count, severity)
  return function()
    vim.diagnostic.jump({
      count = count,
      severity = severity and vim.diagnostic.severity[severity] or nil,
    })
  end
end

return {
  {
    "folke/which-key.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function() require("which-key").show() end,
        desc = "Global keymaps (Which-Key)",
      },
      {
        "<localleader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer local keymaps (Which-Key)",
      },
    },
    opts = {
      preset = "modern",
      show_help = false,
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = true, suggestions = 20 },
        presets = {
          operators = true, -- Adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- Help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- Misc bindings to work with windows
          z = true, -- Bindings for folds, spelling, and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      sort = { "local", "order", "group", "alphanum", "mod", "lower", "icase" },
      win = {
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
        bo = {},
        wo = { winblend = 10 },
      },
      spec = {
        { "<leader>a", group = "AI", mode = { "n", "x" } },
        {
          {
            "<leader>b",
            group = "Buffer",
          },
          {
            "<leader>bh",
            function() require("isrothy.utils.window").swap_with_window("h") end,
            desc = "Swap with left window",
          },
          {
            "<leader>bl",
            function() require("isrothy.utils.window").swap_with_window("l") end,
            desc = "Swap with right window",
          },
          {
            "<leader>bj",
            function() require("isrothy.utils.window").swap_with_window("j") end,
            desc = "Swap with below window",
          },
          {
            "<leader>bk",
            function() require("isrothy.utils.window").swap_with_window("k") end,
            desc = "Swap with above window",
          },
          { "<leader>ba", "<c-^>", desc = "Alternate buffer" },
        },
        {
          { "<leader>c", group = "Code", mode = { "n", "x" } },
          { "<leader>cr", vim.lsp.buf.rename, desc = "Rename symbol" },
          { "<leader>cl", vim.lsp.codelens.run, desc = "Code lens" },
          { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
          { "<leader>ch", vim.lsp.buf.hover, desc = "Hover" },
          { "K", vim.lsp.buf.hover, desc = "Hover" },
        },
        { "<leader>C", group = "Colorize" },
        { "<leader>d", group = "Debug", mode = { "n", "x" } },
        {
          mode = { "n", "x" },
          { "<leader>D", group = "Diff" },
          { "<leader>Dg", group = "Get" },
          { "<leader>Dp", group = "Put" },

          { "<leader>Dgg", "<cmd>diffget<cr>", desc = "Get from other" },
          { "<leader>Dpp", "<cmd>diffput<cr>", desc = "Put to other" },

          { "<leader>Dgl", "<cmd>diffget LOCAL<cr>", desc = "Get from LOCAL" },
          { "<leader>Dgb", "<cmd>diffget BASE<cr>", desc = "Get from BASE" },
          { "<leader>Dgr", "<cmd>diffget REMOTE<cr>", desc = "Get from REMOTE" },

          { "<leader>Dg0", "<cmd>diffget 0<cr>", desc = "Get from buffer 0" },
          { "<leader>Dg1", "<cmd>diffget 1<cr>", desc = "Get from buffer 1" },
          { "<leader>Dg2", "<cmd>diffget 2<cr>", desc = "Get from buffer 2" },
          { "<leader>Dg3", "<cmd>diffget 3<cr>", desc = "Get from buffer 3" },
          { "<leader>Dg4", "<cmd>diffget 4<cr>", desc = "Get from buffer 4" },
          { "<leader>Dg5", "<cmd>diffget 5<cr>", desc = "Get from buffer 5" },
          { "<leader>Dg6", "<cmd>diffget 6<cr>", desc = "Get from buffer 6" },
          { "<leader>Dg7", "<cmd>diffget 7<cr>", desc = "Get from buffer 7" },
          { "<leader>Dg8", "<cmd>diffget 8<cr>", desc = "Get from buffer 8" },
          { "<leader>Dg9", "<cmd>diffget 9<cr>", desc = "Get from buffer 9" },

          { "<leader>Dp0", "<cmd>diffput 0<cr>", desc = "Put to buffer 0" },
          { "<leader>Dp1", "<cmd>diffput 1<cr>", desc = "Put to buffer 1" },
          { "<leader>Dp2", "<cmd>diffput 2<cr>", desc = "Put to buffer 2" },
          { "<leader>Dp3", "<cmd>diffput 3<cr>", desc = "Put to buffer 3" },
          { "<leader>Dp4", "<cmd>diffput 4<cr>", desc = "Put to buffer 4" },
          { "<leader>Dp5", "<cmd>diffput 5<cr>", desc = "Put to buffer 5" },
          { "<leader>Dp6", "<cmd>diffput 6<cr>", desc = "Put to buffer 6" },
          { "<leader>Dp7", "<cmd>diffput 7<cr>", desc = "Put to buffer 7" },
          { "<leader>Dp8", "<cmd>diffput 8<cr>", desc = "Put to buffer 8" },
          { "<leader>Dp9", "<cmd>diffput 9<cr>", desc = "Put to buffer 9" },
        },
        { "<leader>e", group = "Environment" },
        {
          { "<leader>f", group = "File" },
          { "<leader>fd", "<cmd>DeleteFile<cr>", desc = "Delete file" },
        },
        { "<leader>g", group = "Git", mode = { "n", "x" } },
        { "<leader>G", group = "Github" },
        { "<leader>h", group = "Hunk", mode = { "n", "x" } },
        { "<leader>i", group = "Info" },
        { "<leader>j", group = "Jump", mode = { "n", "x" } },
        { "<leader>k", group = "Rename case", mode = { "n", "x" } },
        { "<leader>m", group = "Minimap" },
        { "<leader>mr", group = "Refresh" },
        { "<leader>n", group = "Notification" },
        { "<leader>o", group = "Options" },
        {
          { "<leader>q", group = "Session" },
          {
            "<leader>qs",
            function() require("isrothy.utils.session").save() end,
            desc = "Save session",
          },
          {
            "<leader>ql",
            function() require("isrothy.utils.session").load_current() end,
            desc = "Load session",
          },
          {
            "<leader>q/",
            function() require("isrothy.utils.session").select() end,
            desc = "Load session",
          },
        },
        { "<leader>r", group = "Refactors", mode = { "n", "x" } },
        { "<leader>t", group = "Test" },
        { "<leader>u", group = "Undo" },
        {
          {
            "<leader>w",
            proxy = "<c-w>",
            group = "windows",
            expand = function() return require("which-key.extras").expand.win() end,
          },
          { "<leader>wd", "<c-W>c", desc = "Close current window" },
          { "<leader>wa", "<c-W>^", desc = "Alternate window" },
          { "<leader>wx", "<c-W>p", desc = "Previous window" },
        },
        {
          { "<leader>W", group = "Wrokspace" },
          { "<leader>Wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace" },
          { "<leader>Wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace" },
          {
            "<leader>Wl",
            function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            desc = "List workspace",
          },
        },
        {
          { "<leader>x", group = "Diagnostics" },
          { "<leader>xq", vim.diagnostic.setqflist, desc = "Quickfix list" },
          { "<leader>xl", vim.diagnostic.setloclist, desc = "Location list" },
          { "<leader>xc", vim.diagnostic.open_float, desc = "Current line" },
        },
        { "<leader>/", group = "Grep", mode = { "n", "x" } },
        { "<leader>!", group = "Tasks" },
        { "<leader>$", group = "Terminal" },
        {
          { "<leader><tab>", group = "Tabpage" },
          { "<leader><tab>o", "<cmd>tabonly<cr>", desc = "Close other tabs" },
          { "<leader><tab>d", "<cmd>tabclose<cr>", desc = "Close current tab" },
          { "<leader><tab>f", "<cmd>tabfirst<cr>", desc = "First tab" },
          { "<leader><tab>l", "<cmd>tablast<cr>", desc = "Last tab" },
          { "<leader><tab><tab>", "<cmd>tabnew<cr>", desc = "New tab" },
          {
            "<leader><tab>c",
            function()
              vim.ui.input({ prompt = "Enter tab number to close: " }, function(input)
                local tab_number = tonumber(input)
                if tab_number then
                  vim.cmd("tabclose " .. tab_number)
                else
                  print("Invalid tab number")
                end
              end)
            end,
            desc = "Close a tab",
          },
          {
            "<leader><tab>p",
            function()
              vim.ui.input({ prompt = "Enter tab number to pick: " }, function(input)
                local tab_number = tonumber(input)
                if tab_number then
                  vim.cmd("tabn " .. tab_number)
                else
                  print("Invalid tab number")
                end
              end)
            end,
            desc = "Pick a tab",
          },
        },
        {
          { "<leader><space>", group = "Whitespaces", mode = { "n", "x" } },
          {
            "<leader><space>t",
            function()
              local current_view = vim.fn.winsaveview()
              local command = "%s/\\s\\+$//e"
              vim.cmd("keeppatterns " .. command)
              vim.fn.winrestview(current_view)
            end,
            desc = "Trim trailing whitespace",
          },
        },

        {
          { "[", group = "Prev" },
          { "]", group = "Next" },
          { "]e", diagnostic_goto(1, "ERROR"), desc = "Next error" },
          { "[e", diagnostic_goto(-1, "ERROR"), desc = "Next error " },
          { "]w", diagnostic_goto(1, "WARN"), desc = "Next warning" },
          { "[w", diagnostic_goto(-1, "WARN"), desc = "Next warning" },
          { "]u", "g+", desc = "Next undo" },
          { "[u", "g-", desc = "Previous undo" },
          { "]j", "<c-i>", desc = "Next jump" },
          { "[j", "<c-o>", desc = "Previous jump" },
          { "<s-tab>", "<c-o>", desc = "Previous jump" },
          { "]<tab>", "<cmd>tabnext<cr>", desc = "Next tab" },
          { "[<tab>", "<cmd>tabprevious<cr>", desc = "Previous tab" },
        },

        { "<esc>", ":nohlsearch<cr><esc>", desc = "Clear search highlight" },
        { "<C-\\>", "<C-\\><c-N>", desc = "Escape terminal mode", mode = "t" },
        { "U", "<cmd>@:", desc = "Repeat last command" },
        { "<tab>", "<c-^>", desc = "Alternate buffer" },
        {
          mode = "x",
          { ".", ":norm .<cr>", desc = "Repeat last command" },
          { "@", ":norm @q<cr>", desc = "Repeat last macro" },
        },

        -- move up/down in wrapped lines
        {
          mode = { "n", "x" },
          expr = true,
          { "k", "v:count == 0 ? 'gk' : 'k'", desc = "Up" },
          { "j", "v:count == 0 ? 'gj' : 'j'", desc = "Down" },
        },

        -- Add undo breakpoints
        {
          mode = { "i" },
          { ",", ",<c-g>u" },
          { ";", ";<c-g>u" },
          { ".", ".<c-g>u" },
        },

        -- Move in insert/command mode
        {
          mode = { "i", "c" },
          { "<m-h>", "<left>", desc = "Left" },
          { "<m-j>", "<down>", desc = "Down" },
          { "<m-k>", "<up>", desc = "Up" },
          { "<m-l>", "<right>", desc = "Right" },
        },

        {
          mode = { "i", "c", "t" },
          { "<c-d>", "<DEL>", desc = "Delete" },
        },

        {
          mode = { "n" },
          { "<c-h>", "<c-w>h", desc = "Move to window left" },
          { "<c-j>", "<c-w>j", desc = "Move to window below" },
          { "<c-k>", "<c-w>k", desc = "Move to window above" },
          { "<c-l>", "<c-w>l", desc = "Move to window right" },
          {
            "<c-w>>",
            function()
              vim.cmd("vertical resize +2")
              require("isrothy.utils.window").trigger()
            end,
            desc = "Increase window width",
          },
          {
            "<c-w><",
            function()
              vim.cmd("vertical resize -2")
              require("isrothy.utils.window").trigger()
            end,
            desc = "Decrease window width",
          },
          {
            "<c-w>+",
            function()
              vim.cmd("resize +2")
              require("isrothy.utils.window").trigger()
            end,
            desc = "Increase window height",
          },
          {
            "<c-w>-",
            function()
              vim.cmd("resize -2")
              require("isrothy.utils.window").trigger()
            end,
            desc = "Decrease window height",
          },
        },

        { "g/", "<esc>/\\%V", desc = "Search inside visual selection", mode = "x", silent = false },
        {
          "gV",
          '"`[" . strpart(getregtype(), 0, 1) . "`]"',
          desc = "Visually select changed text",
          replace_keycodes = false,
          expr = true,
        },

        {
          "gco",
          "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>",
          desc = "Add comment below",
        },
        {
          "gcO",
          "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>",
          desc = "Add comment above",
        },

        { "<leader>l", function() require("isrothy.utils.context").show() end, mode = { "n" } },

        {
          "gG",
          function() require("isrothy.utils.text-obj").entire_buffer() end,
          mode = { "o", "x" },
          desc = "Entire buffer",
        },
        {
          "iS",
          function() require("isrothy.utils.text-obj").subword_inner() end,
          mode = { "o", "x" },
          desc = "Inside subword",
        },
        {
          "aS",
          function() require("isrothy.utils.text-obj").subword_outer() end,
          mode = { "o", "x" },
          desc = "Around subword",
        },
        { "L", function() require("isrothy.utils.text-obj").url() end, mode = { "o", "x" }, desc = "URL" },
        { "F", function() require("isrothy.utils.text-obj").filepath() end, mode = { "o", "x" }, desc = "Filepath" },
      },
    },
  },
}
