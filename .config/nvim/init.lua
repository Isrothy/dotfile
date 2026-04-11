local g = vim.g
local map = vim.keymap.set
local opt = vim.opt

local function debounce(ms, fn)
  local timer = vim.uv.new_timer()
  if timer == nil then
    vim.notify("Failed to create timer", vim.log.levels.WARN, { title = "nvim-lint" })
    return
  end
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

-- ==========================================
-- Session Manager {{{
-- ==========================================
local session_manager = {}

local session_dir = vim.fn.stdpath("state") .. "/sessions/"
if vim.fn.isdirectory(session_dir) == 0 then
  vim.fn.mkdir(session_dir, "p")
end

session_manager.auto_save_enabled = true
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp"

local function path_to_name(path) return path:gsub(":", ""):gsub("/", "%%") .. ".vim" end
local function name_to_path(name) return name:gsub("%%", "/"):gsub("%.vim$", "") end
local function get_current_session_path() return session_dir .. path_to_name(vim.fn.getcwd()) end

function session_manager.save()
  if vim.bo.filetype == "alpha" or vim.bo.filetype == "snacks_dashboard" then
    return
  end

  local name = get_current_session_path()
  vim.cmd("mksession! " .. vim.fn.fnameescape(name))
  vim.notify("Session saved for: " .. vim.fn.getcwd(), vim.log.levels.INFO, { title = "Session" })
end

function session_manager.load_current()
  local name = get_current_session_path()
  if vim.fn.filereadable(name) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(name))
    vim.notify("Session loaded.", vim.log.levels.INFO, { title = "Session" })
  else
    vim.notify("No session found for this directory.", vim.log.levels.WARN, { title = "Session" })
  end
end

function session_manager.select()
  local files = vim.fn.glob(session_dir .. "*.vim", false, true)
  if #files == 0 then
    vim.notify("No saved sessions found.", vim.log.levels.WARN)
    return
  end

  local items = {}
  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t")
    local path = name_to_path(filename)
    table.insert(items, {
      label = path,
      file = file,
    })
  end

  vim.ui.select(items, {
    prompt = "Select Session to Load:",
    format_item = function(item)
      if item.label == vim.fn.getcwd() then
        return item.label .. " (Current)"
      end
      return item.label
    end,
  }, function(choice)
    if choice then
      if session_manager.auto_save_enabled then
        session_manager.save()
      end

      vim.cmd("silent! %bd!")
      vim.cmd("silent! source " .. vim.fn.fnameescape(choice.file))
      vim.notify("Loaded session: " .. choice.label, vim.log.levels.INFO)
    end
  end)
end

function session_manager.enable_autosave()
  session_manager.auto_save_enabled = true
  vim.notify("Auto-Save Session: Enabled", vim.log.levels.INFO, { title = "Session" })
end

function session_manager.disable_autosave()
  session_manager.auto_save_enabled = false
  vim.notify("Auto-Save Session: Disabled", vim.log.levels.INFO, { title = "Session" })
end

--- }}}

