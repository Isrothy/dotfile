return {
  cmd = { "bash-language-server", "start" },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
    },
  },
  filetypes = { "bash", "sh" },
  root_dir = function(fname)
    return vim.fs.dirname(vim.fs.find(".git", {
      path = fname,
      upward = true,
    })[1])
  end,
  single_file_support = true,
}
