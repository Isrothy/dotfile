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
      { "<localleader>m", "", desc = "+Markdown Preview", ft = "markdown" },
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
    "Kicamon/markdown-table-mode.nvim",
    ft = { "markdown" },
    cmd = { "Mtm" },
    keys = {
      { "<localleader>m", "", desc = "+Markdown Preview", ft = "markdown" },
      { "<localleader>mt", ":Mtm<cr>", desc = "Markdown Table Mode", ft = "markdown" },
    },
    config = function() require("markdown-table-mode").setup() end,
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
        function() require("render-markdown").toggle() end,
        desc = "Toggle",
        ft = render_markdown_ft,
      },
      {
        "<localleader>rR",
        function() require("render-markdown").enable() end,
        desc = "Enable",
        ft = render_markdown_ft,
      },
      {
        "<localleader>r<c-r>",
        function() require("render-markdown").disable() end,
        desc = "Disable",
        ft = render_markdown_ft,
      },

      { "<localleader>rb", "", desc = "+Buffer", ft = render_markdown_ft },
      {
        "<localleader>rbr",
        function() require("render-markdown").buf_toggle() end,
        desc = "Toggle",
        ft = render_markdown_ft,
      },
      {
        "<localleader>rbR",
        function() require("render-markdown").buf_enable() end,
        desc = "Enable",
        ft = render_markdown_ft,
      },
      {
        "<localleader>rb<c-r>",
        function() require("render-markdown").buf_disable() end,
        desc = "Disable",
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
        blink = { enabled = true },
      },
      checkbox = {
        enabled = false,
      },
      file_types = render_markdown_ft,
    },
  },
}
