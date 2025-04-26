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

local set_git_dir = function()
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
end

set_git_dir()
vim.api.nvim_create_autocmd({ "DirChanged" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("git_dir", { clear = true }),
  callback = set_git_dir,
})