-- ==========================================
-- Indentation {{{
-- ==========================================

local MAX_LINES = 2048

-- Return the most common value in list
local function most_common(tbl)
  local freq = {}
  local best_val, best_count = nil, 0
  for _, v in ipairs(tbl) do
    freq[v] = (freq[v] or 0) + 1
    if freq[v] > best_count then
      best_val = v
      best_count = freq[v]
    end
  end
  return best_val
end

local function detect_indentation(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  if line_count == 0 then
    return
  end

  local max_lines = math.min(line_count, MAX_LINES)

  local tab_lines = 0
  local indents = {}

  for i = 1, max_lines do
    local line = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)[1]

    -- Skip empty or whitespace-only lines
    if not line or line:match("^%s*$") then
      goto continue
    end

    local leading = line:match("^(%s+)")
    if leading then
      if leading:find("\t") then
        tab_lines = tab_lines + 1
      else
        table.insert(indents, #leading)
      end
    end

    ::continue::
  end

  if tab_lines == 0 and #indents == 0 then
    return
  end

  local bo = vim.bo[bufnr]

  if tab_lines > #indents then
    bo.expandtab = false
    return
  end

  local deltas = {}
  for i = 2, #indents do
    local d = indents[i] - indents[i - 1]
    if d > 0 then
      table.insert(deltas, d)
    end
  end

  if #deltas == 0 then
    return
  end

  local width = most_common(deltas)
  if width and width > 0 and width <= 8 then
    bo.expandtab = true
    bo.shiftwidth = width
    bo.tabstop = width
    bo.softtabstop = width
  end
end
---}}}

-- ==========================================
-- context {{{
-- ==========================================

local context = {}

context.state = {
  win = nil,
  au = nil,
}

---@type table<string, string[]>
context.targets = {
  default = {
    "class_definition",
    "class_specifier",
    "class_declaration",
    "function_declaration",
    "function_definition",
    "method_definition",
    "method_declaration",
    "if_statement",
    "for_statement",
    "for_range_loop",
    "while_statement",
    "while_expression",
  },

  sh = {
    "function_definition",
    "if_statement",
    "for_statement",
    "while_statement",
    "case_command",
    "elif_clause",
  },

  lua = {
    "function_declaration",
    "function_definition",
    "if_statement",
    "for_statement",
    "while_statement",
    "repeat_statement",
    "table_constructor",
  },

  c = {
    "function_definition",
    "struct_specifier",
    "enum_specifier",
    "if_statement",
    "for_statement",
    "while_statement",
    "do_statement",
    "switch_statement",
    "case_statement",
    "preproc_if",
    "preproc_ifdef",
    "preproc_elif",
    "preproc_else",
  },

  cpp = {
    "namespace_definition",
    "class_specifier",
    "struct_specifier",
    "enum_specifier",
    "function_definition",
    "template_declaration",
    "if_statement",
    "for_statement",
    "for_range_loop",
    "while_statement",
    "do_statement",
    "switch_statement",
    "case_statement",
    "try_statement",
    "catch_clause",
    "preproc_if",
    "preproc_ifdef",
    "preproc_elif",
    "preproc_else",
  },

  java = {
    "class_declaration",
    "interface_declaration",
    "enum_declaration",
    "record_declaration",
    "method_declaration",
    "constructor_declaration",
    "if_statement",
    "for_statement",
    "while_statement",
    "do_statement",
    "try_statement",
    "try_with_resources_statement",
    "catch_clause",
    "switch_expression",
    "switch_statement",
  },

  python = {
    "class_definition",
    "function_definition",
    "async_function_definition",
    "decorated_definition",
    "if_statement",
    "for_statement",
    "while_statement",
    "try_statement",
    "with_statement",
    "match_statement",
  },

  rust = {
    "impl_item",
    "trait_item",
    "function_item",
    "mod_item",
    "enum_variant",
    "macro_definition",
    "if_expression",
    "loop_expression",
    "for_expression",
    "while_expression",
    "match_expression",
    "match_arm",
  },
}
context.targets.cuda = context.targets.cpp
context.targets.zsh = context.targets.sh
context.targets.bash = context.targets.sh

local function render_window(context_nodes)
  local current_buf = vim.api.nvim_get_current_buf()
  local content = {}
  local max_lnum = context_nodes[#context_nodes].row + 1
  local lnum_width = tostring(max_lnum):len()

  for _, item in ipairs(context_nodes) do
    local row = item.row
    local line_text = vim.api.nvim_buf_get_lines(current_buf, row, row + 1, false)[1] or ""
    line_text = vim.trim(line_text)
    local indent = string.rep("  ", #content)
    local lnum_str = string.format("%" .. lnum_width .. "d", row + 1)
    table.insert(content, string.format("%s │ %s%s", lnum_str, indent, line_text))
  end
  return content
end

local function open_window(content, filetype)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

  local width = 0
  for _, line in ipairs(content) do
    width = math.max(width, #line)
  end
  width = math.min(width, vim.o.columns - 4)
  local height = #content

  local win_opts = {
    relative = "cursor",
    row = 1,
    col = 0,
    width = width + 2,
    height = height,
    style = "minimal",
    border = "rounded",
    title = " Context ",
    title_pos = "center",
    focusable = true,
  }

  local win = vim.api.nvim_open_win(buf, false, win_opts)
  if not win then
    return
  end

  context.state.win = win

  vim.bo[buf].filetype = filetype

  vim.api.nvim_win_call(win, function() vim.fn.matchadd("Comment", "^\\s*\\d\\+ │") end)

  local close_cmd = "<cmd>close<cr>"
  vim.keymap.set("n", "q", close_cmd, { buffer = buf, nowait = true })
  vim.keymap.set("n", "<Esc>", close_cmd, { buffer = buf, nowait = true })

  context.state.au = vim.api.nvim_create_autocmd(
    { "CursorMoved", "CursorMovedI", "InsertEnter", "BufLeave", "WinScrolled" },
    {
      buffer = vim.api.nvim_get_current_buf(),
      once = true,
      callback = function()
        if vim.api.nvim_win_is_valid(win) and vim.api.nvim_get_current_win() ~= win then
          vim.api.nvim_win_close(win, true)
          context.state.win = nil
          context.state.au = nil
        end
      end,
    }
  )
end

function context.show()
  if context.state.win and vim.api.nvim_win_is_valid(context.state.win) then
    if context.state.au then
      pcall(vim.api.nvim_del_autocmd, context.state.au)
      context.state.au = nil
    end
    vim.api.nvim_set_current_win(context.state.win)
    return
  end

  local has_parser, parser = pcall(vim.treesitter.get_parser, 0)
  if not has_parser or not parser then
    vim.notify("No treesitter parser found.", vim.log.levels.WARN)
    return
  end

  local ft = vim.bo.filetype
  local allow_list = context.targets[ft] or context.targets.default

  local node = vim.treesitter.get_node()
  local context_nodes = {}

  local last_line = nil
  while node do
    local type = node:type()
    if vim.tbl_contains(allow_list, type) then
      local row = node:range()
      if last_line == nil or row ~= last_line then
        last_line = row
        table.insert(context_nodes, 1, { node = node, row = row, type = type })
      end
    end
    node = node:parent()
  end

  if #context_nodes == 0 then
    vim.notify("No context found.", vim.log.levels.INFO)
    return
  end

  local content = render_window(context_nodes)
  open_window(content, ft)
end

--- }}}

-- ==========================================
-- Plugins {{{
-- ==========================================
vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/Bilal2453/luvit-meta" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/mfussenegger/nvim-lint" },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
  },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/nvim-mini/mini.operators" },
  { src = "https://github.com/nvim-mini/mini.surround" },
  { src = "https://github.com/nvim-mini/mini.ai" },
  { src = "https://github.com/nvim-mini/mini.extra" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/folke/ts-comments.nvim" },
  { src = "https://github.com/Wansmer/treesj" },
  { src = "https://github.com/gbprod/nord.nvim" },
  { src = "https://github.com/aileot/ex-colors.nvim" },
})

vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nvim.difftool")

require("snacks").setup({
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
    folds = { open = true, git_hl = true },
    git = { patterns = { "GitSign" } },
    refresh = 50,
  },
  bigfile = {
    enabled = true,
    setup = function(_)
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
  words = { enabled = true },
  dashboard = { enabled = false },
  dim = { enabled = false },
  image = { enabled = false },
  indent = { enabled = false },
  input = { enabled = false },
  notifier = { enabled = false },
  profiler = { enabled = false },
  quickfile = { enabled = false },
  scope = { enabled = false },
  scroll = { enabled = false },
  zen = { enabled = false },
})

require("nvim-treesitter").setup({
  ensure_installed = {},
  ignore_install = {},
  modules = {},
  auto_install = true,
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-n>",
      node_incremental = "<c-n>",
      node_decremental = "<c-p>",
      scope_incremental = false,
    },
  },
  indent = {
    enable = false,
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Around a function" },
        ["if"] = { query = "@function.inner", desc = "Inside a function" },
        ["ac"] = { query = "@class.outer", desc = "Around a class" },
        ["ic"] = { query = "@class.inner", desc = "Inside a class" },
        ["al"] = { query = "@loop.outer", desc = "Around a loop" },
        ["il"] = { query = "@loop.inner", desc = "Inside a loop" },
      },
    },
    move = {
      enable = true,
      set_jumps = true,
    },
  },
})
require("oil").setup({
  win_options = {
    signcolumn = "yes:2",
    statuscolumn = "",
  },
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-h>"] = {},
    ["<C-j>"] = {},
    ["<C-k>"] = {},
    ["<C-l>"] = {},
    ["<C-s>"] = {},
    ["<localleader>s"] = { "actions.select", opts = { vertical = true } },
    ["<localleader>h"] = { "actions.select", opts = { horizontal = true } },
    ["<localleader><tab>"] = { "actions.select", opts = { tab = true } },
    ["<localleader>p"] = "actions.preview",
    ["<localleader>q"] = { "actions.close", mode = "n" },
    ["<localleader>r"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
    ["Z"] = { "actions.close", mode = "n", nowait = true },

    ["<localleader>o"] = {
      desc = "Go to specific path",
      callback = function()
        local cwd = require("oil").get_current_dir()
        vim.ui.input({
          prompt = "Go to path: ",
          default = cwd,
          completion = "dir",
        }, function(input)
          if input then
            require("oil").open(input)
          end
        end)
      end,
    },
    ["<localleader>y"] = {
      desc = "Copy filepath to system clipboard",
      callback = function()
        require("oil.actions").copy_entry_path.callback()
        vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
        print("Path yanked to clipboard!")
      end,
    },
    ["<localleader>."] = {
      desc = "Change cwd to current directory",
      callback = function()
        require("oil").open_float(".")
        vim.cmd("tcd " .. require("oil").get_current_dir())
        print("CWD changed to: " .. require("oil").get_current_dir())
      end,
    },
  },
})
require("gitsigns").setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
  },
  signs_staged = {
    add = { text = "│" },
    change = { text = "│" },
  },
  worktrees = {
    {
      toplevel = vim.env.HOME,
      gitdir = vim.env.HOME .. "/.local/share/yadm/repo.git",
    },
  },
  sign_priority = 7,
  trouble = false,
  current_line_blame = false,
  attach_to_untracked = false,
  update_debounce = 200,

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Git Blame
    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame line" })
    map("n", "<leader>gB", function() gs.blame() end, { buffer = bufnr, desc = "Blame buffer" })

    -- Hunk
    map("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
    map("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
    map("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, { buffer = bufnr, desc = "Next Hunk" })

    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, { buffer = bufnr, desc = "Previous Hunk" })
    map("n", "]H", function() gs.nav_hunk("last") end, { buffer = bufnr, desc = "Last hunk" })
    map("n", "[H", function() gs.nav_hunk("first") end, { buffer = bufnr, desc = "First hunk" })
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr })
    map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr })
  end,
})
require("conform").setup({
  default_format_opts = {
    timeout_ms = 3000,
    async = true,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    ["bash"] = { "shfmt", lsp_format = "fallback" },
    ["cmake"] = { "cmake_format", lsp_format = "fallback" },
    ["javascript"] = { "prettier", lsp_format = "fallback" },
    ["lua"] = { "stylua", lsp_format = "fallback" },
    ["markdown"] = { "prettier", "markdownlint", "markdown-toc", lsp_format = "fallback" },
    ["markdown.mdx"] = { "prettier", "markdownlint", "markdown-toc" },
    ["mysql"] = { "sqlfluff", lsp_format = "fallback" },
    ["python"] = { "black" },
    ["sh"] = { "shfmt", lsp_format = "fallback" },
    ["sql"] = { "sqlfluff", lsp_format = "fallback" },
    ["typescript"] = { "prettier", lsp_format = "fallback" },
    ["typst"] = { "typstyle", lsp_format = "fallback" },
    ["yaml"] = { "yamlfmt", lsp_format = "fallback" },
  },
  formatters = {
    ["markdown-toc"] = {
      condition = function(_, ctx)
        for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
          if line:find("<!%-%- toc %-%->") then
            return true
          end
        end
        return false
      end,
    },
    ["markdownlint-cli2"] = {
      condition = function(_, ctx)
        local diag = vim.tbl_filter(function(d) return d.source == "markdownlint" end, vim.diagnostic.get(ctx.buf))
        return #diag > 0
      end,
    },
    ["sqlfluff"] = {
      args = { "format", "--dialect=ansi", "-" },
    },
    injected = { options = { ignore_errors = true } },
  },
})
require("lint").linters_by_ft = {
  ["bash"] = { "shellcheck" },
  ["cmake"] = { "cmakelint" },
  ["dockerfile"] = { "hadolint" },
  ["make"] = { "checkmake" },
  ["markdown"] = { "markdownlint" },
  ["sh"] = { "shellcheck" },
  ["zsh"] = { "zsh" },
}
require("mini.extra").setup()
local extra = require("mini.extra")

