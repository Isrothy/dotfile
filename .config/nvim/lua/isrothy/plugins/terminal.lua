return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      [[<C-`>]],
      {
        [[<LEADER>\]],
        function() require("toggleterm").send_lines_to_terminal("visual_selection", true, { args = vim.v.count1 }) end,
        mode = { "v" },
        desc = "Send visual selection to terminal",
      },
      {
        [[<LEADER>|]],
        function() require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = vim.v.count1 }) end,
        mode = "v",
        desc = "Send visual lines to terminal",
      },
      {
        [[<LEADER>\]],
        function()
          vim.go.operatorfunc = "v:lua.send_to_term_op"
          vim.api.nvim_feedkeys("g@", "n", false)
        end,
        mode = "n",
        expr = true,
        desc = "Operator: send motion to terminal",
      },
      {
        [[<LEADER>\\]],
        function() require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count1 }) end,
        mode = "n",
        desc = "Send current line to terminal",
      },
      {
        [[<LEADER>f$]],
        "<CMD>TermSelect<CR>",
        desc = "Select terminal",
      },
      {
        [[<LEADER>$N]],
        "<CMD>ToggleTermSetName<CR>",
        desc = "Set name of terminal",
      },
      {
        [[<LEADER>$n]],
        "<CMD>TermNew<CR>",
        desc = "Create new terminal",
      },
    },
    cmd = {
      "TermExec",
      "TermNew",
      "TermSelect",
      "ToggleTerm",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
      "ToggleTermSetName",
      "ToggleTermToggleAll",
    },
    init = function()
      vim.api.nvim_create_user_command("TermRun", function(opts)
        local cmd = table.concat(opts.fargs, " ")
        cmd = cmd:gsub([["]], [[\"]])
        require("toggleterm").exec(cmd)
      end, { nargs = "*", desc = "Alias for TermExec with dynamic command execution" })
      function _G.send_to_term_op(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, true, { args = vim.v.count1 })
      end
    end,
    opts = {
      open_mapping = [[<C-`>]],
      hide_numbers = true,
      autochdir = true,
      insert_mappings = true,
      shade_terminals = false,
      close_on_exit = false,
      winbar = {
        enabled = true,
      },
    },
  },
  {
    "willothy/flatten.nvim",
    enabled = true,
    lazy = false,
    priority = 1001,
    opts = function()
      local saved_terminal

      return {
        window = { open = "alternate" },
        integrations = {
          kitty = true,
          wezterm = false,
        },
        hooks = {
          should_block = function(argv) return vim.tbl_contains(argv, "-b") end,
          pre_open = function()
            local term = require("toggleterm.terminal")
            local termid = term.get_focused_id()
            saved_terminal = term.get(termid)
          end,
          post_open = function(bufnr, winnr, ft, is_blocking)
            if is_blocking and saved_terminal then
              saved_terminal:close()
            elseif winnr then --Important
              vim.api.nvim_set_current_win(winnr)
            end

            if ft == "gitcommit" or ft == "gitrebase" then
              vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                once = true,
                callback = vim.schedule_wrap(function() vim.api.nvim_buf_delete(bufnr, {}) end),
              })
            end
          end,
          block_end = function()
            vim.schedule(function()
              if saved_terminal then
                saved_terminal:open()
                saved_terminal = nil
              end
            end)
          end,
        },
      }
    end,
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    cmd = {
      "KittyScrollbackGenerateKittens",
      "KittyScrollbackCheckHealth",
      "KittyScrollbackGenerateCommandLineEditing",
    },
    event = { "User KittyScrollbackLaunch" },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^4.0.0', -- pin major version, include fixes and features that do not have breaking changes
    opts = {},
  },
}
