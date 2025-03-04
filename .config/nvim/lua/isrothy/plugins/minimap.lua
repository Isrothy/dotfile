---@module 'neominimap.config.meta'

---@type Neominimap.Map.Handler
local extmark_handler = {
  name = "Todo Comment",
  mode = "icon",
  namespace = vim.api.nvim_create_namespace("neominimap_todo_comment"),
  init = function() end,
  autocmds = {
    {
      event = { "TextChanged", "TextChangedI" },
      opts = {
        callback = function(apply, args)
          local bufnr = tonumber(args.buf) ---@cast bufnr integer
          vim.schedule(function() apply(bufnr) end)
        end,
      },
    },
    {
      event = "WinScrolled",
      opts = {
        callback = function(apply)
          local winid = vim.api.nvim_get_current_win()
          if not winid or not vim.api.nvim_win_is_valid(winid) then
            return
          end
          local bufnr = vim.api.nvim_win_get_buf(winid)
          vim.schedule(function()
            if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
              apply(bufnr)
            end
          end)
        end,
      },
    },
  },
  get_annotations = function(bufnr)
    local ok, _ = pcall(require, "todo-comments")
    if not ok then
      return {}
    end
    local ns_id = vim.api.nvim_get_namespaces()["todo-comments"]
    local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {
      details = true,
    })
    local icons = {
      FIX = " ",
      TODO = " ",
      HACK = " ",
      WARN = " ",
      PERF = " ",
      NOTE = " ",
      TEST = "⏲ ",
    }
    local id = { FIX = 1, TODO = 2, HACK = 3, WARN = 4, PERF = 5, NOTE = 6, TEST = 7 }
    return vim.tbl_map(function(extmark) ---@param extmark vim.api.keyset.get_extmark_item
      local detail = extmark[4] ---@type vim.api.keyset.extmark_details
      local group = detail.hl_group ---@type string
      local kind = string.sub(group, 7)
      local icon = icons[kind]
      ---@type Neominimap.Map.Handler.Annotation
      return {
        lnum = extmark[2],
        end_lnum = extmark[2],
        id = id[kind],
        highlight = "TodoFg" .. kind,
        icon = icon,
        priority = detail.priority,
      }
    end, extmarks)
  end,
}

---@param winid integer
---@return boolean
local is_float_window = function(winid) return vim.api.nvim_win_get_config(winid).relative ~= "" end

return {
  -- dir = "~/Developer/neominimap.nvim",
  "Isrothy/neominimap.nvim",
  enabled = true,
  version = "v3.x.x",
  lazy = false,
  keys = {
    -- Global Minimap Controls
    { "<LEADER>mm", "<CMD>Neominimap toggle<CR>", desc = "Toggle global minimap" },
    { "<LEADER>mo", "<CMD>Neominimap on<CR>", desc = "Enable global minimap" },
    { "<LEADER>mc", "<CMD>Neominimap off<CR>", desc = "Disable global minimap" },
    { "<LEADER>mr", "<CMD>Neominimap refresh<CR>", desc = "Refresh global minimap" },

    -- Window-Specific Minimap Controls
    { "<LEADER>mwt", "<CMD>Neominimap winToggle<CR>", desc = "Toggle minimap for current window" },
    { "<LEADER>mwr", "<CMD>Neominimap winRefresh<CR>", desc = "Refresh minimap for current window" },
    { "<LEADER>mwo", "<CMD>Neominimap winOn<CR>", desc = "Enable minimap for current window" },
    { "<LEADER>mwc", "<CMD>Neominimap winOff<CR>", desc = "Disable minimap for current window" },

    -- Tab-Specific Minimap Controls
    { "<LEADER>mtt", "<CMD>Neominimap tabToggle<CR>", desc = "Toggle minimap for current tab" },
    { "<LEADER>mtr", "<CMD>Neominimap tabRefresh<CR>", desc = "Refresh minimap for current tab" },
    { "<LEADER>mto", "<CMD>Neominimap tabOn<CR>", desc = "Enable minimap for current tab" },
    { "<LEADER>mtc", "<CMD>Neominimap tabOff<CR>", desc = "Disable minimap for current tab" },

    -- Buffer-Specific Minimap Controls
    { "<LEADER>mbt", "<CMD>Neominimap bufToggle<CR>", desc = "Toggle minimap for current buffer" },
    { "<LEADER>mbr", "<CMD>Neominimap bufRefresh<CR>", desc = "Refresh minimap for current buffer" },
    { "<LEADER>mbo", "<CMD>Neominimap bufOn<CR>", desc = "Enable minimap for current buffer" },
    { "<LEADER>mbc", "<CMD>Neominimap bufOff<CR>", desc = "Disable minimap for current buffer" },

    ---Focus Controls
    { "<LEADER>mf", "<CMD>Neominimap focus<CR>", desc = "Focus on minimap" },
    { "<LEADER>mu", "<CMD>Neominimap unfocus<CR>", desc = "Unfocus minimap" },
    { "<LEADER>ms", "<CMD>Neominimap toggleFocus<CR>", desc = "Switch focus on minimap" },
  },

  init = function()
    -- vim.opt.wrap = false
    -- vim.opt.sidescrolloff = 36

    ---@type Neominimap.UserConfig
    vim.g.neominimap = {
      auto_enable = true,
      log_level = vim.log.levels.OFF,
      notification_level = vim.log.levels.OFF,

      exclude_filetypes = {
        "qf",
        "neo-tree",
        "bigfile",
        "oil",
        "dbout",
      },
      x_multiplier = 4,
      sync_cursor = true,
      click = {
        enabled = true,
        auto_switch_focus = true,
      },
      layout = "split",
      split = {
        direction = "right",
        close_if_last_window = true,
        fix_width = true,
        minimap_width = 20,
      },
      float = {
        minimap_width = 22,
        window_border = { "▏", "", "", "", "", "", "▏", "▏" },
      },
      diagnostic = {
        enabled = true,
        severity = vim.diagnostic.severity.HINT,
        mode = "line",
      },
      git = {
        enabled = true,
        mode = "sign",
      },
      mark = {
        enabled = true,
        mode = "icon",
        show_builtins = true,
      },
      search = {
        enabled = true,
        mode = "sign",
      },
      treesitter = {
        enabled = true,
      },
      tab_filter = function(tab_id)
        local win_list = vim.api.nvim_tabpage_list_wins(tab_id)
        local exclude_ft = { "qf", "trouble", "neo-tree", "alpha", "neominimap", "snacks_dashboard" }
        for _, win_id in ipairs(win_list) do
          if not is_float_window(win_id) then
            local bufnr = vim.api.nvim_win_get_buf(win_id)
            if not vim.tbl_contains(exclude_ft, vim.bo[bufnr].filetype) then
              return true
            end
          end
        end
        return false
      end,
      ---@type Neominimap.Map.Handler[]
      handlers = {
        extmark_handler,
      },
    }
  end,
}
