local M = {}

local function select_range(start_pos, end_pos)
  -- start_pos, end_pos are { line, col } with 1-based column indices
  vim.fn.setpos("'<", { 0, start_pos[1], start_pos[2], 0 })
  vim.fn.setpos("'>", { 0, end_pos[1], end_pos[2], 0 })
  vim.cmd("normal! gv")
end

M.select_range = select_range

function M.entire_buffer()
  local start_line, start_col = 1, 1
  local end_line = vim.fn.line("$")
  local end_col = vim.fn.col({ end_line, "$" }) -- end of line
  select_range({ start_line, start_col }, { end_line, end_col })
end

-- Only letters and digits are part of the subword token
local function is_subword_char(ch) return ch:match("[A-Za-z0-9]") ~= nil end

-- Compute the subword range (inner) as { row, start_col, end_col } or nil on failure
local function get_subword_range()
  local row, col0 = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  if #line == 0 then
    return nil
  end

  -- Vim columns are 0-based, Lua string indices are 1-based
  local col = col0 + 1
  if col < 1 then
    col = 1
  end
  if col > #line then
    col = #line
  end

  local function char_at(i) return line:sub(i, i) end

  -- If not on a subword char, try to snap to a neighbor
  if not is_subword_char(char_at(col)) then
    if col > 1 and is_subword_char(char_at(col - 1)) then
      col = col - 1
    elseif col < #line and is_subword_char(char_at(col + 1)) then
      col = col + 1
    else
      return nil
    end
  end

  -- Find the whole token (alnum run, used for camelCase splitting)
  local token_start = col
  while token_start > 1 and is_subword_char(char_at(token_start - 1)) do
    token_start = token_start - 1
  end
  local token_end = col
  while token_end < #line and is_subword_char(char_at(token_end + 1)) do
    token_end = token_end + 1
  end

  local token = line:sub(token_start, token_end)
  local n = #token
  if n == 0 then
    return nil
  end

  local local_pos = col - token_start + 1

  -- Build camelCase boundaries inside the token
  local boundaries = { 1 }

  local function is_lower(c) return c:match("%l") ~= nil end

  local function is_upper(c) return c:match("%u") ~= nil end

  for i = 2, n do
    local prev = token:sub(i - 1, i - 1)
    local cur = token:sub(i, i)
    if is_lower(prev) and is_upper(cur) then
      table.insert(boundaries, i)
    end
  end
  table.insert(boundaries, n + 1)

  -- Find segment that contains local_pos
  local seg_start, seg_end = 1, n
  for i = 1, #boundaries - 1 do
    local b_start = boundaries[i]
    local b_end = boundaries[i + 1] - 1
    if local_pos >= b_start and local_pos <= b_end then
      seg_start, seg_end = b_start, b_end
      break
    end
  end

  -- Map back to line coordinates (inclusive end column)
  local start_col = token_start + seg_start - 1
  local end_col = token_start + seg_end - 1

  return row, start_col, end_col
end

function M.subword_inner()
  local row, start_col, end_col = get_subword_range()
  if not row then
    return
  end
  select_range({ row, start_col }, { row, end_col })
end

function M.subword_outer()
  local row, start_col, end_col = get_subword_range()
  if not row then
    return
  end

  local line = vim.api.nvim_get_current_line()
  local line_len = #line

  local s = start_col
  local e = end_col

  -- Extend to include leading '_' or '-' characters
  while s > 1 do
    local ch = line:sub(s - 1, s - 1)
    if ch == "_" or ch == "-" then
      s = s - 1
    else
      break
    end
  end

  -- Extend to include trailing '_' or '-' characters
  while e < line_len do
    local ch = line:sub(e + 1, e + 1)
    if ch == "_" or ch == "-" then
      e = e + 1
    else
      break
    end
  end

  select_range({ row, s }, { row, e })
end

--- Find the first match of pattern whose span covers `col`.
--- @param line string the current line string
--- @param col number 1-based column index.
--- @return number | nil s start column
--- @return number | nil e end column
local function find_match_covering_col(line, col, pattern)
  local init = 1

  while true do
    local s, e = line:find(pattern, init)
    if not s then
      return nil
    end

    if col >= s and col <= e then
      return s, e
    end

    -- Move search start forward to avoid infinite loop on zero-length matches
    init = e + 1
  end
end

local function get_regex_range(pattern)
  local row, col0 = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  if #line == 0 then
    return nil
  end

  local col = col0 + 1
  if col < 1 then
    col = 1
  end
  if col > #line then
    col = #line
  end
  local s, e = find_match_covering_col(line, col, pattern)
  if not s then
    return nil
  end

  return row, s, e
end

function M.url()
  local pattern = "([%a][%w+.-]*)://%S+"
  local row, start_col, end_col = get_regex_range(pattern)
  if not row then
    return
  end
  select_range({ row, start_col }, { row, end_col })
end

function M.filepath()
  local pattern = "([.~]?/?[%w_%-.$/@]+/)[%w_%-.@]+()"
  local row, start_col, end_col = get_regex_range(pattern)
  if not row then
    return
  end
  select_range({ row, start_col }, { row, end_col })
end

return M
