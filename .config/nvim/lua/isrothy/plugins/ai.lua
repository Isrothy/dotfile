local prefill_edit_window = function(request)
  require("avante.api").edit()
  local code_bufnr = vim.api.nvim_get_current_buf()
  local code_winid = vim.api.nvim_get_current_win()
  if code_bufnr == nil or code_winid == nil then
    return
  end
  vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
  vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
end

local avante_grammar_correction = "Correct the text to standard English, but keep any code blocks inside intact."
local avante_keywords = "Extract the main keywords from the following text"
local avante_code_readability_analysis = [[
    You must identify any readability issues in the code snippet.
    Some readability issues to consider:
    - Unclear naming
    - Unclear purpose
    - Redundant or obvious comments
    - Lack of comments
    - Long or complex one liners
    - Too much nesting
    - Long variable names
    - Inconsistent naming and code style.
    - Code repetition
    You may identify additional problems. The user submits a small section of code from a larger file.
    Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
    If there's no issues with code respond with only: <OK>
  ]]
local avante_optimize_code = "Optimize the following code"
local avante_summarize = "Summarize the following text"
local avante_translate = "Translate this into Chinese, but keep any code blocks inside intact"
local avante_explain_code = "Explain the following code"
local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
local avante_add_docstring = "Add docstring to the following codes"
local avante_fix_bugs = "Fix the bugs inside the following codes if any"
local avante_add_tests = "Implement tests for the following code"
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    keys = {
      { "<LEADER>ac", "<CMD>AvanteChat<CR>", desc = "Chat" },
      { "<LEADER>ak", "<CMD>AvanteClear<CR>", desc = "Clear" },
      { "<LEADER>aq", "", desc = "+Ask" },
      {
        "<leader>aqg",
        function() require("avante.api").ask({ question = avante_grammar_correction }) end,
        desc = "Grammar correction",
        mode = "v",
      },
      {
        "<leader>aqk",
        function() require("avante.api").ask({ question = avante_keywords }) end,
        desc = "Keywords",
        mode = "v",
      },
      {
        "<leader>aql",
        function() require("avante.api").ask({ question = avante_code_readability_analysis }) end,
        desc = "Code readability analysis",
        mode = "v",
      },
      {
        "<leader>aqo",
        function() require("avante.api").ask({ question = avante_optimize_code }) end,
        desc = "Optimize Code",
        mode = "v",
      },
      {
        "<leader>aqm",
        function() require("avante.api").ask({ question = avante_summarize }) end,
        desc = "Summarize text",
        mode = "v",
      },
      {
        "<leader>aqn",
        function() require("avante.api").ask({ question = avante_translate }) end,
        desc = "Translate text",
        mode = "v",
      },
      {
        "<leader>aqx",
        function() require("avante.api").ask({ question = avante_explain_code }) end,
        desc = "Explain code",
        mode = "v",
      },
      {
        "<leader>aqc",
        function() require("avante.api").ask({ question = avante_complete_code }) end,
        desc = "Complete code",
        mode = "v",
      },
      {
        "<leader>aqd",
        function() require("avante.api").ask({ question = avante_add_docstring }) end,
        desc = "Docstring",
        mode = "v",
      },
      {
        "<leader>aqb",
        function() require("avante.api").ask({ question = avante_fix_bugs }) end,
        desc = "Fix bugs",
        mode = "v",
      },
      {
        "<leader>aqu",
        function() require("avante.api").ask({ question = avante_add_tests }) end,
        desc = "Add tests",
        mode = "v",
      },
      {
        "<leader>aeg",
        function() prefill_edit_window(avante_grammar_correction) end,
        desc = "Grammar correction",
        mode = "v",
      },
      {
        "<leader>aek",
        function() prefill_edit_window(avante_keywords) end,
        desc = "Keywords",
        mode = "v",
      },
      {
        "<leader>aeo",
        function() prefill_edit_window(avante_optimize_code) end,
        desc = "Optimize code",
        mode = "v",
      },
      {
        "<leader>aec",
        function() prefill_edit_window(avante_complete_code) end,
        desc = "Complete Code",
        mode = "v",
      },
      {
        "<leader>aed",
        function() prefill_edit_window(avante_add_docstring) end,
        desc = "Docstring",
        mode = "v",
      },
      {
        "<leader>aeb",
        function() prefill_edit_window(avante_fix_bugs) end,
        desc = "Fix bugs",
        mode = "v",
      },
      {
        "<leader>aeu",
        function() prefill_edit_window(avante_add_tests) end,
        desc = "Add tests",
        mode = "v",
      },
    },
    opts = {
      provider = "gemini",
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-2.5-pro-exp-03-25",
        timeout = 30000,
        temperature = 0,
        max_tokens = 64000,
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet-20250219",
        timeout = 30000,
        temperature = 0,
        max_tokens = 64000,
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",
        timeout = 30000,
        temperature = 0.25,
        max_tokens = 4096,
      },
      web_search_engine = {
        provider = "google",
      },
      behaviour = {
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = true,
        support_paste_from_clipboard = true,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
        enable_token_counting = false, -- Whether to enable token counting. Default to true.
      },
      hints = { enabled = false },
      file_selector = { provider = "snacks" },
      mappings = {
        ask = "<LEADER>aqq",
        edit = "<LEADER>aee",
        refresh = "<LEADER>ar",
        focus = "<LEADER>af",
        stop = "<LEADER>ax",
        select_model = "<LEADER>a?",
        select_history = "<LEADER>ay",
        toggle = {
          default = "<LEADER>at",
          debug = "<LEADER>ad",
          hint = "<LEADER>ah",
          suggestion = "<LEADER>as",
          repomap = "<LEADER>am",
        },
        diff = {
          ours = "<LOCALLEADER>co",
          theirs = "<LOCALLEADER>ct",
          all_theirs = "<LOCALLEADER>cT",
          both = "<LOCALLEADER>cd",
          cursor = "<LOCALLEADER>cc",
          next = "]c",
          prev = "[c",
        },
        jump = {
          next = "]a",
          prev = "[a",
        },
        submit = {
          normal = "<CR>",
          insert = nil,
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
          remove_file = "d",
          add_file = "p",
          close = {},
          close_from_input = nil,
        },
        files = {
          add_current = "<LEADER>aa",
          add_all_buffers = "<LEADER>aA",
        },
      },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "left",
        sidebar_header = {
          enabled = true,
          align = "left",
          rounded = false,
        },
        edit = {
          border = "rounded",
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = false,
          border = "rounded",
          focus_on_apply = "ours",
        },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
    },
  },
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    keys = {
      { "<C-;>", function() require("neocodeium").accept() end, mode = { "i" } },
      { "<C-O>", function() require("neocodeium").accept_word() end, mode = { "i" } },
      { "<C-L>", function() require("neocodeium").accept_line() end, mode = { "i" } },
      { "<C-.>", function() require("neocodeium").cycle_or_complete() end, mode = { "i" } },
      { "<C-,>", function() require("neocodeium").cycle_or_complete(-1) end, mode = { "i" } },
      { "<C-'>", function() require("neocodeium").clear() end, mode = { "i" } },
    },
    opts = {
      enabled = true,
      show_label = false,
      debounce = true,
      silent = true,
      max_lines = -1,
      filetypes = {
        help = false,
        gitcommit = false,
        gitrebase = false,
        DressingInput = false,
        bigfile = false,
        snacks_picker_input = false,
        ["."] = false,
      },
      filter = function()
        local blink = require("blink.cmp")
        return not blink.is_visible()
      end,
    },
  },
}
