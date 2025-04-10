return {
  { "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "black",
        "checkmake",
        "cmakelang",
        "hadolint",
        "markdownlint",
        "markdownlint-cli2",
        "prettier",
        "shellharden",
        "shfmt",
        "sqlfluff",
        "stylua",
        "stylua",
        "typstyle",
        "yamlfmt",
      },
      ui = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(
          function()
            require("lazy.core.handler.event").trigger({
              event = "FileType",
              buf = vim.api.nvim_get_current_buf(),
            })
          end,
          100
        )
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "folke/noice.nvim",
    },
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
    opts = {
      servers = {
        bashls = {},
        clangd = {
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            )
          end,
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
        },
        neocmake = {},
        texlab = {
          settings = {
            texlab = {
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
          },
        },
        lua_ls = {
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
        },
        basedpyright = {
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
        },
        sourcekit = {
          filetypes = { "swift", "objective-c" },
          single_file_support = true,
        },
        vimls = {},
      },
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-lspconfig").setup()

      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
}
