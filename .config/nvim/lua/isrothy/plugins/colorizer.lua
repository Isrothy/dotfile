return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    keys = {
      { "<LEADER>Cc", "<CMD>ColorizerToggle<CR>", desc = "Toggle" },
      { "<LEADER>Cr", "<CMD>ColorizerReloadAllBuffers<CR>", desc = "Reload" },
      { "<LEADER>Ca", "<CMD>ColorizerAttachToBuffer<CR>", desc = "Attach" },
      { "<LEADER>Cd", "<CMD>ColorizerDetachFromBuffer<CR>", desc = "Detach" },
    },
    init = function() vim.opt.termguicolors = true end,
    opts = {
      filetypes = {
        "*",
        css = {
          names = true,
          RGB = true,
          RGBA = true,
          css = true,
          rgb_fn = true,
          hsl_fn = true,
          css_fn = true,
        },
        scss = {
          names = true,
          RGB = true,
          RGBA = true,
          css = true,
          rgb_fn = true,
          hsl_fn = true,
          css_fn = true,
          sass = { enable = true, parsers = { "css" } },
        },
        "!lazy",
        "!nofile",
        "!prompt",
        "!popup",
        "!terminal",
      },
      buftypes = {},
      lazy_load = true, -- Lazily schedule buffer highlighting setup function
      -- user_commands = true, -- Enable all or some usercommands
      user_default_options = {
        names = false, -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
        names_custom = false, -- Custom names to be highlighted: table|function|false
        RGB = false, -- #RGB hex codes
        RGBA = false, -- #RGBA hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS *features*:
        -- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
        tailwind = false, -- Enable tailwind colors
        tailwind_opts = { -- Options for highlighting tailwind names
          update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
        },
        -- parsers can contain values used in `user_default_options`
        sass = { enable = false }, -- Enable sass colors
        -- Highlighting mode.  'background'|'foreground'|'virtualtext'
        mode = "background", -- Set the display mode
        always_update = true,
        hooks = {
          do_lines_parse = false,
        },
      },
    },
  },
}
