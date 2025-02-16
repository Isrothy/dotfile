return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  keys = {
    { "<LEADER>lf", function() require("conform").format({ async = true }) end, desc = "Code format" },
    {
      "<LEADER>lf",
      function()
        local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
        local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
        require("conform").format({
          range = {
            ["start"] = { start_row, 0 },
            ["end"] = { end_row, 0 },
          },
          async = true,
        })
      end,
      desc = "Code format",
      mode = { "x" },
    },
    {
      "<LEADER>lF",
      function() require("conform").format({ formatters = { "injected" }, async = true }) end,
      desc = "Format injected langs",
    },
    {
      "<LEADER>lF",
      function()
        local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
        local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
        require("conform").format({
          range = {
            ["start"] = { start_row, 0 },
            ["end"] = { end_row, 0 },
          },
          async = true,
          formatters = { "injected" },
        })
      end,
      desc = "Format injected langs",
      mode = { "x" },
    },
  },
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      async = true,
      quiet = false,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua", lsp_format = "fallback" },
      sh = { "shfmt", lsp_format = "fallback" },
      c = { "clang-format", lsp_format = "fallback" },
      cpp = { "clang-format", lsp_format = "fallback" },
      javascript = { "prettier", lsp_format = "fallback" },
      typescript = { "prettier", lsp_format = "fallback" },
      markdown = {
        "prettier",
        "markdownlint-cli2",
        "markdown-toc",
        lsp_format = "fallback",
      },
      ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
    },
    formatters = {
      ["markdown-toc"] = {
        condition = function(_, ctx)
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find("<!%-%- toc %-%->") then
              return true
            end
          end
        end,
      },
      ["markdownlint-cli2"] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d) return d.source == "markdownlint" end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
      injected = { options = { ignore_errors = true } },
    },
  },
}
