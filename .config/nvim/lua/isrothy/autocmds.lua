local function augroup(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = augroup("terminal_config"),
  callback = function()
    vim.wo.sidescrolloff = 0
    vim.wo.scrolloff = 0
    vim.wo.foldmethod = "manual"
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
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
    vim.keymap.set("n", "q", "<CMD>close<CR>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("Force qf to bottom"),
  pattern = "qf",
  callback = function() vim.cmd("wincmd J") end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
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
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event) vim.bo[event.buf].buflisted = false end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
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
  group = augroup("colorcolumn"),
  callback = function(event)
    local filetype = event.match
    if cc_filetypes[filetype] then
      vim.wo.colorcolumn = cc_filetypes[filetype]
    else
      vim.wo.colorcolumn = ""
    end
  end,
})

local wrap_filetypes = {
  "markdown",
  "latex",
  "text",
  "Avante",
  "AvanteInput",
  "typst",
  "bigfile",
  "noice",
  "snacks_notif_history",
}
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("wrap"),
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

vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
  group = augroup("inlay_hint"),
  callback = function(args)
    local bufnr = args.buf
    local clients = vim.lsp.get_clients({
      bufnr = bufnr,
      method = "textDocument/inlayHint",
    })
    vim.lsp.inlay_hint.enable(#clients ~= 0, { bufnr = bufnr })
  end,
})

vim.fn.sign_define("CodeActionSign", { text = "⬥", texthl = "LspCodeAction" })
local code_action_group = augroup("code_action_sign")
vim.api.nvim_create_augroup("LspCodeActionSignGroup", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("create_code_action_autocmd"),
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
        params.context = { diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum }) }

        vim.fn.sign_unplace("LspCodeActionSign", { buffer = bufnr })
        vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, result, ctx, config)
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
  group = augroup("remove_code_action_autocmd"),
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

local function set_diff_keymap()
  local ok, which_key = pcall(require, "which-key")
  if not ok then
    return
  end
  which_key.add({
    { "<LocalLeader>d", group = "Diff", mode = { "n", "x" } },
    { "<LocalLeader>dg", "<cmd>diffget<CR>", desc = "Diff: Get from other", mode = { "n", "x" } },
    { "<LocalLeader>dp", "<cmd>diffput<CR>", desc = "Diff: Put from other", mode = { "n", "x" } },

    { "<LocalLeader>dl", "<cmd>diffget LO<cr>", desc = "Diff: Get from LOCAL", mode = { "n", "x" } },
    { "<LocalLeader>db", "<cmd>diffget BA<cr>", desc = "Diff: Get from BASE", mode = { "n", "x" } },
    { "<LocalLeader>dr", "<cmd>diffget RE<cr>", desc = "Diff: Get from REMOTE", mode = { "n", "x" } },
  })
end

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  group = augroup("diff"),
  callback = function()
    vim.notify("Diff mode enabled", vim.log.levels.ERROR, { title = "Diff" })
    if not vim.wo.diff then
      return
    end
    set_diff_keymap()
  end,
})

local function is_standard_git_repo(dir)
  local original_git_dir = vim.env.GIT_DIR
  local original_work_tree = vim.env.GIT_WORK_TREE
  vim.env.GIT_DIR = nil
  vim.env.GIT_WORK_TREE = nil

  local cmd = { "git", "-C", dir, "rev-parse", "--is-inside-work-tree" }
  vim.fn.system(cmd)
  local exit_code = vim.v.shell_error

  vim.env.GIT_DIR = original_git_dir
  vim.env.GIT_WORK_TREE = original_work_tree

  return exit_code == 0
end

vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
  pattern = "*",
  group = augroup("git_dir"),
  callback = function()
    local home_dir = vim.fn.expand("~")
    local bare_git_dir = home_dir .. "/.cfg"
    local bare_work_tree = home_dir

    local current_cwd = vim.fn.getcwd()
    if not current_cwd or current_cwd == "" then
      return
    end

    if (not is_standard_git_repo(current_cwd)) and current_cwd:find(home_dir, 1, true) then
      vim.env.GIT_DIR = bare_git_dir
      vim.env.GIT_WORK_TREE = bare_work_tree
    else
      vim.env.GIT_DIR = nil
      vim.env.GIT_WORK_TREE = nil
    end
  end,
})
