return {
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {
      map_bs = true,
      map_c_h = true,
      check_ts = true,
      map_c_w = true,
      map_cr = true,
      enable_check_bracket_line = true,
      ignored_next_char = "[%w%.]",
      disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
      },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
    opts = {
      opts = {
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      },
    },
  },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {
      lang = {
        cuda = "// %s",
      },
    },
  },
}