require("mini.operators").setup({
  exchange = { prefix = "x", reindent_linewise = true },
  replace = { prefix = "s", reindent_linewise = true },
  evaluate = { prefix = "", func = nil },
  multiply = { prefix = "", func = nil },
  sort = { prefix = "", func = nil },
})

require("mini.surround").setup({
  mappings = {
    add = "gs",
    delete = "ds",
    replace = "cs",
    find = "",
    find_left = "",
    highlight = "",
    update_n_lines = "",
  },
  custom_surround = nil,
  n_lines = 20,
})
local ai = require("mini.ai")

require("mini.ai").setup({
  mappings = {
    around = "a",
    inside = "i",

    around_next = "an",
    inside_next = "in",
    around_last = "al",
    inside_last = "il",

    goto_left = "",
    goto_right = "",
  },
  search_method = "cover_or_nearest",
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    i = extra.gen_ai_spec.indent(),
    B = extra.gen_ai_spec.buffer(),
    L = extra.gen_ai_spec.line(),
    u = { "%a+://[%w_%.%?%.:/%+=&#-]+" },
    p = { "%.?%.?/[%w_%.%-%/]+" },
  },
})
require("nvim-autopairs").setup({
  map_bs = true,
  map_c_h = true,
  check_ts = true,
  map_c_w = true,
  map_cr = true,
  enable_check_bracket_line = true,
  ignored_next_char = "[%w%.]",
  disable_filetype = {
    "TelescopePrompt",
    "spectre_panel",
  },
  fast_wrap = {
    map = "<m-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = [=[[%'%"%>%]%)%}%,]]=],
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    manual_position = true,
    highlight = "Search",
    highlight_grey = "Comment",
  },
})
require("nvim-ts-autotag").setup({
  opts = { enable_rename = true, enable_close = true, enable_close_on_slash = true },
})
require("ts-comments").setup({ lang = { cuda = "// %s" } })
require("treesj").setup({ use_default_keymaps = false, max_join_length = 0xffffffff })
require("lazydev").setup({
  { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  { path = "snacks.nvim", words = { "Snacks" } },
})
require("ex-colors").setup()
require("nord").setup({
  transparent = false,
  terminal_colors = true,
  diff = { mode = "fg" },
  borders = true,
  search = { theme = "vscode" },
  errors = { mode = "none" },
  cache = false,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { italic = true },
    variables = {},
  },
})

--- }}}

