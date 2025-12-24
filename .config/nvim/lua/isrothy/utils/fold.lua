local M = {}

local api = vim.api
local ts = vim.treesitter

local function parse_line(linenr)
  local bufnr = api.nvim_get_current_buf()
  local line = api.nvim_buf_get_lines(bufnr, linenr - 1, linenr, false)[1]
  if not line then
    return nil
  end

  local ok, parser = pcall(ts.get_parser, bufnr)
  if not ok or not parser then
    return nil
  end

  local query = ts.query.get(parser:lang(), "highlights")
  if not query then
    return nil
  end

  local tree = parser:parse({ linenr - 1, linenr })[1]
  local root = tree:root()

  local result = {}
  local last_pos = 0

  for id, node, _ in query:iter_captures(root, bufnr, linenr - 1, linenr) do
    local name = query.captures[id]
    local start_row, start_col, end_row, end_col = node:range()

    if start_row == linenr - 1 and end_row == linenr - 1 and start_col >= last_pos then
      if start_col > last_pos then
        table.insert(result, { line:sub(last_pos + 1, start_col), "Folded" })
      end

      local chunk_text = line:sub(start_col + 1, end_col)
      table.insert(result, { chunk_text, "@" .. name })

      last_pos = end_col
    end
  end

  if last_pos < #line then
    table.insert(result, { line:sub(last_pos + 1), "Folded" })
  end

  return result
end

function M.foldtext()
  local fs = vim.v.foldstart
  local fe = vim.v.foldend

  local styled_text = parse_line(fs)

  if not styled_text or #styled_text == 0 then
    local line = api.nvim_buf_get_lines(0, fs - 1, fs, false)[1]
    styled_text = { { line, "Normal" } }
  end

  local fold_lines = fe - fs + 1
  local icon = "󰇘"
  local suffix = string.format("  %s  %d lines ", icon, fold_lines)

  table.insert(styled_text, { suffix, "Comment" })

  return styled_text
end

return M
