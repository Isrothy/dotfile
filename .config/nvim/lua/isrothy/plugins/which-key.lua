local function is_diff() return vim.opt.diff:get() end
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
            expand = function() return require("which-key.extras").expand.buf() end,
          },
          { "<leader>bx", group = "Exchange" },
          { "<leader>ba", "<c-^>", desc = "Alternate buffer" },
        },
        {
          { "<leader>c", group = "Code", mode = { "n", "x" } },
          { "<leader>cr", vim.lsp.buf.rename, desc = "Rename symbol" },
          { "<leader>cl", vim.lsp.codelens.run, desc = "Code lens" },
          { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
        },
        { "<leader>C", group = "Colorize" },
        { "<leader>d", group = "Debug", mode = { "n", "x" } },
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
        {
          { "<leader>l", group = "Lint" },
          { "<leader>lh", vim.lsp.buf.hover, desc = "Hover" },
          { "K", vim.lsp.buf.hover, desc = "Hover" },
        },
        { "<leader>m", group = "Minimap" },
        { "<leader>mr", group = "Refresh" },
        { "<leader>n", group = "Notification" },
        { "<leader>o", group = "Options" },
        { "<leader>q", group = "Session" },
        { "<leader>r", group = "Refactors", mode = { "n", "x" } },
        { "<leader>t", group = "Test" },
        { "<leader>T", group = "Todo" },
        { "<leader>u", group = "Undo" },
        {
          {
            "<leader>w",
            proxy = "<c-w>",
            group = "windows",
            expand = function() return require("which-key.extras").expand.win() end,
          },
          { "<leader>wd", "<c-W>c", desc = "Close current window" },
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
        { "<leader>z", group = "Zen mode" },
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
          mode = { "n", "x" },
          cond = is_diff,
          { "<localleader>d", group = "Diff" },
          { "<localleader>dg", group = "Get" },
          { "<localleader>dp", group = "Put" },

          { "<localleader>dgg", "<cmd>diffget<cr>", desc = "Get from other" },
          { "<localleader>dpp", "<cmd>diffput<cr>", desc = "Put to other" },

          { "<localleader>dgl", "<cmd>diffget LOCAL<cr>", desc = "Get from LOCAL" },
          { "<localleader>dgb", "<cmd>diffget BASE<cr>", desc = "Get from BASE" },
          { "<localleader>dgr", "<cmd>diffget REMOTE<cr>", desc = "Get from REMOTE" },

          { "<localleader>dg0", "<cmd>diffget 0<cr>", desc = "Get from buffer 0" },
          { "<localleader>dg1", "<cmd>diffget 1<cr>", desc = "Get from buffer 1" },
          { "<localleader>dg2", "<cmd>diffget 2<cr>", desc = "Get from buffer 2" },
          { "<localleader>dg3", "<cmd>diffget 3<cr>", desc = "Get from buffer 3" },
          { "<localleader>dg4", "<cmd>diffget 4<cr>", desc = "Get from buffer 4" },
          { "<localleader>dg5", "<cmd>diffget 5<cr>", desc = "Get from buffer 5" },
          { "<localleader>dg6", "<cmd>diffget 6<cr>", desc = "Get from buffer 6" },
          { "<localleader>dg7", "<cmd>diffget 7<cr>", desc = "Get from buffer 7" },
          { "<localleader>dg8", "<cmd>diffget 8<cr>", desc = "Get from buffer 8" },
          { "<localleader>dg9", "<cmd>diffget 9<cr>", desc = "Get from buffer 9" },

          { "<localleader>dp0", "<cmd>diffput 0<cr>", desc = "Put to buffer 0" },
          { "<localleader>dp1", "<cmd>diffput 1<cr>", desc = "Put to buffer 1" },
          { "<localleader>dp2", "<cmd>diffput 2<cr>", desc = "Put to buffer 2" },
          { "<localleader>dp3", "<cmd>diffput 3<cr>", desc = "Put to buffer 3" },
          { "<localleader>dp4", "<cmd>diffput 4<cr>", desc = "Put to buffer 4" },
          { "<localleader>dp5", "<cmd>diffput 5<cr>", desc = "Put to buffer 5" },
          { "<localleader>dp6", "<cmd>diffput 6<cr>", desc = "Put to buffer 6" },
          { "<localleader>dp7", "<cmd>diffput 7<cr>", desc = "Put to buffer 7" },
          { "<localleader>dp8", "<cmd>diffput 8<cr>", desc = "Put to buffer 8" },
          { "<localleader>dp9", "<cmd>diffput 9<cr>", desc = "Put to buffer 9" },
        },
        {
          "<localleader>p",
          group = "Python",
          cond = function() return vim.bo.filetype == "python" end,
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
        { "Z", "<c-^>", desc = "Alternate buffer" },
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

        -- Move in insert/command/terminal mode
        {
          mode = { "i", "c", "t" },
          { "<m-h>", "<left>", desc = "Left" },
          { "<m-j>", "<down>", desc = "Down" },
          { "<m-k>", "<up>", desc = "Up" },
          { "<m-l>", "<right>", desc = "Right" },
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
      },
    },
  },
}
