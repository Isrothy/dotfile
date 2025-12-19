return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    init = function()
      vim.lsp.config("basedpyright", {
        filetypes = { "python" },
        single_file_support = true,
        settings = {
          basedpyright = {
            typeCheckingMode = "basic",
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
      vim.lsp.config("clangd", {
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--clang-tidy-checks=performance-*,bugprone-*",
          "--all-scopes-completion",
          "--completion-style=bundled",
          "--header-insertion=iwyu",
          "-j=8",
          "--pch-storage=memory",
        },
      })
      vim.lsp.config("lua_ls", {
        filetypes = { "lua" },
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
                continuation_indent_size = "2",
              },
            },
            hint = {
              enable = true,
              setType = true,
            },
          },
        },
      })
      vim.lsp.config("sourcekit", {
        filetypes = { "swift", "objective-c" },
        single_file_support = true,
      })
      vim.lsp.config("textlab", {
        settings = {
          bibtexFormatter = "texlab",
          chktex = {
            onEdit = true,
            onOpenAndSave = true,
          },
          diagnosticsDelay = 300,
          formatterLineLength = 80,
          latexFormatter = "texlab",
          latexindent = {
            modifyLineBreaks = true,
          },
        },
      })
      vim.lsp.config("tinymist", {
        cmd = { "tinymist" },
        filetypes = { "typst" },
        single_file_support = true,
      })
      vim.lsp.enable({
        "basedpyright",
        "bashls",
        "clangd",
        "eslint",
        "jdtls",
        "jsonls",
        "lua_ls",
        "neocmake",
        "sourcekit",
        "texlab",
        "tinymist",
        "vimls",
        "yamlls",
      })
    end,
  },
}
