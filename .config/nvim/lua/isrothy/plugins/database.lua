return {
  {
    "tpope/vim-dadbod",
    cmd = "DB",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = "vim-dadbod",
    keys = {
      { "<cr>", "<plug>(DBUI_SelectLine)", desc = "Select line", ft = { "dbui" } },
      { "<localleader>o", "<plug>(DBUI_SelectLine)", desc = "Select line", ft = { "dbui" } },
      { "<localleader>s", "<plug>(DBUI_SelectLineVsplit)", desc = "Select line", ft = { "dbui" } },
      { "<localleader>d", "<plug>(DBUI_DeleteLine)", desc = "Delete line", ft = { "dbui" } },
      { "<localleader>R", "<plug>(DBUI_Redraw)", desc = "Refresh", ft = { "dbui" } },
      { "<localleader>r", "<plug>(DBUI_RenameLine)", desc = "Rename", ft = { "dbui" } },
      { "<localleader>a", "<plug>(DBUI_AddConnection)", desc = "Add connection", ft = { "dbui" } },
      { "<localleader>h", "<plug>(DBUI_ToggleDetails)", desc = "Toggle details", ft = { "dbui" } },
      { "<localleader>q", "<plug>(DBUI_Quit)", desc = "Quit", ft = { "dbui" } },
      { "<localleader>f", "<plug>(DBUI_JumpToForeignKey)", desc = "Jump to foreignkey", ft = { "dbout" } },
      { "<localleader>c", "<plug>(DBUI_YankCellValue)", desc = "Select cell value", ft = { "dbout" } },
      { "<localleader>h", "<plug>(DBUI_YankHeader)", desc = "Yank header", ft = { "dbout" } },
      { "<localleader>u", "<plug>(DBUI_ToggleResultLayout)", desc = "Toggle result layout", ft = { "dbout" } },
    },
    init = function()
      local data_path = vim.fn.stdpath("data")

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true

      vim.g.db_ui_disable_mappings = 1

      vim.g.db_ui_execute_on_save = false

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql", "javascript" },
        callback = function()
          if vim.b.dbui_db_key_name == nil then
            return
          end
          local wk = require("which-key")
          wk.add({
            { "<localleader>d", group = "DBUI" },
            { "<localleader>ds", "<plug>(DBUI_ExecuteQuery)", desc = "Execute query" },
            { "<localleader>dw", "<plug>(DBUI_SaveQuery)", desc = "Save query" },
            { "<localleader>de", "<plug>(DBUI_EditBindParameters)", desc = "Edit bind parameters" },
          })
        end,
      })
    end,
  },
}
