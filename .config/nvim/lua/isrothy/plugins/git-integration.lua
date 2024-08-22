return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        enabled = true,
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 0,
                ignore_whitespace = false,
            },
            sign_priority = 7,
            preview_config = {
                border = "rounded",
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, noremap = true })
                end

                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
                map("n", "<leader>ghb", function()
                    gs.blame_line({ full = true })
                end, "Blame Line")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function()
                    gs.diffthis("~")
                end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
            trouble = true,
        },
    },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        cmd = {
            "GitConflictChooseOurs",
            "GitConflictChooseTheirs",
            "GitConflictChooseBoth",
            "GitConflictChooseNone",
            "GitConflictNextConflict",
            "GitConflictPrevConflict",
            "GitConflictListQf",
        },
        keys = {
            {
                "<leader>ko",
                "<Plug>(git-conflict-ours)",
                desc = "Choose our version",
            },
            {
                "<leader>kt",
                "<Plug>(git-conflict-theirs)",
                desc = "Choose their version",
            },
            {
                "<leader>kb",
                "<Plug>(git-conflict-both)",
                desc = "Choose both versions",
            },
            {
                "<leader>kn",
                "<Plug>(git-conflict-none)",
                desc = "Choose no version",
            },
            -- {
            -- 	"[x",
            -- 	"<Plug>(git-conflict-prev-conflict)",
            -- 	desc = "Previous conflict",
            -- },
            -- {
            -- 	"]x",
            -- 	"<Plug>(git-conflict-next-conflict)",
            -- 	desc = "Next conflict",
            -- },
        },
        opts = {
            default_mappings = false,
            default_commands = true,
            disable_diagnostics = true,
        },
    },
    {

        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewRefresh",
            "DiffviewFileHistory",
        },
        opts = {},
    },
    {
        "NeogitOrg/neogit",
        cmd = {
            "Neogit",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            graph_style = "unicode",
            integrations = {
                telescope = true,
                diffview = true,
                fzf_lua = nil,
            },
        },
    },
    {
        "moyiz/git-dev.nvim",
        cmd = { "GitDevOpen" },
        keys = {
            {
                "<leader>go",
                function()
                    local repo = vim.fn.input("Repository name / URI: ")
                    if repo ~= "" then
                        require("git-dev").open(repo)
                    end
                end,
                desc = "[O]pen a remote git repository",
            },
        },
        opts = {
            cd_type = "tab",
        },
    },
    {
        "ejrichards/baredot.nvim",
        event = "VeryLazy",
        enabled = true,
        opts = {
            git_dir = "~/.cfg",
        },
    },
}
