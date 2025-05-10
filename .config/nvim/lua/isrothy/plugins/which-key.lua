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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "echasnovski/mini.ai",
    },
    event = "VeryLazy",
    keys = {
      {
        "<LEADER>?",
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
        spelling = {
          enabled = true,
          suggestions = 20,
        },
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
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
        -- Additional vim.wo and vim.bo options
        bo = {},
        wo = {
          winblend = 10, -- Value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      -- keys = {
      --   scroll_down = "<c-n>", -- binding to scroll down inside the popup
      --   scroll_up = "<c-p>", -- binding to scroll up inside the popup
      -- },
      spec = {
        { "<LEADER>a", group = "AI", mode = { "n", "x" } },
        {
          "<LEADER>b",
          group = "Buffer",
          expand = function() return require("which-key.extras").expand.buf() end,
        },
        { "<LEADER>bx", group = "Exchange" },
        { "<LEADER>c", group = "Colorize" },
        { "<LEADER>d", group = "Dap", mode = { "n", "x" } },
        { "<LEADER>e", group = "Explore" },
        { "<LEADER>f", group = "Find" },
        { "<LEADER>g", group = "Git", mode = { "n", "x" } },
        { "<LEADER>G", group = "Github" },
        { "<LEADER>h", group = "Harpoon" },

        { "<LEADER>j", group = "Split/Join" },

        { "<LEADER>l", group = "LSP", mode = { "n", "x" } },
        { "<LEADER>m", group = "Minimap" },
        { "<LEADER>mr", group = "Refresh" },
        { "<LEADER>n", group = "Noice" },
        { "<LEADER>o", group = "Options" },

        { "<LEADER>q", group = "Session" },
        { "<LEADER>r", group = "Refactors", mode = { "n", "x" } },

        { "<LEADER>t", group = "Test" },

        {
          "<LEADER>w",
          proxy = "<C-W>",
          group = "windows",
          expand = function() return require("which-key.extras").expand.win() end,
        },
        { "<LEADER>W", group = "Wrokspace" },
        { "<LEADER>x", group = "Diagnostics" },

        { "<LEADER>z", group = "Zen mode" },

        { "<LEADER>/", group = "Grep", mode = { "n", "x" } },
        { "<LEADER>!", group = "Tasks" },
        { "<LEADER>$", group = "Terminal" },

        { "<LEADER><TAB>", group = "Tabpage" },
        { "<LEADER><SPACE>", group = "Whitespaces", mode = { "n", "x" } },
        { "<LEADER><SPACE>b", group = "Buffer" },

        { "[", group = "Prev" },
        { "]", group = "Next" },

        {
          "<LOCALLEADER>p",
          group = "Python",
          cond = function() return vim.bo.filetype == "python" end,
        },

        { "<ESC>", ":nohlsearch<CR><ESC>", desc = "Clear search highlight" },
        { "<C-\\>", "<C-\\><C-N>", desc = "Escape terminal mode", mode = "t" },
        {
          mode = "x",
          { ".", ":norm .<CR>", desc = "Repeat last command" },
          { "@", ":norm @q<CR>", desc = "Repeat last macro" },
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
          { ",", ",<C-G>u" },
          { ";", ";<C-G>u" },
          { ".", ".<C-G>u" },
        },

        -- Move in insert/command/terminal mode
        {
          mode = { "i", "c", "t" },
          { "<M-h>", "<LEFT>", desc = "Left" },
          { "<M-j>", "<DOWN>", desc = "Down" },
          { "<M-k>", "<UP>", desc = "Up" },
          { "<M-l>", "<RIGHT>", desc = "Right" },
        },

        { "g/", "<ESC>/\\%V", desc = "Search inside visual selection", mode = "x", silent = false },
        {
          "gV",
          '"`[" . strpart(getregtype(), 0, 1) . "`]"',
          desc = "Visually select changed text",
          replace_keycodes = false,
          expr = true,
        },

        { "<LEADER>ba", "<c-^>", desc = "alternate buffer" },

        { "<LEADER>wd", "<C-W>c", desc = "Close current window" },

        {
          "<LEADER><SPACE>t",
          function()
            local current_view = vim.fn.winsaveview()
            local command = "%s/\\s\\+$//e"
            vim.cmd("keeppatterns " .. command)
            vim.fn.winrestview(current_view)
          end,
          desc = "Trim trailing whitespace",
        },

        { "<LEADER>xq", vim.diagnostic.setqflist, desc = "Quickfix list" },
        { "<LEADER>xl", vim.diagnostic.setloclist, desc = "Location list" },
        { "<LEADER>xc", vim.diagnostic.open_float, desc = "Current line" },

        {
          "gco",
          "o<ESC>Vcx<ESC><CMD>normal gcc<CR>fxa<BS>",
          desc = "Add comment below",
        },
        {
          "gcO",
          "O<ESC>Vcx<ESC><CMD>normal gcc<CR>fxa<BS>",
          desc = "Add comment above",
        },

        { "]e", diagnostic_goto(1, "ERROR"), desc = "Next error" },
        { "[e", diagnostic_goto(-1, "ERROR"), desc = "Next error " },
        { "]w", diagnostic_goto(1, "WARN"), desc = "Next warning" },
        { "[w", diagnostic_goto(-1, "WARN"), desc = "Next warning" },

        { "]u", "g+", desc = "Next undo" },
        { "[u", "g-", desc = "Previous undo" },

        { "]<tab>", "<CMD>tabnext<CR>", desc = "Next tab" },
        { "[<tab>", "<CMD>tabprevious<CR>", desc = "Previous tab" },

        { "K", vim.lsp.buf.hover, desc = "Hover" },
        { "<LEADER>lh", vim.lsp.buf.hover, desc = "Hover" },
        { "<LEADER>ln", vim.lsp.buf.rename, desc = "Rename symbol" },
        { "<LEADER>ll", vim.lsp.codelens.run, desc = "Code lens" },
        { "<LEADER>la", vim.lsp.buf.code_action, desc = "Code action" },

        { "<leader>Wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace" },
        { "<leader>Wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace" },
        {
          "<leader>Wl",
          function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
          desc = "List workspace",
        },

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

        -- Diff
        {
          mode = { "n", "x" },
          cond = is_diff,
          { "<LocalLeader>d", group = "Diff" },
          { "<LocalLeader>dg", group = "Get" },
          { "<LocalLeader>dp", group = "Put" },

          { "<LocalLeader>dgg", "<cmd>diffget<CR>", desc = "Get from other" },
          { "<LocalLeader>dpp", "<cmd>diffput<CR>", desc = "Put to other" },

          { "<LocalLeader>dgl", "<cmd>diffget LOCAL<cr>", desc = "Get from LOCAL" },
          { "<LocalLeader>dgb", "<cmd>diffget BASE<cr>", desc = "Get from BASE" },
          { "<LocalLeader>dgr", "<cmd>diffget REMOTE<cr>", desc = "Get from REMOTE" },

          { "<LocalLeader>dg0", "<cmd>diffget 0<cr>", desc = "Get from buffer 0" },
          { "<LocalLeader>dg1", "<cmd>diffget 1<cr>", desc = "Get from buffer 1" },
          { "<LocalLeader>dg2", "<cmd>diffget 2<cr>", desc = "Get from buffer 2" },
          { "<LocalLeader>dg3", "<cmd>diffget 3<cr>", desc = "Get from buffer 3" },
          { "<LocalLeader>dg4", "<cmd>diffget 4<cr>", desc = "Get from buffer 4" },
          { "<LocalLeader>dg5", "<cmd>diffget 5<cr>", desc = "Get from buffer 5" },
          { "<LocalLeader>dg6", "<cmd>diffget 6<cr>", desc = "Get from buffer 6" },
          { "<LocalLeader>dg7", "<cmd>diffget 7<cr>", desc = "Get from buffer 7" },
          { "<LocalLeader>dg8", "<cmd>diffget 8<cr>", desc = "Get from buffer 8" },
          { "<LocalLeader>dg9", "<cmd>diffget 9<cr>", desc = "Get from buffer 9" },

          { "<LocalLeader>dp0", "<cmd>diffput 0<cr>", desc = "Put to buffer 0" },
          { "<LocalLeader>dp1", "<cmd>diffput 1<cr>", desc = "Put to buffer 1" },
          { "<LocalLeader>dp2", "<cmd>diffput 2<cr>", desc = "Put to buffer 2" },
          { "<LocalLeader>dp3", "<cmd>diffput 3<cr>", desc = "Put to buffer 3" },
          { "<LocalLeader>dp4", "<cmd>diffput 4<cr>", desc = "Put to buffer 4" },
          { "<LocalLeader>dp5", "<cmd>diffput 5<cr>", desc = "Put to buffer 5" },
          { "<LocalLeader>dp6", "<cmd>diffput 6<cr>", desc = "Put to buffer 6" },
          { "<LocalLeader>dp7", "<cmd>diffput 7<cr>", desc = "Put to buffer 7" },
          { "<LocalLeader>dp8", "<cmd>diffput 8<cr>", desc = "Put to buffer 8" },
          { "<LocalLeader>dp9", "<cmd>diffput 9<cr>", desc = "Put to buffer 9" },
        },
      },
    },
  },
}
