return {
    {
        "andymass/vim-matchup",
        event = { "BufReadPost", "BufNewFile" },
        enabled = false,
        init = function()
            vim.g.matchup_motion_override_Npercent = 0
            vim.g.matchup_matchparen_fallback = 0
            vim.g.matchup_motion_enabled = 0
            vim.g.matchup_text_obj_enabled = 0
            vim.g.matchup_delim_noskips = 2
            vim.g.matchup_matchparen_deferred = 1
            vim.g.matchup_matchparen_deferred_show_delay = 60
            vim.g.matchup_matchparen_hi_surround_always = 1
            vim.g.matchup_matchparen_offscreen = {
                method = "status_manual",
            }
        end,
    },
    {
        "utilyre/sentiment.nvim",
        enabled = false,
        version = "*",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- config
            pairs = {
                { "(", ")" },
                -- { "<", ">" },
                { "{", "}" },
                { "[", "]" },
            },
        },
        init = function()
            vim.g.loaded_matchparen = 1
            vim.g.loaded_matchit = 1
        end,
    },
    {
        "monkoose/matchparen.nvim",
        event = { "BufReadPost", "BufNewFile" },
        enabled = false,
        opts = {
            on_startup = true,
            hl_group = "MatchParen",
        },
        init = function()
            vim.g.loaded_matchparen = 1
            vim.g.loaded_matchit = 1
        end,
    },
}
