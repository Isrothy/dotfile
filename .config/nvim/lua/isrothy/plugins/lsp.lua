local border = "rounded"

local mason = {
  { "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {},
      ui = {
        border = border,
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
}

local lspconfig = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    -- "folke/neoconf.nvim",
    "folke/noice.nvim",
  },
  event = { "VeryLazy" },
  lazy = vim.fn.argc(-1) == 0,
  config = function()
    -- require("neoconf").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup()

    require("lspconfig").bashls.setup({})
    require("lspconfig").clangd.setup({
      capabilities = vim.tbl_extend(
        "force",
        require("blink.cmp").get_lsp_capabilities(),
        { offsetEncoding = "utf-16" }
      ),
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
          "Makefile",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "meson.build",
          "meson_options.txt",
          "build.ninja"
        )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname)
      end,
      cmd = {
        "/opt/homebrew/opt/llvm/bin/clangd",
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
    require("lspconfig").neocmake.setup({})
    require("lspconfig").cssls.setup({})
    require("lspconfig").dockerls.setup({})
    require("lspconfig").emmet_ls.setup({})
    require("lspconfig").eslint.setup({})
    require("lspconfig").fennel_language_server.setup({})
    require("lspconfig").gradle_ls.setup({})
    require("lspconfig").html.setup({})
    require("lspconfig").kotlin_language_server.setup({
      single_file_support = true,
    })
    require("lspconfig").texlab.setup({
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
    })
    require("lspconfig").lua_ls.setup({
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
    require("lspconfig").basedpyright.setup({
      settings = {
        basedpyright = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
          },
        },
      },
    })
    require("lspconfig").r_language_server.setup({})
    require("lspconfig").sourcekit.setup({
      filetypes = { "swift", "objective-c" },
      single_file_support = true,
    })
    require("lspconfig").tinymist.setup({
      single_file_support = true,
    })
    require("lspconfig").vimls.setup({})
  end,
}

local clangd = {
  "p00f/clangd_extensions.nvim",
  ft = { "c", "cpp", "objc", "objcpp" },
  config = function()
    require("clangd_extensions").setup({
      inlay_hints = {
        inline = vim.fn.has("nvim-0.10") == 1,
        only_current_line = false,
        only_current_line_autocmd = "CursorHold",
        show_parameter_hints = true,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
        priority = 100,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },

        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },

        highlights = {
          detail = "Comment",
        },
      },
      memory_usage = {
        border = border,
      },
      symbol_info = {
        border = border,
      },
    })
  end,
}

local java = {
  "nvim-java/nvim-java",
  ft = "java",
  cmd = {
    "JavaBuildBuildWorkspace",
    "JavaBuildCleanWorkspace",
    "JavaRunnerRunMain",
    "JavaRunnerStopMain",
    "JavaRunnerToggleLogs",
    "JavaDapConfig",
    "JavaTestRunCurrentClass",
    "JavaTestDebugCurrentClass",
    "JavaTestRunCurrentMethod",
    "JavaTestDebugCurrentMethod",
    "JavaTestViewLastReport",
    "JavaProfile",
    "JavaRefactorExtractVariable",
    "JavaRefactorExtractVariableAllOccurrence",
    "JavaRefactorExtractConstant",
    "JavaRefactorExtractMethod",
    "JavaRefactorExtractField",
    "JavaSettingsChangeRuntime",
  },
  config = function()
    require("java").setup({
      spring_boot_tools = {
        enable = false,
      },
      jdk = {
        auto_install = false,
      },
    })
    require("lspconfig").jdtls.setup({
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-23",
                path = "/opt/homebrew/opt/openjdk@23",
                default = true,
              },
            },
          },
        },
      },
    })
  end,
}

