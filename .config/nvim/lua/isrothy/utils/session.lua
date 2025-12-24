local M = {}

local session_dir = vim.fn.stdpath("state") .. "/sessions/"
if vim.fn.isdirectory(session_dir) == 0 then
  vim.fn.mkdir(session_dir, "p")
end

M.auto_save_enabled = true
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp"

local function path_to_name(path) return path:gsub(":", ""):gsub("/", "%%") .. ".vim" end
local function name_to_path(name) return name:gsub("%%", "/"):gsub("%.vim$", "") end
local function get_current_session_path() return session_dir .. path_to_name(vim.fn.getcwd()) end

function M.save()
  if vim.bo.filetype == "alpha" or vim.bo.filetype == "snacks_dashboard" then
    return
  end

  local name = get_current_session_path()
  vim.cmd("mksession! " .. vim.fn.fnameescape(name))
  vim.notify("Session saved for: " .. vim.fn.getcwd(), vim.log.levels.INFO, { title = "Session" })
end

function M.load_current()
  local name = get_current_session_path()
  if vim.fn.filereadable(name) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(name))
    vim.notify("Session loaded.", vim.log.levels.INFO, { title = "Session" })
  else
    vim.notify("No session found for this directory.", vim.log.levels.WARN, { title = "Session" })
  end
end

function M.select()
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
      if M.auto_save_enabled then
        M.save()
      end

      vim.cmd("silent! %bd!")
      vim.cmd("silent! source " .. vim.fn.fnameescape(choice.file))
      vim.notify("Loaded session: " .. choice.label, vim.log.levels.INFO)
    end
  end)
end

function M.enable_autosave()
  M.auto_save_enabled = true
  vim.notify("Auto-Save Session: Enabled", vim.log.levels.INFO, { title = "Session" })
end

function M.disable_autosave()
  M.auto_save_enabled = false
  vim.notify("Auto-Save Session: Disabled", vim.log.levels.INFO, { title = "Session" })
end

return M