-- ==========================================
-- Lsp {{{
-- ==========================================

vim.lsp.config("basedpyright", {
  filetypes = { "python" },
  single_file_support = true,
  settings = {
    basedpyright = {
      typeCheckingMode = "basic",
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.config("clangd", {
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--clang-tidy-checks=performance-*,bugprone-*",
    "--all-scopes-completion",
    "--completion-style=bundled",
    "--header-insertion=iwyu",
    "-j=8",
    "--pch-storage=memory",
  },
})

vim.lsp.config("lua_ls", {
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          continuation_indent_size = "2",
        },
      },
      hint = {
        enable = true,
        setType = true,
      },
    },
  },
})

vim.lsp.config("sourcekit", {
  filetypes = { "swift", "objective-c" },
  single_file_support = true,
})

vim.lsp.config("textlab", {
  settings = {
    bibtexFormatter = "texlab",
    chktex = {
      onEdit = true,
      onOpenAndSave = true,
    },
    diagnosticsDelay = 300,
    formatterLineLength = 80,
    latexFormatter = "texlab",
    latexindent = {
      modifyLineBreaks = true,
    },
  },
})

vim.lsp.config("tinymist", {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  single_file_support = true,
})

vim.lsp.enable({
  "basedpyright",
  "bashls",
  "clangd",
  "eslint",
  "jdtls",
  "jsonls",
  "lua_ls",
  "neocmake",
  "sourcekit",
  "texlab",
  "tinymist",
  "vimls",
  "yamlls",
})
-- }}}

-- ==========================================
-- Customize UI {{{
-- ==========================================
_G.custom_foldtext = function()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local icon = "󰇘"
  local ok, ts_text = pcall(vim.treesitter.foldtext)
  if ok and type(ts_text) == "table" then
    table.insert(ts_text, { "  " .. icon .. "  " .. line_count .. " lines ", "Comment" })
    return ts_text
  end

  return { { line .. "  " .. icon .. "  " .. line_count .. " lines ", "Comment" } }
end

_G.custom_statusline = function()
  local file_str = [[%f%m %r %h]]
  local diag_str = [[%{%v:lua.vim.diagnostic.status()%}]]
  -- LSP Clients
  local lsp_str = ""
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if next(clients) then
    local names = {}
    for _, c in ipairs(clients) do
      table.insert(names, c.name)
    end
    lsp_str = string.format("%s%%*", table.concat(names, ","))
  end

  -- Exception-based Encoding & Format
  local enc_err = ""
  local f_enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
  local f_fmt = vim.bo.fileformat
  if f_enc ~= "utf-8" or f_fmt ~= "unix" then
    enc_err = string.format(" %%#DiagnosticError#%s[%s]%%* ", f_enc:upper(), f_fmt:upper())
  end

  -- Position & Percentage
  local pos_str = [[%l,%c%5.5p%%]]

  return string.format("%s  %%= %s %s %s %%y  %s", file_str, diag_str, enc_err, lsp_str, pos_str)
end
--- }}}

-- ==========================================
-- Options {{{
-- ==========================================

opt.autocomplete = true
opt.autoindent = true
opt.autoread = true
opt.backspace = { "indent", "eol", "start" }
opt.belloff = "all"
opt.cdhome = true
opt.cindent = true
opt.cinoptions = "g0,(0,l1,n-2"
opt.cmdheight = 1
opt.complete = ".,b"
opt.completeopt = "fuzzy,menuone,noselect,popup"
opt.conceallevel = 0
opt.confirm = true
opt.cursorline = true
opt.cursorlineopt = "number,line"
opt.diffopt = {
  internal = true,
  filler = true,
  closeoff = true,
  linematch = 60,
  context = 3,
  algorithm = "histogram",
}
opt.expandtab = true
opt.fillchars = {
  vert = "│",
  eob = " ",
  diff = "╱",
  msgsep = "‾",
  fold = "⠀",
  foldopen = "▼",
  foldsep = " ",
  foldclose = "▶",
}
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 99
opt.foldmethod = "expr"
vim.opt.foldtext = "v:lua.custom_foldtext()"
opt.grepprg = "rg"
opt.hidden = true
opt.history = 2000
opt.ignorecase = true
opt.incsearch = true
opt.jumpoptions = "stack,view"
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.listchars = {
  tab = "▸ ",
  trail = "•",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
}
opt.mouse = ""
opt.nrformats = { "alpha", "bin", "octal", "hex" }
opt.number = true
opt.pumheight = 15
opt.pummaxwidth = 80
opt.pumwidth = 15
opt.relativenumber = true
opt.scrollback = 2000
opt.scrolloff = 8
opt.sessionoptions = {
  "buffers",
  "curdir",
  "folds",
  "globals",
  "help",
  "winsize",
  "skiprtp",
  "tabpages",
  "winpos",
}
opt.shiftwidth = 4
opt.showcmd = false
opt.showcmdloc = "statusline"
opt.sidescrolloff = 16
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.smoothscroll = true
opt.softtabstop = -1
opt.splitbelow = true
opt.splitright = false
-- opt.statusline = "%f%m%r%h  %= %{%v:lua.vim.diagnostic.status()%} %y %l,%c%8.8p%%"
opt.statusline = "%!v:lua.custom_statusline()"
opt.swapfile = false
opt.syntax = "on"
opt.tabstop = 4
opt.ttimeoutlen = 0
opt.undofile = true
opt.updatetime = 500
opt.virtualedit = { "block", "onemore" }
opt.whichwrap = vim.o.whichwrap .. "<,>,h,l"
opt.wildmenu = true
opt.winbar = "%f"
opt.winborder = "rounded"
opt.wrap = false

g.html_indent_autotags = "html,head,body"

g.mapleader = " "
g.maplocalleader = "\\"

vim.fn.sign_define("CodeActionSign", { text = "⬥", texthl = "LspCodeAction" })

vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = { " ", " ", " ", " " },
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    source = true,
  },
})

-- }}}

