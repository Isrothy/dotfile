return {
    {
        "olimorris/persisted.nvim",
        lazy = false, -- make sure the plugin is always loaded at startup
        enabled = true,
        priority = 100,
        opts = {
            autostart = true,
            autosave = true,
            use_git_branch = true,
            silent = true,
            on_autoload_no_session = function()
                vim.notify("No existing session to load.", vim.log.levels.WARN)
            end,
        },
    },
}
