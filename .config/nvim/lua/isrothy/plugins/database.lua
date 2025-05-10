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
      { "<CR>", "<PLUG>(DBUI_SelectLine)", desc = "Select line", ft = { "dbui" } },
      { "<LOCALLEADER>o", "<PLUG>(DBUI_SelectLine)", desc = "Select line", ft = { "dbui" } },
      { "<LOCALLEADER>s", "<PLUG>(DBUI_SelectLineVsplit)", desc = "Select line", ft = { "dbui" } },
      { "<LOCALLEADER>d", "<PLUG>(DBUI_DeleteLine)", desc = "Delete line", ft = { "dbui" } },
      { "<LOCALLEADER>R", "<PLUG>(DBUI_Redraw)", desc = "Refresh", ft = { "dbui" } },
      { "<LOCALLEADER>r", "<PLUG>(DBUI_RenameLine)", desc = "Rename", ft = { "dbui" } },
      { "<LOCALLEADER>a", "<PLUG>(DBUI_AddConnection)", desc = "Add connection", ft = { "dbui" } },
      { "<LOCALLEADER>h", "<PLUG>(DBUI_ToggleDetails)", desc = "Toggle details", ft = { "dbui" } },
      { "<LOCALLEADER>q", "<PLUG>(DBUI_Quit)", desc = "Quit", ft = { "dbui" } },
      { "<LOCALLEADER>f", "<PLUG>(DBUI_JumpToForeignKey)", desc = "Jump to foreignkey", ft = { "dbout" } },
      { "<LOCALLEADER>c", "<PLUG>(DBUI_YankCellValue)", desc = "Select cell value", ft = { "dbout" } },
      { "<LOCALLEADER>h", "<PLUG>(DBUI_YankHeader)", desc = "Yank header", ft = { "dbout" } },
      { "<LOCALLEADER>u", "<PLUG>(DBUI_ToggleResultLayout)", desc = "Toggle result layout", ft = { "dbout" } },
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
            { "<LOCALLEADER>d", group = "DBUI" },
            { "<LOCALLEADER>ds", "<PLUG>(DBUI_ExecuteQuery)", desc = "Execute query" },
            { "<LOCALLEADER>dw", "<PLUG>(DBUI_SaveQuery)", desc = "Save query" },
            { "<LOCALLEADER>de", "<PLUG>(DBUI_EditBindParameters)", desc = "Edit bind parameters" },
          })
        end,
      })
    end,
  },
}