-- ==========================================
-- Keymaps {{{
-- ==========================================

-- ==========================================
-- Core Motions & Edits
-- ==========================================
-- Smooth wrapped line movement
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up" })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down" })

-- Movement in Insert/Command mode
map({ "i", "c" }, "<m-h>", "<left>", { desc = "Left" })
map({ "i", "c" }, "<m-j>", "<down>", { desc = "Down" })
map({ "i", "c" }, "<m-k>", "<up>", { desc = "Up" })
map({ "i", "c" }, "<m-l>", "<right>", { desc = "Right" })
map({ "i", "c", "t" }, "<c-d>", "<DEL>", { desc = "Delete" })

-- Clear search highlights
map("n", "<esc>", ":nohlsearch<cr><esc>", { desc = "Clear search highlight" })

-- Repeat macros and commands
map("n", "U", "<cmd>@:<cr>", { desc = "Repeat last command" })
map("x", ".", ":norm .<cr>", { desc = "Repeat last command" })
map("x", "@", ":norm @q<cr>", { desc = "Repeat last macro" })

-- Undo breakpoints in Insert mode
map("i", ",", ",<c-g>u")
map("i", ";", ";<c-g>u")
map("i", ".", ".<c-g>u")

-- Quick comments (below/above)
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment above" })

-- Split & Join
map("n", "g[", function() require("treesj").split() end, { desc = "Split block" })
map("n", "g]", function() require("treesj").join() end, { desc = "Join block" })
map("n", "g{", function() require("treesj").split({ split = { recursive = true } }) end, { desc = "Split recursively" })

map({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "x" }, "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
map({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })
map("n", "S", "s$", { remap = true, desc = "Substitute EOL" })
map("n", "X", "x$", { remap = true, desc = "Exchange EOL" })
map("x", "S", "Vs", { remap = true, desc = "Substitute selected lines" })
map("x", "X", "Vx", { remap = true, desc = "Exchange selected lines" })
map("n", "<leader>s", '"+s', { remap = true, desc = "Substitute with sys clipboard" })
map("n", "<leader>ss", '"+ss', { remap = true, desc = "Substitute line with sys clipboard" })
map("n", "<leader>S", '"+s$', { remap = true, desc = "Substitute EOL with sys clipboard" })
map("x", "<leader>s", '"+s', { remap = true, desc = "Substitute visual with sys clipboard" })
map("x", "<leader>S", 'V"+s', { remap = true, desc = "Substitute selected lines with sys clip" })

-- ==========================================
-- Window & Buffer Management
-- ==========================================
-- Window navigation and control
map("n", "<c-h>", "<c-w>h", { desc = "Move to window left" })
map("n", "<c-j>", "<c-w>j", { desc = "Move to window below" })
map("n", "<c-k>", "<c-w>k", { desc = "Move to window above" })
map("n", "<c-l>", "<c-w>l", { desc = "Move to window right" })
map("n", "<leader>wd", "<c-w>c", { desc = "Close current window" })
map("n", "<leader>wa", "<c-w>^", { desc = "Alternate window" })
map("n", "<leader>wx", "<c-w>p", { desc = "Previous window" })
map("n", "<leader>wv", "<c-w>v", { desc = "Vertical split window" })
map("n", "<leader>ws", "<c-w>s", { desc = "Horizantal split window" })
map("n", "<leader>wo", "<c-w>o", { desc = "Close all other windows" })

-- Window resizing (via custom utils)
local function window_resize_trigger()
  local text = "  Resize Mode:  h/l/k/j or < > + -  (Any other key to exit)  "
  vim.api.nvim_echo({ { text, "CursorLine" } }, false, {})

  while true do
    local char = vim.fn.getchar()
    if char == 27 then
      break
    end

    local key = vim.fn.nr2char(char)
    local cmd = nil
    local step = 2

    if key == ">" or key == "." then
      cmd = "vertical resize +" .. step
    elseif key == "<" or key == "," then
      cmd = "vertical resize -" .. step
    elseif key == "+" or key == "=" then
      cmd = "resize +" .. step
    elseif key == "-" or key == "_" then
      cmd = "resize -" .. step
    else
      vim.api.nvim_echo({ { "", "None" } }, false, {})
      vim.cmd("redraw")
      break
    end

    if cmd then
      pcall(vim.cmd, cmd)
      vim.cmd("redraw")
      vim.api.nvim_echo({ { text, "CursorLine" } }, false, {})
    end
  end
end
map("n", "<c-w>>", function()
  vim.cmd("vertical resize +2")
  window_resize_trigger()
end, { desc = "Increase window width" })
map("n", "<c-w><", function()
  vim.cmd("vertical resize -2")
  window_resize_trigger()
end, { desc = "Decrease window width" })
map("n", "<c-w>+", function()
  vim.cmd("resize +2")
  window_resize_trigger()
end, { desc = "Increase window height" })
map("n", "<c-w>-", function()
  vim.cmd("resize -2")
  window_resize_trigger()
end, { desc = "Decrease window height" })

-- Window swapping
local function swap_with_window(direction)
  local current_win = vim.fn.winnr()
  local current_buf = vim.fn.bufnr("%")

  vim.cmd("wincmd " .. direction)

  if current_win ~= vim.fn.winnr() then
    local target_buf = vim.fn.bufnr("%")
    local target_ft = vim.bo[target_buf].filetype

    local block_ft = {
      "aerial",
      "codecompanion",
      "edgy",
      "help",
      "neo-tree",
      "neominimap",
      "qf",
      "quickfix",
      "toggleterm",
      "undotree",
    }

    if vim.tbl_contains(block_ft, target_ft) then
      vim.notify("Cannot swap with file type: " .. target_ft, vim.log.levels.WARN)
      vim.cmd("wincmd p")
      return
    end

    vim.api.nvim_win_set_buf(0, current_buf)
    vim.cmd("wincmd p")
    vim.api.nvim_win_set_buf(0, target_buf)
  else
    vim.notify("No window to swap with in that direction.", vim.log.levels.WARN)
  end
end
map("n", "<leader>bh", function() swap_with_window("h") end, { desc = "Swap with left window" })
map("n", "<leader>bl", function() swap_with_window("l") end, { desc = "Swap with right window" })
map("n", "<leader>bj", function() swap_with_window("j") end, { desc = "Swap with below window" })
map("n", "<leader>bk", function() swap_with_window("k") end, { desc = "Swap with above window" })

-- Buffer navigation
map("n", "<leader>ba", "<c-^>", { desc = "Alternate buffer" })
map("n", "<tab>", "<c-^>", { desc = "Alternate buffer" })

-- ==========================================
-- Tabpages Management
-- ==========================================
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close current tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First tab" })
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

map("n", "<leader><tab>c", function()
  vim.ui.input({ prompt = "Enter tab number to close: " }, function(input)
    if tonumber(input) then
      vim.cmd("tabclose " .. input)
    else
      print("Invalid tab number")
    end
  end)
end, { desc = "Close a tab" })

map("n", "<leader><tab>p", function()
  vim.ui.input({ prompt = "Enter tab number to pick: " }, function(input)
    if tonumber(input) then
      vim.cmd("tabn " .. input)
    else
      print("Invalid tab number")
    end
  end)
end, { desc = "Pick a tab" })

-- ==========================================
-- Jumps
-- ==========================================
local function diagnostic_goto(count, severity)
  return function()
    vim.diagnostic.jump({
      count = count,
      severity = severity and vim.diagnostic.severity[severity] or nil,
    })
  end
end
map("n", "]e", diagnostic_goto(1, "ERROR"), { desc = "Next error" })
map("n", "[e", diagnostic_goto(-1, "ERROR"), { desc = "Prev error" })
map("n", "]w", diagnostic_goto(1, "WARN"), { desc = "Next warning" })
map("n", "[w", diagnostic_goto(-1, "WARN"), { desc = "Prev warning" })
map("n", "]j", "<c-i>", { desc = "Next jump" })
map("n", "[j", "<c-o>", { desc = "Previous jump" })
map("n", "]u", "g+", { desc = "Next undo" })
map("n", "[u", "g-", { desc = "Previous undo" })

-- ==========================================
-- Diagnostic
-- ==========================================
map("n", "<leader>xq", vim.diagnostic.setqflist, { desc = "Quickfix list" })
map("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Location list" })
map("n", "<leader>xc", vim.diagnostic.open_float, { desc = "Current line diag" })

-- ==========================================
-- Code & LSP Operations
-- ==========================================
map({ "n", "x" }, "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "x" }, "<leader>cl", vim.lsp.codelens.run, { desc = "Code lens" })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map({ "n", "x" }, "<leader>ch", vim.lsp.buf.hover, { desc = "Hover" })
map({ "n", "x" }, "K", vim.lsp.buf.hover, { desc = "Hover" })

-- Workspace management
map("n", "<leader>Wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace" })
map("n", "<leader>Wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace" })
map(
  "n",
  "<leader>Wl",
  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
  { desc = "List workspace" }
)

