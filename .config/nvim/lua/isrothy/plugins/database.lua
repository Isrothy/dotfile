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
      {
        "<LOCALLEADER>s",
        "<PLUG>(DBUI_ExecuteQuery)",
        desc = "Execute Query",
        mode = { "n", "v" },
        ft = { "sql", "mysql", "plsql" },
      },
      {
        "<LOCALLEADER>w",
        "<PLUG>(DBUI_SaveQuery)",
        desc = "Save Query",
        ft = { "sql", "mysql", "plsql" },
      },
      {
        "<LOCALLEADER>e",
        "<PLUG>(DBUI_EditBindParameters)",
        "Edit Bind Parameters",
        ft = { "sql", "mysql", "plsql" },
      },
      {
        "<CR>",
        "<PLUG>(DBUI_SelectLine)",
        desc = "Select Line",
        ft = { "dbui" },
      },
      {
        "<LOCALLEADER>o",
        "<PLUG>(DBUI_SelectLine)",
        desc = "Select Line",
        ft = { "dbui" },
      },
      {
        "<LOCALLEADER>s",
        "<PLUG>(DBUI_SelectLineVsplit)",
        desc = "Select Line",
        ft = { "dbui" },
      },
      {
        "<LOCALLEADER>d",
        "<PLUG>(DBUI_DeleteLine)",
        desc = "Delete Line",
        ft = { "dbui" },
      },
      {
        "<LOCALLEADER>R",
        "<PLUG>(DBUI_Redraw)",
        desc = "Refresh",
        ft = { "dbui" },
      },
      {
        "<LOCALLEADER>r",
        "<PLUG>(DBUI_RenameLine)",
        desc = "Rename",
        ft = { "dbui" },
      },
      {
        "<LOCALLEADER>a",
        "<PLUG>(DBUI_AddConnection)",
        desc = "Add Connection",
        ft = { "dbui" },
      },
      {
        "<LOCALLEADER>h",
        "<PLUG>(DBUI_ToggleDetails)",
        desc = "Toggle Details",
        ft = { "dbui" },
      },
      {
        "<LOCALLEADER>q",
        "<PLUG>(DBUI_Quit)",
        desc = "Quit",
        ft = { "dbui" },
      },
      {
        "<LOCALLEADER>f",
        "<PLUG>(DBUI_JumpToForeignKey)",
        desc = "Jump to ForeignKey",
        ft = { "dbout" },
      },
      {
        "<LOCALLEADER>c",
        "<PLUG>(DBUI_YankCellValue)",
        desc = "Select Cell Value",
        ft = { "dbout" },
      },
      {
        "<LOCALLEADER>h",
        "<PLUG>(DBUI_YankHeader)",
        desc = "Yank Header",
        ft = { "dbout" },
      },
      {
        "<LOCALLEADER>u",
        "<PLUG>(DBUI_ToggleResultLayout)",
        desc = "Toggle Result Layout",
        ft = { "dbout" },
      },
    },
    init = function()
      local data_path = vim.fn.stdpath("data")

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true

      vim.g.db_ui_disable_mappings = 1

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <LEADER>S
      vim.g.db_ui_execute_on_save = false
    end,
  },
}
