return {
  {
    "rafcamlet/nvim-luapad",
    cmd = {
      "Luapad",
      "LuaRun",
    },
    opts = {
      wipe = false,
      on_init = function() vim.b.is_luapad = true end,
    },
  },
}
