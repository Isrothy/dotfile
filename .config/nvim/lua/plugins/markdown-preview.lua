local M = {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
}

M.config = function()
    vim.g.mkdp_markdown_css = "/Users/jiangjoshua/.config/nvim/style/markdown.css"
    vim.g.mkdp_highlight_css = "/Users/jiangjoshua/.config/nvim/style/highlight.css"
    vim.g.mkdp_theme = "dark"
end

return M
