return {
  "kosayoda/nvim-lightbulb",
  enabled = true,
  event = { "LspAttach" },
  opts = {
    priority = 10,
    hide_in_unfocused_buffer = false,
    link_highlights = false,
    validate_config = "auto",
    action_kinds = nil,
    sign = {
      enabled = true,
      text = "⬥",
      lens_text = "●",
      hl = "LightBulbSign",
    },
    virtual_text = { enabled = false },
    float = { enabled = false },
    status_text = { enabled = false },
    number = { enabled = false },
    line = { enabled = false },
    autocmd = {
      enabled = true,
      updatetime = 200,
      events = { "CursorHold", "CursorHoldI" },
      pattern = { "*" },
    },
    ignore = {
      clients = {},
      ft = {},
      actions_without_kind = false,
    },
  },
}
