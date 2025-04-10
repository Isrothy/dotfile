return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        tools = {},
        server = {
          settings = {
            ["rust-analyzer"] = {},
          },
        },
        dap = {},
      }
    end,
  },
}
