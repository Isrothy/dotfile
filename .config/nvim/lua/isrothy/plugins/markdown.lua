local render_markdown_ft = {
  "markdown",
  "norg",
  "rmd",
  "org",
  "codecompanion",
  "Avante",
}
return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    keys = {
      { "<localleader>m", "", desc = "+Markdown", ft = "markdown" },
      { "<localleader>mP", ":MarkdownPreview<cr>", desc = "Markdown Preview", ft = "markdown" },
      { "<localleader>m<c-p>", ":MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop", ft = "markdown" },
      { "<localleader>mp", ":MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle", ft = "markdown" },
    },
    build = "cd app && yarn install",
    ft = { "markdown" },
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    config = function()
      local home = os.getenv("HOME")
      vim.g.mkdp_markdown_css = home .. "/.config/nvim/style/markdown.css"
      vim.g.mkdp_highlight_css = home .. "/.config/nvim/style/highlight.css"
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_auto_close = 1
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "RenderMarkdown" },
    keys = {
      { "<localleader>r", "", desc = "+Render markdown", ft = render_markdown_ft },
      {
        "<localleader>rr",
        function() require("render-markdown").buf_toggle() end,
        desc = "Toggle buffer",
        ft = render_markdown_ft,
      },
      {
        "<localleader>rR",
        function() require("render-markdown").buf_enable() end,
        desc = "Enable buffer",
        ft = render_markdown_ft,
      },
      {
        "<localleader>r<c-r>",
        function() require("render-markdown").buf_disable() end,
        desc = "Disable buffer",
        ft = render_markdown_ft,
      },

      {
        "<localleader>rl",
        function() require("render-markdown").expand() end,
        desc = "Expand",
        ft = render_markdown_ft,
      },
      {
        "<localleader>rh",
        function() require("render-markdown").contract() end,
        desc = "Contract",
        ft = render_markdown_ft,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        group = vim.api.nvim_create_augroup("render_markdown", { clear = true }),
        callback = function()
          Snacks.toggle({
            name = "render markdown",
            get = function() return require("render-markdown").get() end,
            set = function(state)
              if state then
                require("render-markdown").enable()
              else
                require("render-markdown").disable()
              end
            end,
          }):map("<leader>om")
        end,
      })
    end,
    ft = render_markdown_ft,
    opts = {
      code = {
        sign = false,
        width = "block",
        border = "none",
        language_border = "",
        disable_background = true,
      },
      heading = {
        sign = false,
        icons = {},
      },
      completions = {
        lsp = { enabled = true },
        blink = { enabled = true },
      },
      checkbox = {
        enabled = false,
      },
      file_types = render_markdown_ft,
    },
  },
}
