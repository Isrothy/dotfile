local M = {}

local state = {
  win = nil,
  au = nil,
}

---@type table<string, string[]>
local targets = {
  default = {
    "class",
    "function",
    "method",
    "if",
    "for",
    "while",
  },
  lua = {
    "function_declaration",
    "if_statement",
    "for_statement",
    "while_statement",
    "table_constructor",
  },
  c = {
    "function_definition",
    "struct_specifier",
    "enum_specifier",
    "if_statement",
    "for_statement",
    "while_statement",
    "switch_statement",
    "case_statement",
  },
  cpp = {
    "namespace_definition",
    "class_specifier",
    "struct_specifier",
    "function_definition",
    "template_declaration",
    "if_statement",
    "for_statement",
    "while_statement",
    "try_statement",
    "catch_clause",
  },
  python = {
    "class_definition",
    "function_definition",
    "if_statement",
    "for_statement",
    "while_statement",
    "try_statement",
    "with_statement",
  },
  rust = {
    "impl_item",
    "trait_item",
    "function_item",
    "mod_item",
    "if_expression",
    "loop_expression",
    "for_expression",
    "while_expression",
    "match_expression",
    "macro_definition",
  },
}
targets.cuda = targets.cpp

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

  state.win = win

  vim.bo[buf].filetype = filetype

  vim.api.nvim_win_call(win, function() vim.fn.matchadd("Comment", "^\\s*\\d\\+ │") end)

  local close_cmd = "<cmd>close<cr>"
  vim.keymap.set("n", "q", close_cmd, { buffer = buf, nowait = true })
  vim.keymap.set("n", "<Esc>", close_cmd, { buffer = buf, nowait = true })

  state.au = vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter", "BufLeave", "WinScrolled" }, {
    buffer = vim.api.nvim_get_current_buf(),
    once = true,
    callback = function()
      -- If window exists AND we are not currently focused inside it
      if vim.api.nvim_win_is_valid(win) and vim.api.nvim_get_current_win() ~= win then
        vim.api.nvim_win_close(win, true)
        state.win = nil
        state.au = nil
      end
    end,
  })
end

function M.show()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    if state.au then
      pcall(vim.api.nvim_del_autocmd, state.au)
      state.au = nil
    end
    vim.api.nvim_set_current_win(state.win)
    return
  end

  local has_parser, parser = pcall(vim.treesitter.get_parser, 0)
  if not has_parser or not parser then
    vim.notify("No treesitter parser found.", vim.log.levels.WARN)
    return
  end

  local ft = vim.bo.filetype
  local allow_list = targets[ft] or targets.default

  local node = vim.treesitter.get_node()
  local context_nodes = {}

  while node do
    local type = node:type()
    if vim.tbl_contains(allow_list, type) then
      local row = node:range()
      table.insert(context_nodes, 1, { node = node, row = row, type = type })
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

return M
