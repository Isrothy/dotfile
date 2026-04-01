vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local lint = require("lint")

    local events = { "BufWritePost", "BufReadPost", "InsertLeave" }

    lint.linters_by_ft = {
      ["bash"] = { "shellcheck" },
      ["cmake"] = { "cmakelint" },
      ["dockerfile"] = { "hadolint" },
      ["make"] = { "checkmake" },
      ["markdown"] = { "markdownlint" },
      ["sh"] = { "shellcheck" },
      ["zsh"] = { "zsh" },
    }

    local function debounce(ms, fn)
      local timer = vim.uv.new_timer()
      if timer == nil then
        vim.notify("Failed to create timer", vim.log.levels.WARN, { title = "nvim-lint" })
        return
      end
      return function(...)
        local argv = { ... }
        timer:start(ms, 0, function()
          timer:stop()
          vim.schedule_wrap(fn)(unpack(argv))
        end)
      end
    end

    vim.api.nvim_create_autocmd(events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = debounce(100, function() lint.try_lint() end),
    })
  end,
})
