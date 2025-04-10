HOME = os.getenv("HOME")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

if vim.env.PROF then
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  ---@diagnostic disable-next-line: missing-fields
  require("snacks.profiler").startup({
    startup = {
      event = "VimEnter", -- Stop profiler on this event. Defaults to `VimEnter`
    },
  })
end

require("isrothy.options")
require("isrothy.mappings")
require("isrothy.autocmd")
require("isrothy.fold")
require("isrothy.lazy_plugin")

vim.lsp.enable({
  --   "basedpyright",
  --   "bashls",
  --   "clangd",
  "jsonls",
  --   "lua_ls",
  --   "neocmake",
  --   "sourcekit",
  --   "texlab",
  "tinymist",
  --   "vimls",
  "yamlls",
  --   "eslint",
  --   "harper_ls",
})
