-- Expand a node and load filesystem info if needed.
local function open_dir(state, dir_node)
  local fs = require("neo-tree.sources.filesystem")
  fs.toggle_directory(state, dir_node, nil, true, false)
end

-- Expand a node and all its children, optionally stopping at max_depth.
local function recursive_open(state, node, max_depth)
  local max_depth_reached = 1
  local stack = { node }
  while next(stack) ~= nil do
    node = table.remove(stack)
    if node.type == "directory" and not node:is_expanded() then
      open_dir(state, node)
    end

    local depth = node:get_depth()
    max_depth_reached = math.max(depth, max_depth_reached)

    if not max_depth or depth < max_depth - 1 then
      local children = state.tree:get_nodes(node:get_id())
      for _, v in ipairs(children) do
        table.insert(stack, v)
      end
    end
  end

  return max_depth_reached
end

--- Open the fold under the cursor, recursing if count is given.
local function neotree_zo(state, open_all)
  local node = state.tree:get_node()

  if open_all then
    recursive_open(state, node)
  else
    recursive_open(state, node, node:get_depth() + vim.v.count1)
  end

  local renderer = require("neo-tree.ui.renderer")
  renderer.redraw(state)
end

--- Recursively open the current folder and all folders it contains.
local function neotree_zO(state) neotree_zo(state, true) end

-- The nodes inside the root folder are depth 2.
local MIN_DEPTH = 2

--- Close the node and its parents, optionally stopping at max_depth.
local function recursive_close(state, node, max_depth)
  if max_depth == nil or max_depth <= MIN_DEPTH then
    max_depth = MIN_DEPTH
  end

  local last = node
  while node and node:get_depth() >= max_depth do
    if node:has_children() and node:is_expanded() then
      node:collapse()
    end
    last = node
    node = state.tree:get_node(node:get_parent_id())
  end

  return last
end

