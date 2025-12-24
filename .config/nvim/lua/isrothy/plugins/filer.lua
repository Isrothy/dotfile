return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "Z", "<cmd>Oil<cr>", desc = "Open oil", nowait = true },
      { "<leader>fo", "<cmd>Oil<cr>", desc = "Open oil" },
      { "<leader>f.", "<cmd>Oil .<cr>", desc = "Open oil at ." },
    },
    opts = {
      win_options = {
        signcolumn = "yes:2",
        statuscolumn = "",
      },
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<localleader>s"] = { "actions.select", opts = { vertical = true } },
        ["<localleader>h"] = { "actions.select", opts = { horizontal = true } },
        ["<localleader><tab>"] = { "actions.select", opts = { tab = true } },
        ["<localleader>p"] = "actions.preview",
        ["<localleader>q"] = { "actions.close", mode = "n" },
        ["<localleader>r"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
        ["Z"] = { "actions.close", mode = "n", nowait = true },

        ["<localleader>o"] = {
          desc = "Go to specific path",
          callback = function()
            local cwd = require("oil").get_current_dir()
            vim.ui.input({
              prompt = "Go to path: ",
              default = cwd,
              completion = "dir",
            }, function(input)
              if input then
                require("oil").open(input)
              end
            end)
          end,
        },
        ["<localleader>y"] = {
          desc = "Copy filepath to system clipboard",
          callback = function()
            require("oil.actions").copy_entry_path.callback()
            vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
            print("Path yanked to clipboard!")
          end,
        },
        ["<localleader>."] = {
          desc = "Change cwd to current directory",
          callback = function()
            require("oil").open_float(".")
            vim.cmd("tcd " .. require("oil").get_current_dir())
            print("CWD changed to: " .. require("oil").get_current_dir())
          end,
        },
      },
    },
    lazy = false,
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("Oil_start_directory", { clear = true }),
        pattern = "*",
        callback = function()
          if vim.fn.isdirectory(vim.fn.expand("%:p")) == 1 then
            vim.cmd("Oil")
          end
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          if event.data.actions[1].type == "move" then
            Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
          end
        end,
      })
    end,
  },
}
