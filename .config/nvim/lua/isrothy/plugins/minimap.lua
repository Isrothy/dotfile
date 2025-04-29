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
        get_buffers = function(args) return tonumber(args.buf) end,
      },
    },
    {
      event = "WinScrolled",
      opts = {
        get_buffers = function()
          local winid = vim.api.nvim_get_current_win()
          local bufnr = vim.api.nvim_win_get_buf(winid)
          return bufnr
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
    local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, { details = true })
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
  version = "v3.x.x",
  lazy = false,
  keys = {
    { "<LEADER>mrr", "<CMD>Neominimap Refresh<CR>", desc = "Refresh global minimap" },
    { "<LEADER>mrw", "<CMD>Neominimap WinRefresh<CR>", desc = "Refresh minimap for current window" },
    { "<LEADER>mrt", "<CMD>Neominimap TabRefresh<CR>", desc = "Refresh minimap for current tab" },
    { "<LEADER>mrb", "<CMD>Neominimap BufRefresh<CR>", desc = "Refresh minimap for current buffer" },
  },

  init = function()
    -- vim.opt.wrap = false
    -- vim.opt.sidescrolloff = 36

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      group = vim.api.nvim_create_augroup("setup_neominimap", { clear = true }),
      callback = function()
        Snacks.toggle({
          name = "minimap",
          get = function() return require("neominimap.api").enabled() end,
          set = function(state)
            if state then
              require("neominimap.api").enable()
            else
              require("neominimap.api").disable()
            end
          end,
        }):map("<LEADER>mm")
        Snacks.toggle({
          name = "minimap for buffer",
          get = function() return require("neominimap.api").buf.enabled() end,
          set = function(state)
            if state then
              require("neominimap.api").buf.enable()
            else
              require("neominimap.api").buf.disable()
            end
          end,
        }):map("<LEADER>mb")
        Snacks.toggle({
          name = "minimap for window",
          get = function() return require("neominimap.api").win.enabled() end,
          set = function(state)
            if state then
              require("neominimap.api").win.enable()
            else
              require("neominimap.api").win.disable()
            end
          end,
        }):map("<LEADER>mw")
        Snacks.toggle({
          name = "minimap for tabpage",
          get = function() return require("neominimap.api").tab.enabled() end,
          set = function(state)
            if state then
              require("neominimap.api").tab.enable()
            else
              require("neominimap.api").tab.disable()
            end
          end,
        }):map("<LEADER>mt")
        Snacks.toggle({
          name = "focus",
          get = function() return vim.bo.ft == "neominimap" end,
          set = function(state)
            if state then
              require("neominimap.api").focus.enable()
            else
              require("neominimap.api").focus.disable()
            end
          end,
        }):map("<LEADER>mf")
      end,
    })

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
        enabled = false,
        auto_switch_focus = true,
      },
      buffer = {
        persist = false,
      },
      layout = "split",
      split = {
        direction = "right",
        close_if_last_window = true,
        fix_width = false,
        minimap_width = 20,
        persist = false,
      },
      float = {
        minimap_width = 22,
        window_border = { "▏", "", "", "", "", "", "▏", "▏" },
        persist = false,
      },
      diagnostic = {
        enabled = true,
        use_event_diagnostics = true,
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
      winopt = function(wo)
        wo.statuscolumn = "%s"
        wo.signcolumn = "yes:1"
      end,
      buf_filter = function(bufnr) return vim.api.nvim_buf_line_count(bufnr) < 4096 end,
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
