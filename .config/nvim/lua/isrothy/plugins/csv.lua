return {
  {
    "hat0uma/csvview.nvim",
    enabled = false,
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        jump_next_field_end = { "<tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<s-tab>", mode = { "n", "v" } },
        jump_next_row = { "<cr>", mode = { "n", "v" } },
        jump_prev_row = { "<s-cr>", mode = { "n", "v" } },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "csv",
        group = vim.api.nvim_create_augroup("CsvView", { clear = true }),
        callback = function()
          Snacks.toggle({
            name = "csv view",
            get = function() return require("csvview").is_enabled(0) end,
            set = function(state)
              if state then
                require("csvview").enable()
              else
                require("csvview").disable()
              end
            end,
          }):map("<localleader>cc")
        end,
      })
    end,
    cmd = {
      "CsvViewEnable",
      "CsvViewDisable",
      "CsvViewToggle",
    },
  },
}
