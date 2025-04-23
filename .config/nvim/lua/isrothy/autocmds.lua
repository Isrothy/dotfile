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
}
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("wrap"),
  callback = function(event)
    local filetype = event.match
    if vim.tbl_contains(wrap_filetypes, filetype) then
      vim.wo.wrap = true
    else
      vim.wo.wrap = false
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
vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
  callback = function(args)
    local bufnr = args.buf
    vim.api.nvim_clear_autocmds({ group = code_action_group, buffer = bufnr })
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client:supports_method("textDocument/codeAction", bufnr) then
      return
    end
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = code_action_group,
      callback = function()
        local params = vim.lsp.util.make_range_params(0, "utf-16")
        local lnum = vim.fn.line(".") - 1
        params.context = { diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum }) }

        vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, result, ctx, config)
          if err then
            return
          end

          vim.fn.sign_unplace("lsp_code_action_sign", { buffer = bufnr })

          if result and not vim.tbl_isempty(result) then
            local row = vim.api.nvim_win_get_cursor(0)[1]
            vim.fn.sign_place(0, "lsp_code_action_sign", "CodeActionSign", bufnr, { lnum = row, priority = 10 })
          end
        end)
      end,
    })
  end,
})
