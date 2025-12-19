local M = {}

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

function M.detect(bufnr)
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

return M
