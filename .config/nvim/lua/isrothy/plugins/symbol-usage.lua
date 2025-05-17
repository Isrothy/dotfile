return {
  "Wansmer/symbol-usage.nvim",
  event = "LspAttach",
  keys = {
    { "<leader>ls", function() require("symbol-usage").toggle() end, desc = "Toggle symbpol usage hint" },
    {
      "<leader>lS",
      function() require("symbol-usage").toggle_globally() end,
      desc = "Toggle symbpol usage hint globally",
    },
  },
  opts = {
    vt_position = "end_of_line",
    text_format = function(symbol)
      local fragments = {}

      -- Indicator that shows if there are any other symbols in the same line
      local stacked_functions = symbol.stacked_count > 0 and (" | +%s"):format(symbol.stacked_count) or ""

      if symbol.references then
        local usage = symbol.references <= 1 and "usage" or "usages"
        local num = symbol.references == 0 and "no" or symbol.references
        table.insert(fragments, ("%s %s"):format(num, usage))
      end

      if symbol.definition then
        table.insert(fragments, symbol.definition .. " defs")
      end

      if symbol.implementation then
        table.insert(fragments, symbol.implementation .. " impls")
      end

      return table.concat(fragments, ", ") .. stacked_functions
    end,
  },
}
