return {
  "Wansmer/treesj",
  cmd = { "TSJSplit", "TSJSplit", "TSJToggle" },
  keys = {
    { "<LEADER>js", function() require("treesj").split() end, desc = "Split" },
    { "<LEADER>jj", function() require("treesj").join() end, desc = "Join" },
    { "<LEADER>jt", function() require("treesj").toggle() end, desc = "Toggle" },
    {
      "<LEADER>jS",
      function() require("treesj").split({ split = { recursive = true } }) end,
      desc = "Split recursively",
    },
    {
      "<LEADER>jT",
      function() require("treesj").toggle({ split = { recursive = true } }) end,
      desc = "Toggle split/join recursively",
    },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 0xffffffff,
  },
}
