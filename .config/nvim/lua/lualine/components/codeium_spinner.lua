local M = require("lualine.component"):extend()
M.spinner_index = 1

function M:init(options) M.super.init(self, options) end

local spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_symbols_len = 10
function M:update_status()
  local ok, codeium = pcall(require, "codeium.virtual_text")
  if not ok then
    return ""
  end
  local status = codeium.status()
  if status.state == "idle" then
    return "{} "
  elseif status.state == "completions" then
    if self.total == 0 then
      return string.format("{} 0")
    else
      return string.format("{} %d/%d", status.current, status.total)
    end
  elseif status.state == "waiting" then
    self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
    return "{}" .. spinner_symbols[self.spinner_index]
  else
    return ""
  end
end

return M
