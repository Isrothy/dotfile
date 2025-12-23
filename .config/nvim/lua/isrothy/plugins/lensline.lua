return {
  {
    "oribarilan/lensline.nvim",
    branch = "release/2.x",
    cmd = {
      "LenslineEnable",
      "LenslineDisable",
      "LenslineToggleEngine",
      "LenslineShow",
      "LenslineHide",
      "LenslineToggleView",
    },
    event = {
      "LspAttach",
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        group = vim.api.nvim_create_augroup("toggle lensline", { clear = true }),
        callback = function()
          Snacks.toggle({
            name = "lensline",
            get = function() return require("lensline").is_visible() end,
            set = function(state)
              if state then
                require("lensline").show()
              else
                require("lensline").hide()
              end
            end,
          }):map("<leader>cL")
        end,
      })
    end,
    opts = {
      profiles = {
        {
          name = "default",
          style = {
            placement = "inline",
            use_nerdfont = false,
          },
          providers = {
            { name = "usages", enabled = true },
            {
              name = "diagnostics",
              enabled = true,
              min_level = "WARN",
            },
          },
        },
      },
    },
  },
}
