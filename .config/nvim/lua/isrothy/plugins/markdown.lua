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
      { "<LOCALLEADER>m", "", desc = "+Markdown Preview", ft = "markdown" },
      { "<LOCALLEADER>mP", ":MarkdownPreview<CR>", desc = "Markdown Preview", ft = "markdown" },
      { "<LOCALLEADER>m<C-P>", ":MarkdownPreviewStop<CR>", desc = "Markdown Preview Stop", ft = "markdown" },
      { "<LOCALLEADER>mp", ":MarkdownPreviewToggle<CR>", desc = "Markdown Preview Toggle", ft = "markdown" },
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
    "Kicamon/markdown-table-mode.nvim",
    ft = { "markdown" },
    cmd = { "Mtm" },
    keys = {
      { "<LOCALLEADER>m", "", desc = "+Markdown Preview", ft = "markdown" },
      { "<LOCALLEADER>mt", ":Mtm<CR>", desc = "Markdown Table Mode", ft = "markdown" },
    },
    config = function() require("markdown-table-mode").setup() end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    cmd = { "RenderMarkdown" },
    keys = {
      { "<LOCALLEADER>r", "", desc = "+Render markdown", ft = render_markdown_ft },
      {
        "<LOCALLEADER>rr",
        function() require("render-markdown").toggle() end,
        desc = "Toggle",
        ft = render_markdown_ft,
      },
      {
        "<LOCALLEADER>rR",
        function() require("render-markdown").enable() end,
        desc = "Enable",
        ft = render_markdown_ft,
      },
      {
        "<LOCALLEADER>r<c-r>",
        function() require("render-markdown").disable() end,
        desc = "Disable",
        ft = render_markdown_ft,
      },

      { "<LOCALLEADER>rb", "", desc = "+Buffer", ft = render_markdown_ft },
      {
        "<LOCALLEADER>rbr",
        function() require("render-markdown").buf_toggle() end,
        desc = "Toggle",
        ft = render_markdown_ft,
      },
      {
        "<LOCALLEADER>rbR",
        function() require("render-markdown").buf_enable() end,
        desc = "Enable",
        ft = render_markdown_ft,
      },
      {
        "<LOCALLEADER>rb<c-r>",
        function() require("render-markdown").buf_disable() end,
        desc = "Disable",
        ft = render_markdown_ft,
      },

      {
        "<LOCALLEADER>rl",
        function() require("render-markdown").expand() end,
        desc = "Expand",
        ft = render_markdown_ft,
      },
      {
        "<LOCALLEADER>rh",
        function() require("render-markdown").contract() end,
        desc = "Contract",
        ft = render_markdown_ft,
      },
    },
    ft = render_markdown_ft,
    opts = {
      code = {
        sign = false,
        width = "block",
        border = "none",
        below = "▔",
        above = "▁",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      completions = {
        lsp = { enabled = true },
      },
      checkbox = {
        enabled = false,
      },
      file_types = render_markdown_ft,
    },
  },
}
