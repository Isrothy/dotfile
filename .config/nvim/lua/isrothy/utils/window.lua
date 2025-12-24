local M = {}

local step = 2

function M.trigger()
  local text = "  Resize Mode:  h/l/k/j or < > + -  (Any other key to exit)  "
  vim.api.nvim_echo({ { text, "CursorLine" } }, false, {})

  while true do
    local char = vim.fn.getchar()
    if char == 27 then
      break
    end

    local key = vim.fn.nr2char(char)
    local cmd = nil

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

function M.swap_with_window(direction)
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

return M
