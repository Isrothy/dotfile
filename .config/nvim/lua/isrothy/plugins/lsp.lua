-- local border = {
-- 	{ "", "FloatBorder" },
-- 	{ "", "FloatBorder" },
-- 	{ "", "FloatBorder" },
-- 	{ " ", "FloatBorder" },
-- 	{ "", "FloatBorder" },
-- 	{ "", "FloatBorder" },
-- 	{ "", "FloatBorder" },
-- 	{ " ", "FloatBorder" },
-- }

local map = vim.keymap.set

local border = "rounded"
local make_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.offsetEncoding = "utf-16"
	return capabilities
end

local set_keymap = function(_, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	map("n", "<leader>gD", vim.lsp.buf.declaration, bufopts)
	map("n", "<leader>gt", function()
		require("telescope.builtin").lsp_type_definitions({ jump_type = "never" })
	end, bufopts)

	map("n", "<leader>gd", function()
		require("telescope.builtin").lsp_definitions({ jump_type = "never" })
	end, bufopts)

	map("n", "<leader>gi", function()
		require("telescope.builtin").lsp_implementations({ jump_type = "never" })
	end, bufopts)

	map("n", "<leader>gr", function()
		require("telescope.builtin").lsp_references({
			include_declaration = false,
			include_current_line = false,
			jump_type = "never",
		})
	end, bufopts)

	map("n", "K", vim.lsp.buf.hover, bufopts)
	-- map("n", "K", '<cmd>lua require("pretty_hover").hover()<cr>', bufopts)
	map("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	map("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	map("n", "<Leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	map("n", "<leader>rn", function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, {
		noremap = true,
		silent = true,
		buffer = bufnr,
		expr = true,
	})
	map({ "n", "x" }, "<leader>ca", require("actions-preview").code_actions)
	-- map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
	map("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	-- range format
	map("v", "<leader>f", function()
		local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
		local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
		vim.lsp.buf.format({
			range = {
				["start"] = { start_row, 0 },
				["end"] = { end_row, 0 },
			},
			async = true,
		})
	end, bufopts)
end

local set_inlay_hint = function(client, bufnr)
	local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
	if inlay_hint and client.supports_method("textDocument/inlayHint") then
		inlay_hint.enable(bufnr, true)
	end
end

local mason = {
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				-- "flake8",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
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

local Lspconfig = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.diagnostic.config({
			virtual_text = false,
			signs = {
				text = { "", "", "", "" },
			},
			underline = true,
			update_in_insert = true,
			severity_sort = true,
			float = {
				border = "rounded",
				source = "always",
			},
		})
		require("mason").setup()
		require("mason-lspconfig").setup()
		require("lspconfig.ui.windows").default_options.border = "rounded"

		require("lspconfig").bashls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").clangd.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
			cmd = {
				"/usr/bin/clangd",
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
		require("lspconfig").cmake.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").cssls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").dockerls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").emmet_ls.setup({
			capabilities = make_capabilities(),
		})
		require("lspconfig").eslint.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").fennel_language_server.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").gradle_ls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").html.setup({
			capabilities = make_capabilities(),
		})
		require("lspconfig").kotlin_language_server.setup({
			capabilities = make_capabilities(),
			single_file_support = true,
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").lua_ls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
				-- client.server_capabilities.documentFormattingProvider = false
			end,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					format = {
						enable = false,
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
		require("lspconfig").ocamllsp.setup({
			capabilities = make_capabilities(),
			single_file_support = true,
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		-- require("lspconfig").pylsp.setup({
		-- 	capabilities = make_capabilities(),
		-- 	on_attach = function(client, bufnr)
		-- 		set_key_map(client, bufnr)
		-- 	end,
		-- 	settings = {
		-- 		pylsp = {
		-- 			plugins = {
		-- 				flake8 = {
		-- 					enabled = false,
		-- 				},
		-- 				pyflakes = {
		-- 					enabled = false,
		-- 				},
		-- 				pylint = {
		-- 					enabled = false,
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- })
		-- require("lspconfig").pyright.setup({
		-- 	-- capabilities = make_capabilities(),
		-- 	on_attach = function(client, bufnr)
		-- 		set_key_map(client, bufnr)
		-- 	end,
		-- 	settings = {
		-- 		python = {
		-- 			analysis = {
		-- 				autoSearchPaths = true,
		-- 				diagnosticMode = "workspace",
		-- 				useLibraryCodeForTypes = true,
		-- 			},
		-- 		},
		-- 	},
		-- })
		require("lspconfig").jedi_language_server.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		-- require("lspconfig").pylyzer.setup({
		-- 	capabilities = make_capabilities(),
		-- 	on_attach = function(client, bufnr)
		-- 		set_keymap(client, bufnr)
		-- 		set_inlay_hint(client, bufnr)
		-- 	end,
		-- 	settings = {
		-- 		python = {
		-- 			checkOnType = true,
		-- 			diagnostics = true,
		-- 			inlayHints = true,
		-- 			smartCompletion = true,
		-- 		},
		-- 	},
		-- })
		require("lspconfig").r_language_server.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").sourcekit.setup({
			filetypes = { "swift", "objective-c" },
			single_file_support = true,
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").sqlls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
		require("lspconfig").typst_lsp.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
			single_file_support = true,
			settings = {
				exportPdf = "onType", -- Choose onType, onSave or never.
				-- serverPath = "" -- Normally, there is no need to uncomment it.
			},
		})
		require("lspconfig").vimls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
	end,
}

local clangd = {
	"p00f/clangd_extensions.nvim",
	enabled = true,
	-- event = "LspAttach",
	-- event = { "BufReadPre", "BufNewFile" },
	ft = { "c", "cpp", "objc", "objcpp" },
	-- lazy = false,
	config = function()
		local clangd_capabilities = make_capabilities()
		clangd_capabilities.offsetEncoding = "utf-16"
		require("clangd_extensions").setup({
			inlay_hints = {
				inline = vim.fn.has("nvim-0.10") == 1,
				-- inline = false,
				-- Options other than `highlight' and `priority' only work
				-- if `inline' is disabled
				-- Only show inlay hints for the current line
				only_current_line = false,
				-- Event which triggers a refersh of the inlay hints.
				-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
				-- not that this may cause  higher CPU usage.
				-- This option is only respected when only_current_line and
				-- autoSetHints both are true.
				only_current_line_autocmd = "CursorHold",
				-- whether to show parameter hints with the inlay hints or not
				show_parameter_hints = true,
				-- prefix for parameter hints
				parameter_hints_prefix = "<- ",
				-- prefix for all the other hints (type, chaining)
				other_hints_prefix = "=> ",
				-- whether to align to the length of the longest line in the file
				max_len_align = false,
				-- padding from the left if max_len_align is true
				max_len_align_padding = 1,
				-- whether to align to the extreme right or not
				right_align = false,
				-- padding from the right if right_align is true
				right_align_padding = 7,
				-- The color of the hints
				highlight = "Comment",
				-- The highlight group priority for extmark
				priority = 100,
			},
			ast = {
				role_icons = {
					type = "󰉺",
					declaration = "󰙞",
					expression = "󰜌",
					specifier = "󰓼",
					statement = "󰜋",
					["template argument"] = "",
				},

				kind_icons = {
					Compound = "󰛸",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "󰆦",
					TemplateTemplateParm = "󰆩",
					TemplateParamObject = "󰆧",
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
	dependencies = {
		"nvim-java/lua-async-await",
		"nvim-java/nvim-java-core",
		"nvim-java/nvim-java-test",
		"nvim-java/nvim-java-dap",
		"MunifTanjim/nui.nvim",
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		{
			"williamboman/mason.nvim",
			opts = {
				registries = {
					"github:nvim-java/mason-registry",
					"github:mason-org/mason-registry",
				},
			},
		},
	},
	config = function()
		require("java").setup()
		require("lspconfig").jdtls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
	end,
}

local haskell_tools = {
	"MrcJkb/haskell-tools.nvim",
	version = "^2", -- Recommended
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
	init = function()
		vim.g.haskell_tools = {
			tools = { -- haskell-tools options
				repl = {
					-- 'builtin': Use the simple builtin repl
					-- 'toggleterm': Use akinsho/toggleterm.nvim
					handler = "toggleterm",
					builtin = {
						create_repl_window = function(view)
							-- create_repl_split | create_repl_vsplit | create_repl_tabnew | create_repl_cur_win
							return view.create_repl_split({ size = vim.o.lines / 3 })
						end,
					},
				},
				hover = {
					-- Whether to disable haskell-tools hover and use the builtin lsp's default handler
					disable = true,
					-- border = ,
					stylize_markdown = true,
					-- Whether to automatically switch to the hover window
					auto_focus = false,
				},
				tags = {
					-- enable = vim.fn.executable("fast-tags") == 1,
					enable = false,
					-- Events to trigger package tag generation
					package_events = { "BufWritePost" },
				},
			},
			hls = {
				capabilities = make_capabilities(),
				on_attach = function(client, bufnr)
					local opts = { noremap = true, silent = true, buffer = bufnr }
					set_keymap(client, bufnr)
					set_inlay_hint(client, bufnr)
					map("n", "<leader>cl", vim.lsp.codelens.run, opts)
				end,
				single_file_support = true,
				default_settings = {
					haskell = { -- haskell-language-server options
						formattingProvider = "ormolu",
						checkProject = true, -- Setting this to true could have a performance impact on large mono repos.
					},
				},
			},
		}
	end,
}

local rustaceanvim = {
	"mrcjkb/rustaceanvim",
	version = "^3", -- Recommended
	ft = { "rust" },
	init = function()
		vim.g.rustaceanvim = {
			-- Plugin configuration
			tools = {},
			-- LSP configuration
			server = {
				on_attach = function(client, bufnr)
					set_keymap(client, bufnr)
					set_inlay_hint(client, bufnr)
				end,
				settings = {
					["rust-analyzer"] = {},
				},
			},
			-- DAP configuration
			dap = {},
		}
	end,
}

local jsonls = {
	"b0o/schemastore.nvim",
	ft = { "json", "jsonc" },
	config = function()
		require("lspconfig").jsonls.setup({
			capabilities = make_capabilities(),
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
				},
			},
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
		})
	end,
}

local null_ls = {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			border = "rounded",
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
				set_inlay_hint(client, bufnr)
			end,
			sources = {
				null_ls.builtins.completion.spell,

				null_ls.builtins.diagnostics.checkmake,
				null_ls.builtins.diagnostics.hadolint,
				-- null_ls.builtins.diagnostics.markdownlint,
				null_ls.builtins.diagnostics.gitlint,
				-- null_ls.builtins.diagnostics.textidote,
				-- null_ls.builtins.diagnostics.typos,
				null_ls.builtins.diagnostics.pylint.with({
					args = {
						"--from-stdin",
						"$FILENAME",
						"-f",
						"json",
						"--errors-only",
					},
				}),
				null_ls.builtins.diagnostics.shellcheck,
				-- null_ls.builtins.diagnostics.swiftlint,
				-- null_ls.builtins.diagnostics.yamllint,
				null_ls.builtins.diagnostics.zsh,

				-- null_ls.builtins.code_actions.shellcheck,

				null_ls.builtins.formatting.autopep8,
				null_ls.builtins.formatting.cmake_format,
				null_ls.builtins.formatting.markdownlint,
				null_ls.builtins.formatting.shellharden.with({
					filetypes = {
						"sh",
						"bash",
						"zsh",
					},
				}),
				-- null_ls.builtins.formatting.prettierd.with({
				-- 	filetypes = {
				-- 		"css",
				-- 		"scss",
				-- 		"less",
				-- 		"html",
				-- 		"json",
				-- 		"jsonc",
				-- 		"yaml",
				-- 		"graphql",
				-- 		"handlebars",
				-- 		"javascript",
				-- 		"javascriptreact",
				-- 		"typescript",
				-- 		"typescriptreact",
				-- 		"vue",
				-- 	},
				-- }),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.swiftformat,

				-- null_ls.builtins.formatting.yamlfmt,
				null_ls.builtins.formatting.xmllint,

				null_ls.builtins.hover.dictionary,
			},
		})
	end,
}

-- local copilot = {
-- 	"zbirenbaum/copilot.lua",
-- 	event = "VeryLazy",
-- 	enabled = true,
-- 	config = function()
-- 		vim.defer_fn(function()
-- 			require("copilot").setup({
-- 				panel = {
-- 					enabled = false,
-- 					auto_refresh = true,
-- 					keymap = {
-- 						jump_prev = "[[",
-- 						jump_next = "]]",
-- 						accept = "<CR>",
-- 						refresh = "gr",
-- 						open = "<c-CR>",
-- 					},
-- 				},
-- 				suggestion = {
-- 					enabled = true,
-- 					auto_trigger = true,
-- 					debounce = 75,
-- 					keymap = {
-- 						accept = "<c-;>",
-- 						next = "<c-,>",
-- 						prev = "<c-.>",
-- 						dismiss = "<c-'>",
-- 					},
-- 				},
-- 				filetypes = {
-- 					yaml = false,
-- 					help = false,
-- 					gitcommit = false,
-- 					gitrebase = false,
-- 					hgcommit = false,
-- 					svn = false,
-- 					cvs = false,
-- 					["."] = false,
-- 				},
-- 				copilot_node_command = "node", -- Node version must be < 18
-- 				server_opts_overrides = {
-- 					trace = "verbose",
-- 					settings = {
-- 						advanced = {
-- 							listCount = 10, -- #completions for panel
-- 							inlineSuggestCount = 3, -- #completions for getCompletions
-- 						},
-- 					},
-- 				},
-- 			})
-- 		end, 100)
-- 	end,
-- }

-- local copilot = {
-- 	"github/copilot.vim",
-- 	event = "VeryLazy",
-- 	init = function()
-- 		vim.g.copilot_no_tab_map = true
-- 		vim.keymap.set("i", "<M-;>", [[copilot#Accept("\<CR>")]], { expr = true, script = true })
-- 	end,
-- }

local codeium = {
	{
		"Exafunction/codeium.vim",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("i", "<C-;>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true, noremap = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true, noremap = true })
			vim.keymap.set("i", "<c-.>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true, noremap = true })
			vim.keymap.set("i", "<c-'>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true, noremap = true })
		end,
	},
}

return {
	mason,
	Lspconfig,
	clangd,
	java,
	haskell_tools,
	rustaceanvim,
	null_ls,
	jsonls,
	codeium,
	-- copilot,
}