--- Close a folder, or a number of folders equal to count.
local function neotree_zc(state, close_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  local max_depth
  if not close_all then
    max_depth = node:get_depth() - vim.v.count1
    if node:has_children() and node:is_expanded() then
      max_depth = max_depth + 1
    end
  end

  local last = recursive_close(state, node, max_depth)
  local renderer = require("neo-tree.ui.renderer")
  renderer.redraw(state)
  renderer.focus_node(state, last:get_id())
end

-- Close all containing folders back to the top level.
local function neotree_zC(state) neotree_zc(state, true) end

--- Open a closed folder or close an open one, with an optional count.
local function neotree_za(state, toggle_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  if node.type == "directory" and not node:is_expanded() then
    neotree_zo(state, toggle_all)
  else
    neotree_zc(state, toggle_all)
  end
end

--- Recursively close an open folder or recursively open a closed folder.
local function neotree_zA(state) neotree_za(state, true) end

--- Set depthlevel, analagous to foldlevel, for the neo-tree file tree.
local function set_depthlevel(state, depthlevel)
  if depthlevel < MIN_DEPTH then
    depthlevel = MIN_DEPTH
  end

  local stack = state.tree:get_nodes()
  while next(stack) ~= nil do
    local node = table.remove(stack)

    if node.type == "directory" then
      local should_be_open = depthlevel == nil or node:get_depth() < depthlevel
      if should_be_open and not node:is_expanded() then
        open_dir(state, node)
      elseif not should_be_open and node:is_expanded() then
        node:collapse()
      end
    end

    local children = state.tree:get_nodes(node:get_id())
    for _, v in ipairs(children) do
      table.insert(stack, v)
    end
  end

  vim.b.neotree_depthlevel = depthlevel
end

--- Refresh the tree UI after a change of depthlevel.
-- @bool stay Keep the current node revealed and selected
local function redraw_after_depthlevel_change(state, stay)
  local node = state.tree:get_node()

  if stay then
    require("neo-tree.ui.renderer").expand_to_node(state.tree, node)
  else
    -- Find the closest parent that is still visible.
    local parent = state.tree:get_node(node:get_parent_id())
    while not parent:is_expanded() and parent:get_depth() > 1 do
      node = parent
      parent = state.tree:get_node(node:get_parent_id())
    end
  end

  local renderer = require("neo-tree.ui.renderer")
  renderer.redraw(state)
  renderer.focus_node(state, node:get_id())
end

--- Update all open/closed folders by depthlevel, then reveal current node.
local function neotree_zx(state)
  set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
  redraw_after_depthlevel_change(state, true)
end

--- Update all open/closed folders by depthlevel.
local function neotree_zX(state)
  set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
  redraw_after_depthlevel_change(state, false)
end

-- Collapse more folders: decrease depthlevel by 1 or count.
local function neotree_zm(state)
  local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
  set_depthlevel(state, depthlevel - vim.v.count1)
  redraw_after_depthlevel_change(state, false)
end

-- Collapse all folders. Set depthlevel to MIN_DEPTH.
local function neotree_zM(state)
  set_depthlevel(state, MIN_DEPTH)
  redraw_after_depthlevel_change(state, false)
end

-- Expand more folders: increase depthlevel by 1 or count.
local function neotree_zr(state)
  local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
  set_depthlevel(state, depthlevel + vim.v.count1)
  redraw_after_depthlevel_change(state, false)
end

-- Expand all folders. Set depthlevel to the deepest node level.
local function neotree_zR(state)
  local top_level_nodes = state.tree:get_nodes()

  local max_depth = 1
  for _, node in ipairs(top_level_nodes) do
    max_depth = math.max(max_depth, recursive_open(state, node))
  end

  vim.b.neotree_depthlevel = max_depth
  redraw_after_depthlevel_change(state, false)
end

local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = { "Neotree" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
    keys = {
      {
        "<LEADER>ee",
        function() require("neo-tree.command").execute({ toggle = true }) end,
        desc = "NeoTree filesystem",
      },
      {
        "<LEADER>be",
        function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end,
        desc = "Explore buffers",
      },
      {
        "<LEADER>ge",
        function() require("neo-tree.command").execute({ source = "git_status", toggle = true }) end,
        desc = "Explore git status",
      },
      { "<LEADER>er", "<CMD>Neotree reveal<CR>", desc = "Reveal in Neo-tree" },
      {
        "<leader>eE",
        function() require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() }) end,
        desc = "Explorer current directory",
      },
    },
    opts = function()
      local events = require("neo-tree.events")
      return {
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "neominimap" },

        source_selector = {
          winbar = true, -- toggle to show selector on winbar
          statusline = true, -- toggle to show selector on statusline
          content_layout = "center", -- only with `tabs_layout` = "equal", "focus"
          separator = "", -- can be string or table, see below
        },
        default_component_configs = {
          git_status = {
            symbols = {
              -- Change type
              added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = "✖", -- this can only be used in the git_status source
              renamed = "󰁕", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
          },
          symlink_target = {
            enabled = true,
          },
        },
        window = {
          width = 36,
          auto_expand_width = false,
          mappings = {
            ["<ESC>"] = function() vim.cmd("nohl") end,
            ["<SPACE>"] = "none",
            ["<TAB>"] = function(state)
              local node = state.tree:get_node()
              if require("neo-tree.utils").is_expandable(node) then
                state.commands["toggle_node"](state)
              else
                state.commands["open_with_window_picker"](state)
                vim.cmd("Neotree reveal")
              end
            end,
            ["a"] = "none",
            ["A"] = "none",
            ["t"] = "none",
            ["s"] = "none",
            ["v"] = "none",
            ["y"] = "none",
            ["x"] = "none",
            ["p"] = "none",
            ["P"] = "none",
            ["c"] = "none",
            ["m"] = "none",
            ["q"] = "none",
            ["r"] = "none",
            ["b"] = "none",
            ["i"] = "none",

            ["<LOCALLEADER>t"] = "open_tabnew",
            ["<LOCALLEADER>s"] = "split_with_window_picker",
            ["<LOCALLEADER>v"] = "vsplit_with_window_picker",
            ["<LOCALLEADER>a"] = {
              "add",
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "relative", -- "none", "relative", "absolute"
              },
            },
            ["<LOCALLEADER>y"] = "copy_to_clipboard",
            ["<LOCALLEADER>x"] = "cut_to_clipboard",
            ["<LOCALLEADER>p"] = "paste_from_clipboard",
            ["<LOCALLEADER>c"] = {
              "copy",
              config = {
                show_path = "relative", -- "none", "relative", "absolute"
              },
            },
            ["<LOCALLEADER>P"] = {
              "toggle_preview",
              config = { use_float = true, use_image_nvim = true },
            },
            ["<LOCALLEADER>m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["<LOCALLEADER>q"] = "close_window",
            ["<LOCALLEADER>R"] = "refresh",
            ["<LOCALLEADER>i"] = "show_file_details",
            ["<LOCALLEADER>r"] = "rename",
            ["<LOCALLEADER>b"] = "rename_basename",

            ["h"] = "",
            ["l"] = "",

            ["z"] = "none",

            ["zo"] = neotree_zo,
            ["zO"] = neotree_zO,
            ["zc"] = neotree_zc,
            ["zC"] = neotree_zC,
            ["za"] = neotree_za,
            ["zA"] = neotree_zA,
            ["zx"] = neotree_zx,
            ["zX"] = neotree_zX,
            ["zm"] = neotree_zm,
            ["zM"] = neotree_zM,
            ["zr"] = neotree_zr,
            ["zR"] = neotree_zR,
            ["<M-h>"] = "none",
            ["<M-j>"] = "none",
            ["<M-k>"] = "none",
            ["<M-l>"] = "none",
          },
        },
        filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = false,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            never_show = { -- remains hidden even if visible is toggled to true
              ".DS_Store",
              "thumbs.db",
            },
          },
          hijack_netrw_behavior = "disabled", -- netrw disabled, opening a directory opens neo-tree
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["<LOCALLEADER>e"] = "run_command",
              ["[c"] = "prev_git_modified",
              ["]c"] = "next_git_modified",
              ["<LOCALLEADER>gA"] = "git_add_all",
              ["<LOCALLEADER>gu"] = "git_unstage_file",
              ["<LOCALLEADER>ga"] = "git_add_file",
              ["<LOCALLEADER>gr"] = "git_revert_file",
              ["<LOCALLEADER>gc"] = "git_commit",
              ["<LOCALLEADER>gp"] = "git_push",
              ["<LOCALLEADER>gg"] = "git_commit_and_push",
              ["<LOCALLEADER>I"] = "image_preview",

              ["<LOCALLEADER>H"] = "toggle_hidden",
              ["<LOCALLEADER>/"] = "fuzzy_finder",
              ["<LOCALLEADER>D"] = "fuzzy_finder_directory",
              ["<LOCALLEADER>#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              ["<LOCALLEADER>f"] = "filter_on_submit",
              ["<LOCALLEADER><c-x>"] = "clear_filter",
              ["<LOCALLEADER>o"] = {
                "show_help",
                nowait = false,
                config = { title = "Order by", prefix_key = "<LOCALLEADER>o" },
              },
              ["<LOCALLEADER>oc"] = { "order_by_created", nowait = false },
              ["<LOCALLEADER>od"] = { "order_by_diagnostics", nowait = false },
              ["<LOCALLEADER>og"] = { "order_by_git_status", nowait = false },
              ["<LOCALLEADER>om"] = { "order_by_modified", nowait = false },
              ["<LOCALLEADER>on"] = { "order_by_name", nowait = false },
              ["<LOCALLEADER>os"] = { "order_by_size", nowait = false },
              ["<LOCALLEADER>ot"] = { "order_by_type", nowait = false },

              ["H"] = "none",
              ["/"] = "none",
              ["D"] = "none",
              ["#"] = "none",
              ["f"] = "none",
              ["<c-x>"] = "none",
              ["[g"] = "none",
              ["]g"] = "none",
              ["o"] = "none",
              ["oc"] = "none",
              ["od"] = "none",
              ["og"] = "none",
              ["om"] = "none",
              ["on"] = "none",
              ["os"] = "none",
              ["ot"] = "none",
            },
          },
          commands = {
            run_command = function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.api.nvim_input(": " .. path .. "<Home>")
            end,
            image_preview = function(state)
              local node = state.tree:get_node()
              if node.type == "file" then
                require("image_preview").PreviewImage(node.path)
              end
            end,
          },
        },
        buffers = {
          follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          -- time the current file is changed while the tree is open.
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {

              ["<LOCALLEADER>d"] = "buffer_delete",
              ["<BS>"] = "navigate_up",
              ["."] = "set_root",
              ["<LOCALLEADER>o"] = {
                "show_help",
                nowait = false,
                config = { title = "Order by", prefix_key = "<LOCALLEADER>o" },
              },
              ["<LOCALLEADER>oc"] = { "order_by_created", nowait = false },
              ["<LOCALLEADER>od"] = { "order_by_diagnostics", nowait = false },
              ["<LOCALLEADER>og"] = { "order_by_git_status", nowait = false },
              ["<LOCALLEADER>om"] = { "order_by_modified", nowait = false },
              ["<LOCALLEADER>on"] = { "order_by_name", nowait = false },
              ["<LOCALLEADER>os"] = { "order_by_size", nowait = false },
              ["<LOCALLEADER>ot"] = { "order_by_type", nowait = false },

              ["<LOCALLEADER>gA"] = "git_add_all",
              ["<LOCALLEADER>gu"] = "git_unstage_file",
              ["<LOCALLEADER>ga"] = "git_add_file",
              ["<LOCALLEADER>gr"] = "git_revert_file",
              ["<LOCALLEADER>gc"] = "git_commit",
              ["<LOCALLEADER>gp"] = "git_push",
              ["<LOCALLEADER>gg"] = "git_commit_and_push",

              ["bd"] = "none",
              ["o"] = "none",
              ["oc"] = "none",
              ["od"] = "none",
              ["om"] = "none",
              ["on"] = "none",
              ["os"] = "none",
              ["ot"] = "none",
            },
          },
        },

        git_status = {
          window = {
            mappings = {
              ["<LOCALLEADER>gu"] = "git_unstage_file",
              ["<LOCALLEADER>ga"] = "git_add_file",
              ["<LOCALLEADER>gr"] = "git_revert_file",
              ["<LOCALLEADER>gc"] = "git_commit",
              ["<LOCALLEADER>gp"] = "git_push",
              ["<LOCALLEADER>gg"] = "git_commit_and_push",
              ["<LOCALLEADER>gA"] = "git_add_all",

              ["<LOCALLEADER>o"] = {
                "show_help",
                nowait = false,
                config = { title = "Order by", prefix_key = "<LOCALLEADER>o" },
              },
              ["<LOCALLEADER>oc"] = { "order_by_created", nowait = false },
              ["<LOCALLEADER>od"] = { "order_by_diagnostics", nowait = false },
              ["<LOCALLEADER>og"] = { "order_by_git_status", nowait = false },
              ["<LOCALLEADER>om"] = { "order_by_modified", nowait = false },
              ["<LOCALLEADER>on"] = { "order_by_name", nowait = false },
              ["<LOCALLEADER>os"] = { "order_by_size", nowait = false },
              ["<LOCALLEADER>ot"] = { "order_by_type", nowait = false },

              ["A"] = "none",
              ["gu"] = "none",
              ["ga"] = "none",
              ["gr"] = "none",
              ["gc"] = "none",
              ["gp"] = "none",
              ["gg"] = "none",
              ["o"] = "none",
              ["oc"] = "none",
              ["od"] = "none",
              ["om"] = "none",
              ["on"] = "none",
              ["os"] = "none",
              ["ot"] = "none",
            },
          },
        },
        event_handlers = {
          { event = events.FILE_MOVED, handler = on_move },
          { event = events.FILE_RENAMED, handler = on_move },
          {
            event = "neo_tree_popup_input_ready",
            handler = function() vim.cmd("stopinsert") end,
          },
          {
            event = "neo_tree_popup_input_ready",
            ---@param args { bufnr: integer, winid: integer }
            handler = function(args)
              vim.keymap.set("i", "<ESC>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
            end,
          },
        },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    deactivate = function() vim.cmd([[Neotree close]]) end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Oil" },
    keys = {
      { "<F3>", "<CMD>Oil<CR>", desc = "Oil" },
    },
    opts = {
      columns = {
        "icon",
        "permissions",
        -- "size",
        -- "mtime",
      },
      keymaps = {
        ["<LOCALLEADER>?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<LOCALLEADER>v"] = "actions.select_vsplit",
        ["<LOCALLEADER>s"] = "actions.select_split",
        ["<LOCALLEADER>t"] = "actions.select_tab",
        ["<LOCALLEADER>p"] = "actions.preview",
        ["<LOCALLEADER>c"] = "actions.close",
        ["<LEADLIEADER>r"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["<BS>"] = "actions.parent",
        ["<LOCALLEADER>u"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["<LOCALLEADER>o"] = "actions.change_sort",
        ["<LOCALLEADER>x"] = "actions.open_external",
        ["<LOCALLEADER>."] = "actions.toggle_hidden",
        ["<LOCALLEADER>\\"] = "actions.toggle_trash",
        ["<TAB>"] = {
          callback = function()
            local oil = require("oil")
            local bufnr = vim.api.nvim_get_current_buf()
            local entry = oil.get_cursor_entry()
            if entry == nil or entry.type ~= "file" then
              return
            end
            --- pick a window by using window-picker plugin.
            local win = require("window-picker").pick_window({
              autoselect_one = true,
              -- hint = 'floating-big-letter',
              include_current_win = true,
            })

            if win then
              local lnum = vim.api.nvim_win_get_cursor(0)[1]
              local winnr = vim.api.nvim_win_get_number(win)
              vim.cmd(winnr .. "windo buffer " .. bufnr)
              vim.api.nvim_win_call(win, function()
                vim.api.nvim_win_set_cursor(win, { lnum, 1 })
                oil.select({
                  close = false,
                }, function() end)
              end)
              return
            end
          end,
        },
        ["<LOCALLEADER>f"] = {
          callback = function()
            local oil = require("oil")

            -- get the current directory
            local prefills = { paths = oil.get_current_dir() }

            local grug_far = require("grug-far")
            -- instance check
            if not grug_far.has_instance("explorer") then
              grug_far.open({
                instanceName = "explorer",
                prefills = prefills,
                staticTitle = "Find and Replace from Explorer",
              })
            else
              grug_far.open_instance("explorer")
              -- updating the prefills without clearing the search and other fields
              grug_far.update_instance_prefills("explorer", prefills, false)
            end
          end,
          desc = "Oil: Search in directory",
        },
      },
      use_default_keymaps = false,
    },
  },
}