-- ==========================================
-- Git & Diff
-- ==========================================
map({ "n", "x" }, "<leader>[[", "<cmd>diffget<cr>", { desc = "Get from other" })
map({ "n", "x" }, "<leader>]]", "<cmd>diffput<cr>", { desc = "Put to other" })
map({ "n", "x" }, "<leader>[l", "<cmd>diffget LOCAL<cr>", { desc = "Get from LOCAL" })
map({ "n", "x" }, "<leader>[b", "<cmd>diffget BASE<cr>", { desc = "Get from BASE" })
map({ "n", "x" }, "<leader>[r", "<cmd>diffget REMOTE<cr>", { desc = "Get from REMOTE" })

-- Lua loop for diff targets (Buffers 0-9)
for i = 0, 9 do
  map({ "n", "x" }, "<leader>[" .. i, "<cmd>diffget " .. i .. "<cr>", { desc = "Get from buffer " .. i })
  map({ "n", "x" }, "<leader>]" .. i, "<cmd>diffput " .. i .. "<cr>", { desc = "Put to buffer " .. i })
end

-- ==========================================
-- Text Objects & Visual Search
-- ==========================================
map("x", "g/", "<esc>/\\%V", { desc = "Search inside visual selection", silent = false })
map(
  "x",
  "gV",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Select changed text" }
)

-- ==========================================
-- Project & Misc (Session, Files, Whitespace)
-- ==========================================
map("n", "<leader>qs", function() session_manager.save() end, { desc = "Save session" })
map("n", "<leader>ql", function() session_manager.load_current() end, { desc = "Load session" })
map("n", "<leader>q/", function() session_manager.select() end, { desc = "Select session" })

map("n", "<leader>fd", "<cmd>DeleteFile<cr>", { desc = "Delete file" })
map("n", "<leader>uu", function() require("undotree").open() end, { desc = "Toggle undo tree" })
map("n", "<leader>r", function() context.show() end, { desc = "Show context" })

map({ "n", "x" }, "<leader><space>t", function()
  local current_view = vim.fn.winsaveview()
  vim.cmd("keeppatterns %s/\\s\\+$//e")
  vim.fn.winrestview(current_view)
end, { desc = "Trim trailing whitespace" })

-- ==========================================
-- Auto completion
-- ==========================================
map(
  "i",
  "<Tab>",
  function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>" end,
  { expr = true, desc = "Next Autocomplete Item" }
)

map(
  "i",
  "<S-Tab>",
  function() return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>" end,
  { expr = true, desc = "Prev Autocomplete Item" }
)

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

Snacks.toggle({
  name = "autosave session",
  get = function() return session_manager.auto_save_enabled end,
  set = function(state) session_manager.auto_save_enabled = state end,
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

map("n", "]r", function() Snacks.words.jump(vim.v.count1, true) end, { desc = "Next reference" })
map("n", "[r", function() Snacks.words.jump(-vim.v.count1, true) end, { desc = "Prev reference" })

map("n", "Z", "<cmd>Oil<cr>", { desc = "Open oil", nowait = true })
map("n", "<leader>fo", "<cmd>Oil<cr>", { desc = "Open oil" })
map("n", "<leader>f.", "<cmd>Oil .<cr>", { desc = "Open oil at ." })

map("n", "<leader>cf", function() require("conform").format({ async = true }) end, { desc = "Code format" })

map("x", "<leader>cf", function()
  local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
  require("conform").format({
    range = {
      ["start"] = { start_row, 0 },
      ["end"] = { end_row, 0 },
    },
    async = true,
  })
end, { desc = "Code format" })

map(
  "n",
  "<leader>cF",
  function() require("conform").format({ formatters = { "injected" }, async = true }) end,
  { desc = "Format injected langs" }
)

map("x", "<leader>cF", function()
  local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
  require("conform").format({
    range = {
      ["start"] = { start_row, 0 },
      ["end"] = { end_row, 0 },
    },
    async = true,
    formatters = { "injected" },
  })
end, { desc = "Format injected langs" })

-- }}}

