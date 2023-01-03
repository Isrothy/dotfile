local border = {
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ " ", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ " ", "FloatBorder" },
}
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local make_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true
end

local hl_word = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#4C566A", fg = "NONE" })
		vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#4C566A", fg = "NONE" })
		vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#4C566A", fg = "NONE" })
		-- vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "NONE", fg = "NONE", underline = true })
		-- vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "NONE", fg = "NONE", underline = true })
		-- vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "NONE", fg = "NONE", underline = true })
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local set_key_map = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gl", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gD", function()
		require("telescope.builtin").lsp_type_definitions({ jump_type = "never" })
	end, bufopts)

	vim.keymap.set("n", "gd", function()
		require("telescope.builtin").lsp_definitions({ jump_type = "never" })
	end, bufopts)

	vim.keymap.set("n", "gi", function()
		require("telescope.builtin").lsp_implementations({ jump_type = "never" })
	end, bufopts)

	vim.keymap.set("n", "gr", function()
		require("telescope.builtin").lsp_references({ jump_type = "never" })
	end, bufopts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<Leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

local offset_encoding = "utf-8"

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = false,
			})
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			require("lspconfig").bashls.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					hl_word(client, bufnr)
				end,
			})
			require("lspconfig").cmake.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					set_key_map(client, bufnr)
					hl_word(client, bufnr)
				end,
			})

			require("lspconfig").cssls.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					set_key_map(client, bufnr)
					hl_word(client, bufnr)
				end,
			})
			require("lspconfig").dockerls.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					set_key_map(client, bufnr)
					hl_word(client, bufnr)
				end,
			})
			require("lspconfig").emmet_ls.setup({
				handlers = handlers,
				capabilities = make_capabilities(),
				offset_encoding = offset_encoding,
			})
			require("lspconfig").eslint.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					set_key_map(client, bufnr)
					hl_word(client, bufnr)
				end,
			})
			require("lspconfig").gradle_ls.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					set_key_map(client, bufnr)
					hl_word(client, bufnr)
				end,
			})
			require("lspconfig").html.setup({
				handlers = handlers,
				capabilities = make_capabilities(),
				offset_encoding = offset_encoding,
			})

			require("lspconfig").jdtls.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					hl_word(client, bufnr)
					set_key_map(client, bufnr)
				end,
			})
			require("lspconfig").kotlin_language_server.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				single_file_support = true,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					hl_word(client, bufnr)
					set_key_map(client, bufnr)
				end,
			})
			require("lspconfig").pylsp.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					hl_word(client, bufnr)
					set_key_map(client, bufnr)
				end,
			})
			-- require("lspconfig").pyright.setup({
			-- 	capabilities = util.capabilities,
			-- 	handlers = util.handlers,
			-- 	on_attach = function(client, bufnr)
			-- 		util.set_key_map(client, bufnr)
			-- 		util.hl_word(client, bufnr)
			-- 	end,
			-- })
			require("lspconfig").r_language_server.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					set_key_map(client, bufnr)
					hl_word(client, bufnr)
				end,
			})
			require("lspconfig").sourcekit.setup({
				filetypes = { "swift", "objective-c" },
				single_file_support = true,
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					set_key_map(client, bufnr)
					hl_word(client, bufnr)
				end,
			})
			require("lspconfig").sumneko_lua.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					hl_word(client, bufnr)
					set_key_map(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})
			require("lspconfig").vimls.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				offset_encoding = offset_encoding,
				on_attach = function(client, bufnr)
					set_key_map(client, bufnr)
					hl_word(client, bufnr)
				end,
			})
		end,
	},

	---- clangd
	{
		"p00f/clangd_extensions.nvim",
		ft = { "c", "cpp", "objc", "objcpp" },
		config = function()
			local clangd_capabilities = make_capabilities()

			-- clangd_capabilities.offsetEncoding = { "utf-16" }
			require("clangd_extensions").setup({
				server = {
					capabilities = clangd_capabilities,
					handlers = handlers,
					offset_encoding = offset_encoding,
					on_attach = function(client, bufnr)
						set_key_map(client, bufnr)
						hl_word(client, bufnr)
					end,
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--completion-style=bundled",
						"--cross-file-rename",
						"--header-insertion=iwyu",
					},
				},
				extensions = {
					-- :
					-- Automatically set inlay hints (type hints)
					autoSetHints = false,
					-- Whether to show hover actions inside the hover window
					hover_with_actions = true,
					-- These apply to the ClangdSetInlayHints command
					inlay_hints = {
						-- Only show inlay hints for the current line
						only_current_line = false,
						-- Event which triggers a refersh of the inlay hints.
						-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
						-- not that this may cause  higher CPU usage.
						-- This option is only respected when only_current_line and
						-- autoSetHints both are true.
						only_current_line_autocmd = "CursorHold",
						-- whether to show parameter hints with the inlay hints or not
						show_parameter_hints = false,
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
							type = "",
							declaration = "ﭝ",
							expression = "ﰊ",
							specifier = "炙",
							statement = "ﰉ",
							["template argument"] = "",
						},

						kind_icons = {
							Compound = "ﯶ",
							Recovery = "",
							TranslationUnit = "",
							PackExpansion = "",
							TemplateTypeParm = "",
							TemplateTemplateParm = "",
							TemplateParamObject = "",
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
				},
			})
		end,
	},

	---- haskell
	{
		"MrcJkb/haskell-tools.nvim",
		ft = { "haskell" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local ht = require("haskell-tools")
			ht.setup({
				tools = { -- haskell-tools options
					codeLens = {
						-- Whether to automatically display/refresh codeLenses
						autoRefresh = true,
					},
					hoogle = {
						-- 'auto': Choose a mode automatically, based on what is available.
						-- 'telescope-local': Force use of a local installation.
						-- 'telescope-web': The online version (depends on curl).
						-- 'browser': Open hoogle search in the default browser.
						mode = "auto",
					},
					repl = {
						-- 'builtin': Use the simple builtin repl
						-- 'toggleterm': Use akinsho/toggleterm.nvim
						handler = nil,
						builtin = {
							create_repl_window = function(view)
								-- create_repl_split | create_repl_vsplit | create_repl_tabnew | create_repl_cur_win
								return view.create_repl_split({ size = vim.o.lines / 3 })
							end,
						},
					},
					hover = {
						-- Whether to disable haskell-tools hover and use the builtin lsp's default handler
						disable = false,
						border = border,
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
					handlers = handlers,
					offset_encoding = offset_encoding,
					-- See nvim-lspconfig's  suggested configuration for keymaps, etc.
					on_attach = function(client, bufnr)
						local opts = { noremap = true, silent = true, buffer = bufnr }
						set_key_map(client, bufnr)
						hl_word(client, bufnr)
						require("telescope").load_extension("ht")
						vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
						vim.keymap.set("n", "<leader>s", ht.hoogle.hoogle_signature, opts)
					end,
					-- single_file_support = true,
					-- settings = {
					haskell = { -- haskell-language-server options
						formattingProvider = "ormolu",
						checkProject = true, -- Setting this to true could have a performance impact on large mono repos.
						-- ...
					},
				},
			})
		end,
	},

	--- rust
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		config = function()
			local rt = require("rust-tools")
			rt.setup({
				server = {
					capabilities = make_capabilities(),
					handlers = handlers,
					offset_encoding = offset_encoding,
					on_attach = function(client, bufnr)
						set_key_map(client, bufnr)
						hl_word(client, bufnr)
						vim.keymap.set("n", "gh", rt.hover_actions.hover_actions, { buffer = bufnr })
						vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
						vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
						vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
					end,
					standalone = true,
				},
				tools = { -- rust-tools options

					-- how to execute terminal commands
					-- options right now: termopen / quickfix
					executor = require("rust-tools/executors").termopen,

					-- callback to execute once rust-analyzer is done initializing the workspace
					-- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
					on_initialized = nil,

					-- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
					reload_workspace_from_cargo_toml = true,

					-- These apply to the default RustSetInlayHints command
					inlay_hints = {
						-- automatically set inlay hints (type hints)
						-- default: true
						auto = false,

						-- Only show inlay hints for the current line
						only_current_line = false,

						-- whether to show parameter hints with the inlay hints or not
						-- default: true
						show_parameter_hints = false,

						-- prefix for parameter hints
						-- default: "<-"
						parameter_hints_prefix = "<- ",

						-- prefix for all the other hints (type, chaining)
						-- default: "=>"
						other_hints_prefix = "=> ",

						-- whether to align to the lenght of the longest line in the file
						max_len_align = false,

						-- padding from the left if max_len_align is true
						max_len_align_padding = 1,

						-- whether to align to the extreme right or not
						right_align = false,

						-- padding from the right if right_align is true
						right_align_padding = 7,

						-- The color of the hints
						highlight = "Comment",
					},
					hover_actions = {

						-- the border that is used for the hover window
						-- see vim.api.nvim_open_win()
						border = border,

						-- whether the hover action window gets automatically focused
						-- default: false
						auto_focus = false,
					},
				},
			})
			require("rust-tools").inlay_hints.disable()
		end,
	},

	---- sqls
	{

		"nanotee/sqls.nvim",
		ft = { "sql", "mysql" },
		config = function()
			require("lspconfig").sqls.setup({
				capabilities = make_capabilities(),
				handlers = handlers,
				on_attach = function(client, bufnr)
					require("sqls").on_attach(client, bufnr)
					set_key_map(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})
		end,
	},

	----- nulls
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				on_init = function(new_client, _)
					new_client.offset_encoding = offset_encoding
				end,
				on_attach = function(client, bufnr)
					set_key_map(client, bufnr)
					hl_word(client, bufnr)
				end,
				sources = {
					null_ls.builtins.diagnostics.checkmake,
					null_ls.builtins.diagnostics.hadolint,
					null_ls.builtins.diagnostics.gitlint,
					-- null_ls.builtins.diagnostics.swiftlint,
					-- null_ls.builtins.diagnostics.yamllint,
					null_ls.builtins.diagnostics.zsh,

					null_ls.builtins.code_actions.shellcheck,

					-- null_ls.builtins.formatting.autopep8,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.cmake_format,
					null_ls.builtins.formatting.markdownlint,
					null_ls.builtins.formatting.prettierd.with({
						filetypes = {
							"css",
							"scss",
							"less",
							"html",
							"json",
							"jsonc",
							"yaml",
							"graphql",
							"handlebars",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
						},
					}),
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.formatting.swiftformat,

					-- null_ls.builtins.formatting.yamlfmt,
					null_ls.builtins.formatting.xmllint,
				},
			})
		end,
	},

	---- copilot
	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					panel = {
						enabled = false,
						auto_refresh = true,
						keymap = {
							jump_prev = "[[",
							jump_next = "]]",
							accept = "<CR>",
							refresh = "gr",
							open = "<M-CR>",
						},
					},
					suggestion = {
						enabled = true,
						auto_trigger = true,
						debounce = 75,
						keymap = {
							accept = "<M-j>",
							next = "<M-]>",
							prev = "<M-[>",
							dismiss = "<C-]>",
						},
					},
					filetypes = {
						yaml = false,
						markdown = false,
						help = false,
						gitcommit = false,
						gitrebase = false,
						hgcommit = false,
						svn = false,
						cvs = false,
						["."] = false,
					},
					copilot_node_command = "node", -- Node version must be < 18
					server_opts_overrides = {
						trace = "verbose",
						offset_encoding = offset_encoding,
						settings = {
							advanced = {
								listCount = 10, -- #completions for panel
								inlineSuggestCount = 3, -- #completions for getCompletions
							},
						},
					},
				})
			end, 100)
		end,
	},
}
