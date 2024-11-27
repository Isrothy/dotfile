local telescope = {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-frecency.nvim", dependencies = { "kkharji/sqlite.lua" } },
        { "jvgrootveld/telescope-zoxide" },
        { "debugloop/telescope-undo.nvim" },
    },
}

telescope.keys = {
    { "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Autocommands" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },

    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },

    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "jumplist" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>fl", "<cmd>Telescope local_list<cr>", desc = "Local list" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>fn", "<cmd>Telescope noice<cr>", desc = "Noice" },
    { "<leader>fo", "<cmd>Telescope frecency<cr>", desc = "Oldfiles" },
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
    { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>fs", "<cmd>Telescope persisted<cr>", desc = "Sessions" },
    { "<leader>ft", "<cmd>Telescope tags<cr>", desc = "Treesitter" },
    { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo" },
    { "<leader>fv", "<cmd>Telescope vim_options<cr>", desc = "Vim options" },

    { "<leader>fy", "<cmd>Telescope yank_history<cr>", desc = "Yank history" },
    { "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide" },
}

telescope.config = function()
    -- local command_center = require("command_center")
    local previewers = require("telescope.previewers")
    local Job = require("plenary.job")

    local new_maker = function(filepath, bufnr, opts)
        filepath = vim.fn.expand(filepath)
        Job:new({
            command = "file",
            args = { "--mime-type", "-b", filepath },
            on_exit = function(j)
                local mime_type = vim.split(j:result()[1], "/")[1]
                if mime_type == "text" then
                    previewers.buffer_previewer_maker(filepath, bufnr, opts)
                else
                    -- maybe we want to write something to the buffer here
                    vim.schedule(function()
                        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                    end)
                end
            end,
        }):sync()
    end

    require("telescope").setup({
        pickers = {
            find_files = {
                find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
            },
        },
        defaults = {
            buffer_previewer_maker = new_maker,
            dynamic_preview_title = true,
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--trim",
            },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
                -- require("telescope.themes").get_cursor({}),
            },
            frecency = {
                show_scores = false,
                show_unindexed = true,
                db_safe_mode = false,
                ignore_patterns = { "*.git/*", "*/tmp/*" },
                disable_devicons = false,
            },
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            aerial = {
                -- Display symbols as <root>.<parent>.<symbol>
                show_nesting = true,
            },
            persisted = {
                layout_config = { width = 0.55, height = 0.55 },
            },
            undo = {
                use_delta = true,
                side_by_side = true,
                layout_strategy = "vertical",
                layout_config = {
                    -- preview_height = 0.8,
                },
                mappings = { -- this whole table is the default
                    i = {
                        -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                        -- you want to use the following actions. This means installing as a dependency of
                        -- telescope in it's `requirements` and loading this extension from there instead of
                        -- having the separate plugin definition as outlined above. See issue #6.
                        ["<cr>"] = require("telescope-undo.actions").yank_additions,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-cr>"] = require("telescope-undo.actions").restore,
                    },
                },
            },
            zoxide = {
                prompt_title = "[ Walking on the shoulders of TJ ]",
                list_command = "zoxide query -ls",
                mappings = {
                    default = {
                        action = function(selection)
                            vim.cmd("cd " .. selection.path)
                        end,
                        after_action = function(selection)
                            print("Directory changed to " .. selection.path)
                        end,
                    },
                },
            },
            lazy = {
                -- Optional theme (the extension doesn't set a default theme)
                theme = "ivy",
                -- Whether or not to show the icon in the first column
                show_icon = true,
                -- Mappings for the actions
                mappings = {
                    open_in_browser = "<C-o>",
                    open_in_find_files = "<C-f>",
                    open_in_live_grep = "<C-g>",
                    open_plugins_picker = "<C-b>", -- Works only after having called first another action
                    open_lazy_root_find_files = "<C-r>f",
                    open_lazy_root_live_grep = "<C-r>g",
                },
                -- Other telescope configuration options
            },
            advanced_git_search = {
                -- fugitive or diffview
                diff_plugin = "diffview",
                -- customize git in previewer
                -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
                git_flags = {},
                -- customize git diff in previewer
                -- e.g. flags such as { "--raw" }
                git_diff_flags = {},
                -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
                show_builtin_git_pickers = false,
                entry_default_author_or_date = "author", -- one of "author" or "date"
                keymaps = {
                    -- following keymaps can be overridden
                    toggle_date_author = "<C-w>",
                    open_commit_in_browser = "<C-o>",
                    copy_commit_hash = "<C-y>",
                },
                -- Telescope layout setup
                telescope_theme = {
                    function_name_1 = {
                        -- Theme options
                    },
                    function_name_2 = "dropdown",
                    -- e.g. realistic example
                    show_custom_functions = {
                        layout_config = { width = 0.4, height = 0.4 },
                    },
                },
            },
        },
    })

    -- require("telescope").load_extension("notify")
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("zoxide")
    require("telescope").load_extension("frecency")
    -- require("telescope").load_extension("aerial")
    require("telescope").load_extension("noice")
    require("telescope").load_extension("undo")
    require("telescope").load_extension("smart_open")
    require("telescope").load_extension("projects")
    require("telescope").load_extension("advanced_git_search")
    -- require("telescope").load_extension("persisted")
end

return {
    telescope,
    {
        "luc-tielen/telescope_hoogle",
        ft = "haskell",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("hoogle")
        end,
    },
    {
        "danielfalk/smart-open.nvim",
        branch = "0.1.x",
        dependencies = { "kkharji/sqlite.lua" },
    },
    {
        "wintermute-cell/gitignore.nvim",
        cmd = { "GitIgnore" },
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
    },
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        cmd = { "ProjectRoot", "AddProject" },
        opts = {
            manual_mode = true,
        },
        config = function(_, opts)
            require("project_nvim").setup(opts)
            -- local history = require("project_nvim.utils.history")
            -- history.delete_project = function(project)
            --     for k, v in pairs(history.recent_projects) do
            --         if v == project.value then
            --             history.recent_projects[k] = nil
            --             return
            --         end
            --     end
            -- end
        end,
    },
    {
        "LukasPietzschmann/telescope-tabs",
        event = "VeryLazy",
        config = function()
            require("telescope").load_extension("telescope-tabs")
            require("telescope-tabs").setup({
                show_preview = true,
            })
        end,
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
    {
        "aaronhallaert/advanced-git-search.nvim",
        cmd = { "AdvancedGitSearch" },
        dependencies = {
            "nvim-telescope/telescope.nvim",
            -- to show diff splits and open commits in browser
            "tpope/vim-fugitive",
            -- to open commits in browser with fugitive
            "tpope/vim-rhubarb",
            -- optional: to replace the diff from fugitive with diffview.nvim
            -- (fugitive is still needed to open in browser)
            "sindrets/diffview.nvim",
            --- See dependencies
        },
    },
}