-- ==========================================
-- Auto Commands  {{{
-- ==========================================
--
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  group = vim.api.nvim_create_augroup("DynamicIndentGuide", { clear = true }),
  callback = function()
    local sw = vim.bo.shiftwidth
    if sw == 0 then
      sw = vim.bo.tabstop
    end

    if sw > 1 then
      -- If sw=4, it generates "│   "
      -- If sw=2, it generates "│ "
      vim.opt_local.listchars:append({ leadmultispace = "│" .. string.rep(" ", sw - 1) })
    else
      -- Disable for sw=1 to prevent UI glitches
      vim.opt_local.listchars:append({ leadmultispace = "" })
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("Force qf to bottom", { clear = true }),
  pattern = "qf",
  callback = function() vim.cmd("wincmd J") end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("checktime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_location", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("man_unlisted", { clear = true }),
  pattern = { "man" },
  callback = function(event) vim.bo[event.buf].buflisted = false end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- create cc according to filetype
local cc_filetypes = {
  c = "101",
  cpp = "101",
  java = "101",
  javascript = "101",
  javascriptreact = "101",
  kotlin = "101",
  lua = "101",
  typescript = "101",
  typescriptreact = "101",
  rust = "101",
  haskell = "101",
  swift = "101",
  markdown = "81",
}
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("colorcolumn", { clear = true }),
  callback = function(event)
    local filetype = event.match
    if cc_filetypes[filetype] and vim.bo.buftype ~= "nofile" then
      vim.wo.colorcolumn = cc_filetypes[filetype]
    else
      vim.wo.colorcolumn = ""
    end
  end,
})

local wrap_filetypes = {
  "Avante",
  "AvanteInput",
  "bigfile",
  "codecompanion",
  "latex",
  "markdown",
  "noice",
  "snacks_notif_history",
  "text",
  "typst",
}
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("wrap", { clear = true }),
  callback = function(event)
    local filetype = event.match
    if vim.tbl_contains(wrap_filetypes, filetype) then
      vim.wo.wrap = true
      vim.wo.breakindent = true
    else
      vim.wo.wrap = false
      vim.wo.breakindent = false
    end
  end,
})

vim.api.nvim_create_augroup("ToggleLineNumbers", { clear = true })
vim.api.nvim_create_autocmd("CmdlineEnter", {
  group = "ToggleLineNumbers",
  pattern = "*",
  callback = function() vim.wo.relativenumber = false end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = "ToggleLineNumbers",
  pattern = "*",
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = true
    end
  end,
})

local function set_diff_keymap()
  map({ "n", "x" }, "<localleader>dg", "<cmd>diffget<cr>", { desc = "Diff: Get from other" })
  map({ "n", "x" }, "<localleader>dp", "<cmd>diffput<cr>", { desc = "Diff: Put from other" })
  map({ "n", "x" }, "<localleader>dl", "<cmd>diffget LO<cr>", { desc = "Diff: Get from LOCAL" })
  map({ "n", "x" }, "<localleader>db", "<cmd>diffget BA<cr>", { desc = "Diff: Get from BASE" })
  map({ "n", "x" }, "<localleader>dr", "<cmd>diffget RE<cr>", { desc = "Diff: Get from REMOTE" })
end

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  group = vim.api.nvim_create_augroup("diff", { clear = true }),
  callback = function()
    vim.notify("Diff mode enabled", vim.log.levels.ERROR, { title = "Diff" })
    if not vim.wo.diff then
      return
    end
    set_diff_keymap()
  end,
})

local diff_status_group = vim.api.nvim_create_augroup("diff_status", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  group = diff_status_group,
  callback = function(ctx)
    local buf = ctx.buf
    local is_diff_mode = vim.v.option_new
    if is_diff_mode then
      local diag_enabled = vim.diagnostic.is_enabled({ bufnr = buf })
      vim.b[buf].saved_diag_status = diag_enabled
      vim.b[buf].saved_ts_status = vim.b.ts_highlight

      if diag_enabled then
        vim.diagnostic.enable(false, { bufnr = buf })
      end
      if vim.b.ts_highlight then
        vim.treesitter.stop(buf)
      end
    else
      if vim.b[buf].saved_diag_status == true then
        vim.diagnostic.enable(true, { bufnr = buf })
      end
      if vim.b[buf].saved_ts_status == true then
        vim.treesitter.start(buf)
      end

      vim.b[buf].saved_diag_status = nil
      vim.b[buf].saved_ts_status = nil
    end
  end,
})
vim.api.nvim_create_autocmd("VimEnter", {
  group = diff_status_group,
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.wo[win].diff then
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.b[buf].saved_diag_status == nil then
          local diag_enabled = vim.b[buf].ts_highlight
          vim.b[buf].saved_diag_status = diag_enabled
          if diag_enabled then
            vim.diagnostic.enable(false, { bufnr = buf })
          end
        end
        if vim.b[buf].saved_ts_status == nil then
          local ts_enabled = vim.b[buf].ts_highlight
          vim.b[buf].saved_ts_status = ts_enabled
          if ts_enabled then
            vim.treesitter.stop(buf)
          end
        end
      end
    end
  end,
})
local function should_detect_indentation(bufnr)
  bufnr = bufnr or 0
  local bt = vim.bo[bufnr].buftype
  local ft = vim.bo[bufnr].filetype

  if bt ~= "" and bt ~= "acwrite" then
    return false
  end

  local ft_blocklist = {
    "neo-tree",
    "aerial",
    "lazy",
    "mason",
    "snacks_dashboard",
    "qf",
    "help",
  }
  if vim.tbl_contains(ft_blocklist, ft) then
    return false
  end

  return true
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("detect_indentation", { clear = true }),
  callback = function(args)
    if should_detect_indentation(args.buf) then
      detect_indentation(args.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("auto_save", { clear = true }),
  callback = function()
    local session = session_manager
    if not session.auto_save_enabled then
      return
    end

    local has_real_buffer = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.bo[buf].filetype ~= "" then
        has_real_buffer = true
        break
      end
    end

    if has_real_buffer then
      session.save()
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("DisableAutocompleteInPicker", { clear = true }),
  pattern = "snacks_picker_input",
  callback = function() vim.opt_local.autocomplete = false end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 }) end,
})

