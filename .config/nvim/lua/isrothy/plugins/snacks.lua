require("snacks").setup({
  input = { enabled = false },
  image = { enabled = false },
  scroll = { enabled = false },
  picker = {
    prompt = " ",
    layout = {
      cycle = true,
      preset = function() return vim.o.columns >= 120 and "default" or "vertical" end,
    },
    win = {
      input = {
        keys = {
          ["<c-d>"] = { "list_scroll_down", mode = { "n" } },
          ["<c-u>"] = { "list_scroll_up", mode = { "n" } },
          ["<c-j>"] = {},
          ["<c-k>"] = {},
        },
      },
    },
    icons = {
      diagnostics = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      },
    },
  },
  statuscolumn = {
    enabled = true,
    left = { "mark", "sign" },
    right = { "fold", "git" },
    folds = {
      open = true,
      git_hl = true,
    },
    git = {
      patterns = { "GitSign" },
    },
    refresh = 50,
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
      textobject = {
        ii = { min_size = 2, edge = false, treesitter = { blocks = { enabled = true } }, desc = "Inner scope" },
        ai = { min_size = 2, treesitter = { blocks = { enabled = true } }, desc = "Full scope" },
      },
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
      only_scope = false,
      only_current = false,
      hl = "SnacksIndent",
    },
    animate = { enabled = false },
    scope = {
      char = "▎",
      underline = true,
      only_current = false,
      hl = "SnacksIndentScope",
    },
    blank = {
      char = "▎",
      hl = "SnacksIndentBlank",
    },
    treesitter = { enabled = true },
  },
  bigfile = {
    enabled = true,
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
  dashboard = { enabled = false },
  dim = { enabled = false },
  notifier = {
    enabled = true,
    icons = {
      error = " ",
      warn = " ",
      hint = " ",
      info = " ",
      debug = " ",
      trace = " ",
    },
    timeout = 5000,
  },
  quickfile = { enabled = true },
  words = { enabled = true },
  profiler = { pick = { picker = "auto" } },
  zen = { enabled = false },
})

_G.dd = function(...) Snacks.debug.inspect(...) end
_G.bt = function() Snacks.debug.backtrace() end
vim.print = _G.dd

Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>os")
Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>ow")
Snacks.toggle.option("diff", { name = "diff" }):map("<leader>od")
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
Snacks.toggle.inlay_hints({ name = "inlay hints" }):map("<leader>ci")
Snacks.toggle.indent():map("<leader><space>i")

Snacks.toggle({
  name = "autosave session",
  get = function()
    local session = require("isrothy.utils.session")
    return session.auto_save_enabled
  end,
  set = function(state)
    local session = require("isrothy.utils.session")
    session.auto_save_enabled = state
  end,
}):map("<leader>qq")

Snacks.toggle({
  name = "words",
  get = function() return Snacks.words.is_enabled() end,
  set = function(state)
    if state then
      Snacks.words.enable()
    else
      Snacks.words.disable()
    end
  end,
}):map("<leader>cw")

local map = vim.keymap.set

map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Config file" })
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Search files" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent file" })
map("n", "<leader>fs", function() Snacks.picker.smart() end, { desc = "Smart search" })
map("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })

map("n", "<leader>ia", function() Snacks.picker.autocmds() end, { desc = "Autocommands" })
map("n", "<leader>ic", function() Snacks.picker.commands() end, { desc = "Commands" })
map("n", "<leader>ih", function() Snacks.picker.highlights() end, { desc = "Highlights" })
map("n", "<leader>ii", function() Snacks.picker.icons() end, { desc = "Icons" })
map("n", "<leader>ij", function() Snacks.picker.jumps() end, { desc = "Jumps" })
map("n", "<leader>ik", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>il", function() Snacks.picker.loclist() end, { desc = "Location list" })
map("n", "<leader>iL", function() Snacks.picker.lsp_config() end, { desc = "Lsp configs" })
map("n", "<leader>iq", function() Snacks.picker.qflist() end, { desc = "Quickfix list" })
map("n", "<leader>i'", function() Snacks.picker.marks() end, { desc = "Marks" })
map("n", '<leader>i"', function() Snacks.picker.registers() end, { desc = "Registers" })
map(
  "n",
  "<leader>i/",
  function() Snacks.picker.search_history({ layout = { preset = "select" } }) end,
  { desc = "Search history" }
)
map(
  "n",
  "<leader>i:",
  function() Snacks.picker.command_history({ layout = { preset = "select" } }) end,
  { desc = "Command history" }
)
map("n", "<leader>i<F1>", function() Snacks.picker.help() end, { desc = "Help pages" })

map("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename file" })

map("n", "<leader>jd", function() Snacks.picker.lsp_definitions({ auto_confirm = false }) end, { desc = "Definition" })
map(
  "n",
  "<leader>jD",
  function() Snacks.picker.lsp_declarations({ auto_confirm = false }) end,
  { desc = "Declaration" }
)
map(
  "n",
  "<leader>ji",
  function() Snacks.picker.lsp_implementations({ auto_confirm = false }) end,
  { desc = "Implementation" }
)
map("n", "<leader>jr", function() Snacks.picker.lsp_references({ auto_confirm = false }) end, { desc = "References" })
map(
  "n",
  "<leader>jc",
  function() Snacks.picker.lsp_incoming_calls({ auto_confirm = false }) end,
  { desc = "Incoming calls" }
)
map(
  "n",
  "<leader>jo",
  function() Snacks.picker.lsp_outgoing_calls({ auto_confirm = false }) end,
  { desc = "Outgoing calls" }
)
map("n", "<leader>js", function() Snacks.picker.lsp_symbols() end, { desc = "Symbols" })
map(
  "n",
  "<leader>jt",
  function() Snacks.picker.lsp_type_definitions({ auto_confirm = false }) end,
  { desc = "Type definition" }
)
map("n", "<leader>jw", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Workspace symbols" })

map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete current buffer" })
map("n", "<leader>bD", function() Snacks.bufdelete.all() end, { desc = "Delete all buffers" })
map("n", "<leader>b/", function() Snacks.picker.buffers() end, { desc = "Picker" })
map("n", "<leader>bb", function() Snacks.picker.buffers() end, { desc = "Picker" })

map("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git blame current line" })
map("n", "<leader>gB", function() Snacks.picker.git_branches() end, { desc = "Git branches" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Search git diff" })
map("n", "<leader>gf", function() Snacks.picker.git_files() end, { desc = "Search git files" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git log" })
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git log current line" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git status" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })

map("n", "<leader>gg", function() Snacks.lazygit.open() end, { desc = "Open lazygit" })
map("n", "<leader>gt", function() Snacks.lazygit.log() end, { desc = "Open lazygit with log" })
map("n", "<leader>gh", function() Snacks.lazygit.log_file() end, { desc = "Open git with log of current file" })

map("n", "<leader>go", function() Snacks.gitbrowse.open() end, { desc = "Browse current file" })

map("n", "<leader>Gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
map("n", "<leader>GI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
map("n", "<leader>Gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
map("n", "<leader>GP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub Pull Requests (all)" })

map("n", "<leader>nd", function() Snacks.notifier.hide() end, { desc = "Dissmiss" })
map("n", "<leader>nh", function() Snacks.notifier.show_history() end, { desc = "History" })
map("n", "<leader>n/", function() Snacks.picker.notifications() end, { desc = "Search" })

map("n", "<leader>u/", function() Snacks.picker.undo() end, { desc = "Search" })

map("n", "<leader>x/", function() Snacks.picker.diagnostics() end, { desc = "Picker" })
map("n", "<leader>x?", function() Snacks.picker.diagnostics_buffer() end, { desc = "Search buffer picker" })

map("n", "<leader>//", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>/l", function() Snacks.picker.lines() end, { desc = "Buffer lines" })
map("n", "<leader>/b", function() Snacks.picker.grep_buffers() end, { desc = "Grep open buffers" })

map({ "n", "x" }, "<leader>/w", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })

map("n", "<leader>..", function() Snacks.scratch() end, { desc = "Toggle scratch buffer" })
map("n", "<leader>.s", function() Snacks.scratch.select() end, { desc = "Select scratch buffer" })

map("n", "<leader>z", function() Snacks.picker.zoxide() end, { desc = "Zoxide" })

map("n", "<leader>;", function() Snacks.picker.resume() end, { desc = "Resume picker" })

map("n", "]]", function() Snacks.words.jump(vim.v.count1, true) end, { desc = "Next reference" })
map("n", "[[", function() Snacks.words.jump(-vim.v.count1, true) end, { desc = "Prev reference" })
