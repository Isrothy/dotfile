return {
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    opts = {
      hint = "statusline-winbar",
      selection_chars = "FJDKSLA;CMRUEIWOQP",
      -- hint = "floating-big-letter",
      filter_rules = {
        autoselect_one = false,
        include_current_win = true,
        bo = {
          filetype = {
            "neo-tree-popup",
            "notify",
            "satellite",
          },
        },
      },
      picker_config = {
        statusline_winbar_picker = {
          selection_display = function(char, _) return "%=" .. char .. "%=" end,
          use_winbar = "never", -- "always" | "never" | "smart"
        },
      },
      show_prompt = false,
    },
  },
}
