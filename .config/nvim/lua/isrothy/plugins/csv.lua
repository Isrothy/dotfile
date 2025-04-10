return {
  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
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
          }):map("<LOCALLEADER>cc")
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
