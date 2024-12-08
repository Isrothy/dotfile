local mini_bracket_opts = {
  buffer = { suffix = "", options = {} },
  comment = { suffix = "k", options = {} },
  conflict = { suffix = "x", options = {} },
  diagnostic = { suffix = "d", options = {} },
  file = { suffix = "f", options = {} },
  indent = { suffix = "i", options = {} },
  jump = { suffix = "j", options = {} },
  location = { suffix = "l", options = {} },
  oldfile = { suffix = "o", options = {} },
  quickfix = { suffix = "q", options = {} },
  treesitter = { suffix = "", options = {} },
  undo = { suffix = "" },
  window = { suffix = "", options = {} },
  yank = { suffix = "y", options = {} },
}

local mini_bracket_keys = {
  {
    "]e",
    "<cmd>lua MiniBracketed.diagnostic('forward',{ severity = vim.diagnostic.severity.ERROR })<cr>",
    desc = "Error forward",
  },
  {
    "[e",
    "<cmd>lua MiniBracketed.diagnostic('backward',{ severity = vim.diagnostic.severity.ERROR })<cr>",
    desc = "Error backword",
  },
  {
    "]E",
    "<cmd>lua MiniBracketed.diagnostic('last',{ severity = vim.diagnostic.severity.ERROR })<cr>",
    desc = "Error last",
  },
  {
    "[E",
    "<cmd>lua MiniBracketed.diagnostic('first',{ severity = vim.diagnostic.severity.ERROR })<cr>",
    desc = "Error first",
  },
  {
    "]w",
    "<cmd>lua MiniBracketed.diagnostic('forward',{ severity = vim.diagnostic.severity.WARN })<cr>",
    desc = "Warn forward",
  },
  {
    "[w",
    "<cmd>lua MiniBracketed.diagnostic('backward',{ severity = vim.diagnostic.severity.WARN })<cr>",
    desc = "Warn backword",
  },
  {
    "]W",
    "<cmd>lua MiniBracketed.diagnostic('last',{ severity = vim.diagnostic.severity.WARN })<cr>",
    desc = "Warn last",
  },
  {
    "[W",
    "<cmd>lua MiniBracketed.diagnostic('first',{ severity = vim.diagnostic.severity.WARN })<cr>",
    desc = "Warn first",
  },
}

for k, v in pairs(mini_bracket_opts) do
  local m = string.upper(k:sub(1, 1)) .. k:sub(2)
  local s = v.suffix
  if s ~= "" then
    table.insert(mini_bracket_keys, { "]" .. s, desc = m .. " forward" })
    table.insert(mini_bracket_keys, { "[" .. s, desc = m .. " backword" })
    table.insert(mini_bracket_keys, { "]" .. string.upper(s), desc = m .. " last" })
    table.insert(mini_bracket_keys, { "[" .. string.upper(s), desc = m .. " first" })
  end
end

return {
  {
    "echasnovski/mini.bracketed",
    enabled = true,
    keys = mini_bracket_keys,
    opts = mini_bracket_opts,
  },
  {
    "mawkler/refjump.nvim",
    keys = {
      { "]r", desc = "Lsp Reference forward" },
      { "[r", desc = "Lsp Reference backward" },
    },
    opts = {},
  },
}
