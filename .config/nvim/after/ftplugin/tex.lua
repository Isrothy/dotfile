-- after/ftplugin/tex.lua
-- Set basic options for the current TeX buffer.
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

local bufnr = vim.api.nvim_get_current_buf()

-- Unified keymap table
local keymaps = {
  -- Outer text objects.
  { "ac", "<plug>(vimtex-ac)", mode = { "o", "x" }, desc = "VimTeX: Around command" },
  { "ad", "<plug>(vimtex-ad)", mode = { "o", "x" }, desc = "VimTeX: Around delimiter" },
  { "ae", "<plug>(vimtex-ae)", mode = { "o", "x" }, desc = "VimTeX: Around environment" },
  { "am", "<plug>(vimtex-a$)", mode = { "o", "x" }, desc = "VimTeX: Around math environment" },
  { "ap", "<plug>(vimtex-aP)", mode = { "o", "x" }, desc = "VimTeX: Around Section" },
  { "ax", "<plug>(vimtex-am)", mode = { "o", "x" }, desc = "VimTeX: Around item" },

  -- Inner text objects.
  { "ic", "<plug>(vimtex-ic)", mode = { "o", "x" }, desc = "VimTeX: Inside command" },
  { "id", "<plug>(vimtex-id)", mode = { "o", "x" }, desc = "VimTeX: Inside delimiter" },
  { "ie", "<plug>(vimtex-ie)", mode = { "o", "x" }, desc = "VimTeX: Inside environment" },
  { "im", "<plug>(vimtex-i$)", mode = { "o", "x" }, desc = "VimTeX: Inside math environment" },
  { "ip", "<plug>(vimtex-iP)", mode = { "o", "x" }, desc = "VimTeX: Inside section" },
  { "ix", "<plug>(vimtex-im)", mode = { "o", "x" }, desc = "VimTeX: Inside item" },

  -- Single/motion mappings.
  { "%", "<plug>(vimtex-%)", mode = { "n", "o" }, desc = "VimTeX: Find matching pair" },
  { "]p", "<plug>(vimtex-]])", mode = { "n", "o" }, desc = "VimTeX: Next section start" },
  { "]P", "<plug>(vimtex-][)", mode = { "n", "o" }, desc = "VimTeX: Next section end" },
  { "[p", "<plug>(vimtex-[[)", mode = { "n", "o" }, desc = "VimTeX: Previous section start" },
  { "[P", "<plug>(vimtex-[])", mode = { "n", "o" }, desc = "VimTeX: Previois section end" },

  { "]m", "<plug>(vimtex-]m)", mode = { "n", "o" }, desc = "VimTeX: Next begin environment" },
  { "]M", "<plug>(vimtex-]M)", mode = { "n", "o" }, desc = "VimTeX: Next end environment" },
  { "[m", "<plug>(vimtex-[m)", mode = { "n", "o" }, desc = "VimTeX: Previous begin environment" },
  { "[M", "<plug>(vimtex-[M)", mode = { "n", "o" }, desc = "VimTeX: Previous end environment" },

  { "]n", "<plug>(vimtex-]n)", mode = { "n", "o" }, desc = "VimTeX: Next math zone start" },
  { "]N", "<plug>(vimtex-]N)", mode = { "n", "o" }, desc = "VimTeX: Next math zone end" },
  { "[n", "<plug>(vimtex-[n)", mode = { "n", "o" }, desc = "VimTeX: Previous math zone start" },
  { "[N", "<plug>(vimtex-[N)", mode = { "n", "o" }, desc = "VimTeX: Previous math zone end" },

  { "]r", "<plug>(vimtex-]r)", mode = { "n", "o" }, desc = "VimTeX: Next frame environment start" },
  { "]R", "<plug>(vimtex-]R)", mode = { "n", "o" }, desc = "VimTeX: Next frame environment end" },
  { "[r", "<plug>(vimtex-[r)", mode = { "n", "o" }, desc = "VimTeX: Previous frame environment start" },
  { "[R", "<plug>(vimtex-[R)", mode = { "n", "o" }, desc = "VimTeX: Previois frame environment end" },

  { "]/", "<plug>(vimtex-]/)", mode = { "n", "o" }, desc = "VimTeX: Next LaTeX comment start" },
  { "]*", "<plug>(vimtex-]star)", mode = { "n", "o" }, desc = "VimTeX: Next LaTeX comment end" },
  { "[/", "<plug>(vimtex-[/)", mode = { "n", "o" }, desc = "VimTeX: Previous LaTeX comment start" },
  { "[*", "<plug>(vimtex-[star)", mode = { "n", "o" }, desc = "VimTeX: Previous LaTeX comment end" },

  -- VimTeX command mappings (using <localleader> in normal mode).
  { "<localleader>vc", "<plug>(vimtex-context-menu)", mode = { "n" }, desc = "Vimtex: Show context menu" },
  { "<localleader>vi", "<plug>(vimtex-info)", mode = { "n" }, desc = "Vimtex: Show project info" },
  { "<localleader>vI", "<plug>(vimtex-info-full)", mode = { "n" }, desc = "Vimtex: Show info for all projects" },
  { "<localleader>vd", "<plug>(vimtex-doc-package)", mode = { "n" }, desc = "Vimtex: Show package documentation" },
  { "<localleader>vr", ":VimtexRefreshFolds<CR>", mode = { "n" }, desc = "Vimtex: Refresh folds" },
  { "<localleader>vt", "<plug>(vimtex-toc-open)", mode = { "n" }, desc = "Vimtex: Open table of contents" },
  { "<localleader>vT", "<plug>(vimtex-toc-toggle)", mode = { "n" }, desc = "Vimtex: Toggle table of contents" },

  { "<localleader>vl", "<plug>(vimtex-log)", mode = { "n" }, desc = "Vimtex: Open log" },
  {
    "<localleader>vC",
    "<plug>(vimtex-compile)",
    mode = { "n" },
    desc = "Vimtex: Compile (toggle continuous or single shot)",
  },
  { "<localleader>vS", "<plug>(vimtex-compile-ss)", mode = { "n" }, desc = "Vimtex: Single shot compile" },
  { "<localleader>vcs", "<plug>(vimtex-compile-selected)", mode = { "v" }, desc = "Vimtex: Compile selected text" },
  { "<localleader>vo", "<plug>(vimtex-compile-output)", mode = { "n" }, desc = "Vimtex: show compile output" },

  { "<localleader>vs", "<plug>(vimtex-stop)", mode = { "n" }, desc = "Vimtex: Stop compilation" },
  { "<localleader>vA", "<plug>(vimtex-stop-all)", mode = { "n" }, desc = "Vimtex: Stop all compilations" },
  { "<localleader>vst", "<plug>(vimtex-status)", mode = { "n" }, desc = "Vimtex: Show compilation status" },
  {
    "<localleader>vST",
    "<plug>(vimtex-status-all)",
    mode = { "n" },
    desc = "Vimtex: Show status for all projects",
  },

  { "<localleader>vcn", "<plug>(vimtex-clean)", mode = { "n" }, desc = "Vimtex: clean auxiliary files" },
  {
    "<localleader>vCN",
    "<plug>(vimtex-clean-full)",
    mode = { "n" },
    desc = "Vimtex: Clean auxiliary and output files",
  },
  { "<localleader>ve", "<plug>(vimtex-errors)", mode = { "n" }, desc = "Vimtex: Show errors/warnings" },
  { "<localleader>vv", "<plug>(vimtex-view)", mode = { "n" }, desc = "Vimtex: View PDF" },
  { "<localleader>vrd", "<plug>(vimtex-reload)", mode = { "n" }, desc = "Vimtex: Reload VimTeX scripts" },
  {
    "<localleader>vrs",
    "<plug>(vimtex-reload-state)",
    mode = { "n" },
    desc = "Vimtex: Reload state for current buffer",
  },

  { "<localleader>vwl", ":VimtexCountLetters<CR>", mode = { "n" }, desc = "Vimtex: Count letters/characters" },
  { "<localleader>vww", ":VimtexCountWords<CR>", mode = { "n" }, desc = "Vimtex: Count words" },
  { "<localleader>vWL", ":VimtexCountLetters!<CR>", mode = { "n" }, desc = "Vimtex: Count letters detailed" },
  { "<localleader>vWW", ":VimtexCountWords!<CR>", mode = { "n" }, desc = "Vimtex: Count words detailed" },

  { "<localleader>vim", "<plug>(vimtex-imaps-list)", mode = { "n" }, desc = "Vimtex: List insert mode mappings" },
  { "<localleader>vtm", "<plug>(vimtex-toggle-main)", mode = { "n" }, desc = "Vimtex: Toggle main file" },
  {
    "<localleader>vcc",
    ":VimtexClearCache ",
    mode = { "n" },
    desc = "Vimtex: Clear cache (specify name)",
    opts = { silent = false },
  },
}

-- Iterate over the unified keymaps table to set each mapping buffer–locally.
for _, map in ipairs(keymaps) do
  local opts = { buffer = bufnr, silent = true, desc = map.desc }
  if map.opts then
    for k, v in pairs(map.opts) do
      opts[k] = v
    end
  end
  vim.keymap.set(map.mode, map[1], map[2], opts)
end
