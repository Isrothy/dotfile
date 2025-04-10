return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "svelte",
    "astro",
  },
  root_markers = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
  },
  single_file_support = true,
  settings = {
    validate = "on",
    packageManager = nil,
    useESLintClass = false,
    experimental = { useFlatConfig = false },
    codeActionOnSave = {
      enable = false,
      mode = "all",
    },
    format = true,
    quiet = false,
    onIgnoredFiles = "off",
    rulesCustomizations = {},
    run = "onType",
    problems = {
      shortenToSingleLine = false,
    },
    nodePath = "",
    workingDirectory = { mode = "location" },
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
  on_new_config = function(config, new_root_dir)
    config.settings.workspaceFolder = {
      uri = new_root_dir,
      name = vim.fn.fnamemodify(new_root_dir, ":t"),
    }
    if
      vim.fn.filereadable(new_root_dir .. "/eslint.config.js") == 1
      or vim.fn.filereadable(new_root_dir .. "/eslint.config.mjs") == 1
      or vim.fn.filereadable(new_root_dir .. "/eslint.config.cjs") == 1
      or vim.fn.filereadable(new_root_dir .. "/eslint.config.ts") == 1
      or vim.fn.filereadable(new_root_dir .. "/eslint.config.mts") == 1
      or vim.fn.filereadable(new_root_dir .. "/eslint.config.cts") == 1
    then
      config.settings.experimental.useFlatConfig = true
    end

    local pnp_cjs = new_root_dir .. "/.pnp.cjs"
    local pnp_js = new_root_dir .. "/.pnp.js"
    if vim.loop.fs_stat(pnp_cjs) or vim.loop.fs_stat(pnp_js) then
      config.cmd = vim.list_extend({ "yarn", "exec" }, config.cmd)
    end
  end,
  handlers = {
    ["eslint/openDoc"] = function(_, result)
      if result then
        vim.ui.open(result.url)
      end
      return {}
    end,
    ["eslint/confirmESLintExecution"] = function(_, result)
      if not result then
        return
      end
      return 4 -- approved
    end,
  },
}
