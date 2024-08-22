return {
    "krady21/compiler-explorer.nvim",
    dependencies = {
        "stevearc/dressing.nvim",
        "rcarriga/nvim-notify",
    },

    cmd = {
        "CECompile",
        "CECompileLive",
        "CEFormat",
        "CEAddLibrary",
        "CELoadExample",
        "CEOpenWebsite",
        "CEDeleteCache",
        "CEShowTooltip",
        "CEShowTooltip",
    },

    opts = {
        infer_lang = true,
        line_match = {
            highlight = true, -- highlight the matching line(s) in the other buffer.
            jump = true, -- move the cursor in the other buffer to the first matching line.
        },
        open_qflist = false,
        split = "split",
        compiler_flags = "",
        job_timeout_ms = 25000, -- Timeout for libuv job in milliseconds.
    },
}