local code_action_group = vim.api.nvim_create_augroup("code_action_sign", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("create_code_action_autocmd", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local clients = vim.lsp.get_clients({
      bufnr = bufnr,
      method = "textDocument/codeAction",
    })
    if #clients == 0 then
      return
    end
    for _, client in pairs(clients) do
      if client.id ~= args.data.client_id then
        return
      end
    end
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = code_action_group,
      callback = function()
        local params = vim.lsp.util.make_range_params(0, "utf-16")
        local lnum = vim.fn.line(".") - 1
        ---@diagnostic disable-next-line: inject-field
        params.context = { diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum }) }

        vim.fn.sign_unplace("LspCodeActionSign", { buffer = bufnr })
        vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, result, ctx, _)
          if err or ctx.bufnr ~= bufnr or not vim.api.nvim_buf_is_loaded(bufnr) then
            return
          end
          if result and not vim.tbl_isempty(result) then
            local success, cursor_pos = pcall(vim.api.nvim_win_get_cursor, 0)
            if success and cursor_pos then
              vim.fn.sign_place(
                0,
                "LspCodeActionSign",
                "CodeActionSign",
                bufnr,
                { lnum = cursor_pos[1], priority = 10 }
              )
            end
          end
        end)
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("remove_code_action_autocmd", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local clients = vim.lsp.get_clients({
      bufnr = bufnr,
      method = "textDocument/codeAction",
    })
    if #clients == 0 then
      return
    end
    for _, client in pairs(clients) do
      if client.id ~= args.data.client_id then
        return
      end
    end
    vim.fn.sign_unplace("LspCodeActionSign", { buffer = bufnr })
    vim.api.nvim_clear_autocmds({
      group = code_action_group,
      buffer = bufnr,
    })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspCompletion", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, {
        autotrigger = true,
        convert = function(item)
          local insert_text = item.label
          if item.textEdit and item.textEdit.newText then
            insert_text = item.textEdit.newText
          elseif item.insertText and item.insertText ~= "" then
            insert_text = item.insertText
          end

          local label = item.label
          local max_width = 20

          if #label > max_width then
            label = vim.fn.strcharpart(label, 0, max_width - 3) .. "..."
          end

          return {
            abbr = label,
            word = insert_text,
            kind = vim.lsp.protocol.CompletionItemKind[item.kind] or "",
            menu = item.detail or "",
            info = item.documentation,
          }
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("CompleteChanged", {
  callback = function()
    vim.schedule(function()
      local info = vim.fn.complete_info({ "selected", "preview_winid" })
      if info.preview_winid and vim.api.nvim_win_is_valid(info.preview_winid) then
        vim.api.nvim_win_set_config(info.preview_winid, { border = "rounded" })
      end
    end)
  end,
})

local function set_popup_border(winid)
  if winid and winid >= 0 and vim.api.nvim_win_is_valid(winid) then
    pcall(vim.api.nvim_win_set_config, winid, { border = "rounded" })
  end
end

if vim.api.nvim__complete_set then
  local orig = vim.api.nvim__complete_set
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.api.nvim__complete_set = function(index, opts)
    local windata = orig(index, opts)
    set_popup_border(windata and windata.winid)
    return windata
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("Oil_start_directory", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.fn.isdirectory(vim.fn.expand("%:p")) == 1 then
      vim.cmd("Oil")
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if not (event and event.data and event.data.actions and event.data.actions[1]) then
      return
    end
    local action = event.data.actions[1]
    if action.type == "move" then
      if _G.Snacks and Snacks.rename then
        Snacks.rename.on_rename_file(action.src_url, action.dest_url)
      end
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = debounce(100, function() require("lint").try_lint() end),
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("start_treesitter", { clear = true }),
  pattern = {
    "bash",
    "c",
    "cmake",
    "css",
    "cpp",
    "diff",
    "haskell",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "luadoc",
    "luap",
    "makefile",
    "markdown",
    "markdown_inline",
    "mysql",
    "ocaml",
    "printf",
    "python",
    "query",
    "regex",
    "rust",
    "sh",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
    "zsh",
  },
  callback = function() vim.treesitter.start() end,
})
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nord",
  group = vim.api.nvim_create_augroup("UserCustomHighlights", { clear = true }),
  callback = function()
    local palette = require("nord.colors").palette
    local highlights = {
      CursorLineNr = { bold = true },
      DapBreakpoint = { fg = palette.aurora.green },
      DapBreakpointCondition = { fg = palette.aurora.green },
      DapBreakpointRejected = { fg = palette.aurora.red },
      DapBreakpointStopped = { fg = palette.aurora.yellow },
      DapLogPoint = { fg = palette.aurora.green },
      DapStoppedLine = { bg = palette.polar_night.brightest },
      DebugPC = { bg = palette.polar_night.brightest },
      ErrorMsg = { link = "Normal" },
      Folded = { fg = palette.frost.artic_water, bg = palette.polar_night.brighter },
      LspCodeAction = { fg = palette.aurora.yellow },
      LspInlayHint = { fg = palette.polar_night.light },
      LspLens = { fg = palette.polar_night.light },
      MarkSignHL = { fg = palette.aurora.green },
      NeominimapMarkIcon = { fg = palette.aurora.green },
      NoiceLspProgressClient = { fg = palette.frost.ice, italic = true },
      NoiceLspProgressTitle = { fg = palette.snow_storm.origin },
      NoiceMini = { bg = palette.polar_night.bright },

      Pmenu = { bg = palette.polar_night.bright, fg = palette.snow_storm.origin },
      PmenuSel = { bg = palette.polar_night.brighter },

      PmenuMatch = { fg = palette.frost.ice, bold = true },
      PmenuMatchSel = { fg = palette.frost.ice, bg = palette.polar_night.brighter, bold = true },

      PmenuKind = { fg = palette.aurora.purple },
      PmenuExtra = { fg = palette.aurora.green },

      PmenuSbar = { bg = palette.polar_night.bright },
      PmenuThumb = { bg = palette.polar_night.light },

      QuickFixLine = { bg = "NONE" },
      TSDefinitionUsage = { bg = palette.polar_night.brightest },
      VertSplit = { fg = palette.polar_night.brighter },
      VirtColumn = { fg = palette.polar_night.brightest },
      VisualNonText = { fg = palette.polar_night.light, bg = palette.polar_night.brighter },
      WarningMsg = { link = "Normal" },
      WinSeparator = { fg = palette.polar_night.brighter },
      WinBar = { bg = palette.polar_night.brighter },
      WinBarNc = { bg = palette.polar_night.bright },
      ["@error"] = {},
    }
    for k, v in pairs(highlights) do
      vim.api.nvim_set_hl(0, k, v)
    end
  end,
})
-- }}}

-- ==========================================
-- Commands  {{{
-- ==========================================

vim.api.nvim_create_user_command("DeleteFile", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    print("No file to delete!")
    return
  end

  local confirm = vim.fn.confirm("Delete file: " .. file .. "?", "&Yes\n&No", 2)
  if confirm ~= 1 then
    print("File deletion aborted.")
    return
  end

  local ok, err = os.remove(file)
  if not ok then
    print("Error deleting file: " .. err)
    return
  end

  Snacks.bufdelete()
  print("Deleted file: " .. file)
end, {})

vim.api.nvim_create_user_command("SetTabLength", function(opts)
  local len = tonumber(opts.args)
  if not len then
    print("Invalid argument. Please provide a number.")
    return
  end
  vim.opt.tabstop = len
  vim.opt.shiftwidth = len
  print("Tab length set to: " .. len)
end, { nargs = 1 })
vim.api.nvim_create_user_command("DetectIndent", function() detect_indentation() end, {})
vim.api.nvim_create_user_command("LoadSession", function() session_manager.load_current() end, {})
vim.api.nvim_create_user_command("SelectSession", function() session_manager.select() end, {})
-- }}}

vim.cmd.colorscheme("nord")
-- vim: set foldmethod=marker:
