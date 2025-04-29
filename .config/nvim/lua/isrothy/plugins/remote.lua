return {
  {
    "azratul/live-share.nvim",
    cmd = { "LiveShareServer", "LiveShareJoin" },
    dependencies = {
      "jbyuki/instant.nvim",
    },
  },
  {
    "jbyuki/instant.nvim",
    cmd = {
      "InstantStartServer",
      "InstantStartSingle",
      "InstantStartSession",
      "InstantJoinSingle",
      "InstantJoinSession",
      "InstantStatus",
      "InstantFollow",
      "InstantOpenAll",
      "InstantSaveAll",
      "InstantMark",
      "InstantMarkClear",
      "InstantStopServer",
      "InstantStopFollow",
    },
    init = function() vim.g.instant_username = "Isrothy" end,
  },
}
