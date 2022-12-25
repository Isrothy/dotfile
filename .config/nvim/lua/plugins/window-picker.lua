local M = {
    "s1n7ax/nvim-window-picker",
}

M.config = function()
    require("window-picker").setup({
        autoselect_one = true,
        include_current = false,
        filter_rules = {
            -- filter using buffer options
            bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = {
                    "neo-tree",
                    "neo-tree-popup",
                    "notify",
                    "quickfix",
                    "aerial",
                },

                -- if the buffer type is one of following, the window will be ignored
                buftype = {
                    "terminal",
                    "aerial",
                },
            },
        },
        other_win_hl_color = "#D08770",
    })
end
return M
