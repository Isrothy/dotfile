return {
  { "fladson/vim-kitty", ft = { "kitty" } },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    cmd = {
      "KittyScrollbackGenerateKittens",
      "KittyScrollbackCheckHealth",
      "KittyScrollbackGenerateCommandLineEditing",
    },
    enabled = true,
    event = { "User KittyScrollbackLaunch" },
    config = function()
      local autocmds = require("kitty-scrollback.autocommands")
      autocmds.set_term_enter_autocmd = function(_) end
      autocmds.set_yank_post_autocmd = function() end

      require("kitty-scrollback").setup({
        {
          keymaps_enabled = true,
          status_window = {
            enabled = false,
          },
          close_after_yank = false,
          paste_window = {
            highlight_as_normal_win = nil,
            filetype = nil,
            hide_footer = false,
            winblend = 0,
            winopts_overrides = nil,
            footer_winopts_overrides = nil,
            yank_register = "",
            yank_register_enabled = false,
          },
        },
      })
    end,
  },
}