local haskell_tools = {
  "MrcJkb/haskell-tools.nvim",
  version = "^4",
  ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  keys = {
    { "<LOCALLEADER>h", "", desc = "+Haskell tools" },
    {
      "<LOCALEADER>he",
      function() require("haskell-tools").lsp.buf_eval_all() end,
      desc = "Evaluate all",
      ft = { "haskell", "lhaskell" },
    },
    { "<LOCALLEADER>hr", "", desc = "+REPL" },
    {
      "<LOCALLEADER>hh",
      function() require("haskell-tools").hoogle.hoogle_signature() end,
      desc = "Hoogle signature",
      ft = { "haskell", "lhaskell" },
    },
    {
      "<LOCALLEADER>hrt",
      function() require("haskell-tools").repl.toggle() end,
      desc = "Toggle repl",
      ft = { "haskell", "lhaskell" },
    },
    {
      "<LOCALLEADER>hrb",
      function() require("haskell-tools").repl.toggle(vim.api.nvim_buf_get_name(0)) end,
      desc = "Toggle repl for current buffer",
      ft = { "haskell", "lhaskell" },
    },
    {
      "<LOCALLEADER>hrr",
      function() require("haskell-tools").repl.reload() end,
      desc = "Reload repl",
      ft = { "haskell", "lhaskell" },
    },
    {
      "<LOCALLEADER>hrq",
      function() require("haskell-tools").repl.quit() end,
      desc = "Quit repl",
      ft = { "haskell", "lhaskell" },
    },
    { "<LOCALLEADER>hr", "", desc = "+Project" },
    {
      "<LOCALLEADER>hpp",
      function() require("haskell-tools").project.open_project_file() end,
      desc = "Open project file",
      ft = { "haskell", "lhaskell" },
    },
    {
      "<LOCALLEADER>hpy",
      function() require("haskell-tools").project.open_package_yaml() end,
      desc = "Open project yaml",
      ft = { "haskell", "lhaskell" },
    },
    {
      "<LOCALLEADER>hpc",
      function() require("haskell-tools").project.open_package_cabal() end,
      desc = "Open project cabal",
      ft = { "haskell", "lhaskell" },
    },
  },
  init = function()
    vim.g.haskell_tools = {
      tools = {
        repl = {
          -- 'builtin': Use the simple builtin repl
          -- 'toggleterm': Use akinsho/toggleterm.nvim
          handler = "toggleterm",
          builtin = {
            create_repl_window = function(view) return view.create_repl_split({ size = vim.o.lines / 3 }) end,
          },
        },
        hover = {
          stylize_markdown = true,
          auto_focus = false,
        },
        tags = {
          enable = false,
          package_events = { "BufWritePost" },
        },
      },
      hls = {
        default_settings = {
          haskell = {
            formattingProvider = "ormolu",
            checkProject = true,
          },
        },
      },
    }
  end,
}

local rustaceanvim = {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = { "rust" },
  init = function()
    vim.g.rustaceanvim = {
      tools = {},
      server = {
        settings = {
          ["rust-analyzer"] = {},
        },
      },
      dap = {},
    }
  end,
}

local schemastore = {
  "b0o/schemastore.nvim",
  ft = { "json", "jsonc", "yaml" },
  config = function()
    require("lspconfig").jsonls.setup({
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
    require("lspconfig").yamlls.setup({
      settings = {
        yaml = {
          schemaStore = {
            -- You must disable built-in schemaStore support if you want to use
            -- this plugin and its advanced options like `ignore`.
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    })
  end,
}

local typescript = {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "javascript",
    "javascriptreact",
    "javascript.jsx",
  },
  opts = {},
}

local null_ls = {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      border = border,
      sources = {
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.gitlint,
        null_ls.builtins.diagnostics.cmake_lint,

        null_ls.builtins.diagnostics.zsh,

        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.cmake_format,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.shellharden.with({
          filetypes = {
            "sh",
            "bash",
            "zsh",
          },
        }),
        null_ls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "mysql" },
        }),
        null_ls.builtins.formatting.typstyle,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.yamlfmt,

        -- null_ls.builtins.hover.dictionary,
      },
    })
  end,
}

return {
  mason,
  lspconfig,
  clangd,
  java,
  haskell_tools,
  rustaceanvim,
  typescript,
  null_ls,
  schemastore,
}
