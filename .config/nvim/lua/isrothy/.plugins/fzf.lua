return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  enabled = false,
  keys = {
    { "<LEADER>fa", "<CMD>FzfLua autocommands<CR>", desc = "Autocommands" },
    { "<LEADER>fb", "<CMD>FzfLua buffers<CR>", desc = "Find Buffers" },
    { "<LEADER>fc", "<CMD>FzfLua commands<CR>", desc = "Find Commands" },

    { "<LEADER>ff", "<CMD>FzfLua files<CR>", desc = "Find Files" },
    { "<LEADER>fg", "<CMD>FzfLua live_grep<CR>", desc = "Live Grep" },
    { "<LEADER>fh", "<CMD>FzfLua helptags<CR>", desc = "Help Tags" },
    { "<LEADER>fH", "<CMD>FzfLua highlights<CR>", desc = "Highlight Groups" },
    { "<LEADER>fj", "<CMD>FzfLua jumps<CR>", desc = "Jumps" },
    { "<LEADER>fk", "<CMD>FzfLua keymaps<CR>", desc = "Keymaps" },
    { "<LEADER>fl", "<CMD>FzfLua loclist<CR>", desc = "Location List" },
    { "<LEADER>fm", "<CMD>FzfLua marks<CR>", desc = "Marks" },
    { "<LEADER>fM", "<CMD>FzfLua manpage<CR>", desc = "Man Page" },

    { "<LEADER>fo", "<CMD>FzfLua oldfiles<CR>", desc = "Oldfiles" },

    { "<LEADER>fq", "<CMD>FzfLua quickfix<CR>", desc = "Quickfix" },

    { "<LEADER>fv", "<CMD>FzfLua grep_visual<CR>", desc = "Grep Visual" },
    { "<LEADER>fw", "<CMD>FzfLua grep_cword<CR>", desc = "Grep Current Word" },
    { "<LEADER>fW", "<CMD>FzfLua grep_cWORD<CR>", desc = "Grep Current WORD" },

    { "<LEADER>f\"", "<CMD>FzfLua registers<CR>", desc = "Registers" },
    { "<LEADER>f.", "<CMD>FzfLua resume<CR>", desc = "Resume" },

    { "<LEADER>xf", "<CMD>FzfLua diagnostics_document<CR>", desc = "Buffer Diagnostics (Fzf)" },
    { "<LEADER>xF", "<CMD>FzfLua diagnostics_workspace<CR>", desc = "Diagnostics (Fzf)" },

    { "<LEADER>gs", "<CMD>FzfLua git_status<CR>", desc = "Status" },
    { "<LEADER>gc", "<CMD>FzfLua git_commits<CR>", desc = "Commits" },
  },
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("fzf-lua").register_ui_select()
      return vim.ui.select(...)
    end
  end,
  opts = function()
    local config = require("fzf-lua.config")

    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open

    return {
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = { "viu", "-b" },
            ["jpg"] = { "ueberzug" },
          },
          ueberzug_scaler = "cover",
        },
      },
    }
  end,
}
