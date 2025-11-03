return {
  {
    "tris203/precognition.nvim",
    keys = {
      { "~", function() require("precognition").peek() end, desc = "Precognition" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>v", function() require("flash").jump() end, desc = "Flash", mode = { "n", "x", "o" } },
      {
        "<leader>V",
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
        mode = { "n", "o", "x" },
      },
      { "r", function() require("flash").remote() end, desc = "Remote Flash", mode = { "o" } },
    },
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
    spec = {
      "folke/snacks.nvim",
      opts = {
        picker = {
          win = {
            input = {
              keys = {
                ["<a-s>"] = { "flash", mode = { "n", "i" } },
                ["s"] = { "flash" },
              },
            },
          },
          actions = {
            flash = function(picker)
              require("flash").jump({
                pattern = "^",
                label = { after = { 0, 0 } },
                search = {
                  mode = "search",
                  exclude = {
                    function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list" end,
                  },
                },
                action = function(match)
                  local idx = picker.list:row2idx(match.pos[1])
                  picker.list:_move(idx, true, true)
                end,
              })
            end,
          },
        },
      },
    },
  },
}
