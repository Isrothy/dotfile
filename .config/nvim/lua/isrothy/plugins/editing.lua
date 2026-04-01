local map = vim.keymap.set

vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    require("nvim-autopairs").setup({
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
        map = "<m-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    })
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      },
    })

    require("ts-comments").setup({
      lang = {
        cuda = "// %s",
      },
    })

    require("treesj").setup({
      use_default_keymaps = false,
      max_join_length = 0xffffffff,
    })

    local treesj = require("treesj")
    map("n", "g[", function() treesj.split() end, { desc = "Split block" })
    map("n", "g]", function() treesj.join() end, { desc = "Join block" })
    map("n", "g{", function() treesj.split({ split = { recursive = true } }) end, { desc = "Split recursively" })
  end,
})
