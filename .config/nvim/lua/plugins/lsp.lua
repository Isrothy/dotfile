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
	return capabilities
end

local set_keymap = function(_, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	map("n", "g<c-d>", vim.lsp.buf.declaration, bufopts)
	map("n", "gD", function()
		require("telescope.builtin").lsp_type_definitions({ jump_type = "never" })
	end, bufopts)

	map("n", "gd", function()
		require("telescope.builtin").lsp_definitions({ jump_type = "never" })
	end, bufopts)

	map("n", "gi", function()
		require("telescope.builtin").lsp_implementations({ jump_type = "never" })
	end, bufopts)

	map("n", "gr", function()
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
	map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
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

local Lspconfig = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = true,
			float = { border = "rounded" },
		})
		local signs = {
			Error = "",
			Warn = "",
			Hint = "",
			Info = "",
		}
		for type, icon in pairs(signs) do
			local sign = "DiagnosticSign" .. type
			vim.fn.sign_define(sign, {
				text = icon,
				texthl = "DiagnosticSign" .. type,
				numhl = "DiagnosticLineNr" .. type,
			})
		end
		require("lspconfig.ui.windows").default_options.border = "rounded"

		require("lspconfig").bashls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
		require("lspconfig").cmake.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
		-- require("lspconfig").clangd.setup({
		-- 	capabilities = make_capabilities(),
		-- 	on_attach = function(client, bufnr)
		-- 		set_keymap(client, bufnr)
		-- 	end,
		-- })

		require("lspconfig").cssls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
		require("lspconfig").dockerls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
		require("lspconfig").emmet_ls.setup({
			capabilities = make_capabilities(),
		})
		require("lspconfig").eslint.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
		require("lspconfig").gradle_ls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
		require("lspconfig").html.setup({
			capabilities = make_capabilities(),
		})

		-- require("lspconfig").jdtls.setup({
		-- 	capabilities = make_capabilities(),
		-- 	on_attach = function(client, bufnr)
		-- 		set_key_map(client, bufnr)
		-- 	end,
		-- })
		require("lspconfig").kotlin_language_server.setup({
			capabilities = make_capabilities(),
			single_file_support = true,
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
		require("lspconfig").ocamllsp.setup({
			capabilities = make_capabilities(),
			single_file_support = true,
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
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
			end,
		})
		-- require("lspconfig").pylyzer.setup({
		-- 	filetypes = { "python" },
		-- 	capabilities = make_capabilities(),
		-- 	on_attach = function(client, bufnr)
		-- 		set_key_map(client, bufnr)
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
		require("lspconfig").sourcekit.setup({
			filetypes = { "swift", "objective-c" },
			single_file_support = true,
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
		require("lspconfig").sqlls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
		require("lspconfig").lua_ls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
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
		require("lspconfig").vimls.setup({
			capabilities = make_capabilities(),
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
		})
	end,
}

local clangd = {
	"p00f/clangd_extensions.nvim",
	-- event = "LspAttach",
	event = { "BufReadPre", "BufNewFile" },
	ft = { "c", "cpp", "objc", "objcpp" },
	enabled = true,
	-- lazy = false,
	config = function()
		local clangd_capabilities = make_capabilities()
		clangd_capabilities.offsetEncoding = "utf-16"
		require("clangd_extensions").setup({
			server = {
				capabilities = clangd_capabilities,
				-- offset_encoding = "utf-16",
				on_attach = function(client, bufnr)
					set_keymap(client, bufnr)
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
					inline = vim.fn.has("nvim-0.10") == 1,
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
			},
		})
	end,
}

local jdtls = {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	init = function()
		-- create autocmd on filetypes java
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				local home = os.getenv("HOME")
				local jdtls_install_location = "/opt/homebrew/Cellar/jdtls/1.25.0/"
				local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
				local workspace_dir = home .. "/.local/share/eclipse/" .. project_name
				local javadebug_dir = home .. "/.local/share/javadebug/"

				local set_jdtls_keymap = function(_, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					map("n", "g<c-d>", vim.lsp.buf.declaration, bufopts)
					map("n", "gD", function()
						require("telescope.builtin").lsp_type_definitions({ jump_type = "never" })
					end, bufopts)

					map("n", "gd", function()
						require("telescope.builtin").lsp_definitions({ jump_type = "never" })
					end, bufopts)

					map("n", "gi", function()
						require("telescope.builtin").lsp_implementations({ jump_type = "never" })
					end, bufopts)

					map("n", "gr", function()
						require("telescope.builtin").lsp_references({
							include_declaration = false,
							include_current_line = false,
							jump_type = "never",
						})
					end, bufopts)

					map("n", "K", vim.lsp.buf.hover, bufopts)
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
					map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
					map("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
						require("jdtls").organize_imports()
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

					map("n", "<leader>tc", "<Cmd>lua require'jdtls'.test_class()<CR>", bufopts)
					map("n", "<leader>tm", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", bufopts)
					map("v", "<leader>ee", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", bufopts)
					map("n", "<leader>ev", "<Cmd>lua require('jdtls').extract_variable()<CR>", bufopts)
					map("v", "<leader>em", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", bufopts)
				end

				-- This starts a new client & server,
				-- or attaches to an existing client & server depending on the `root_dir`.
				-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
				local config = {
					-- The command that starts the language server
					-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
					cmd = {

						-- 💀
						"java", -- or '/path/to/java17_or_newer/bin/java'
						-- depends on if `java` is in your $PATH env variable and if it points to the right version.

						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=true",
						"-Dlog.level=ALL",
						"-Xmx1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",

						-- 💀
						"-jar",
						jdtls_install_location
							.. "libexec/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
						-- "/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar",
						-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
						-- Must point to the                                                     Change this to
						-- eclipse.jdt.ls installation                                           the actual version

						-- 💀
						"-configuration",
						jdtls_install_location .. "libexec/config_mac",
						-- "/path/to/jdtls_install_location/config_SYSTEM",
						-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
						-- Must point to the                      Change to one of `linux`, `win` or `mac`
						-- eclipse.jdt.ls installation            Depending on your system.

						-- 💀
						-- See `data directory configuration` section in the README
						"-data",
						workspace_dir,
					},

					-- 💀
					-- This is the default if not provided, you can remove it. Or adjust as needed.
					-- One dedicated LSP server & client will be started per unique root_dir
					root_dir = require("jdtls.setup").find_root({ "mvnw", "gradlew" }),

					-- Here you can configure eclipse.jdt.ls specific settings
					-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
					-- for a list of options
					settings = {
						java = {
							signatureHelp = { enabled = true },
							contentProvider = { preferred = "fernflower" },
							completion = {
								favoriteStaticMembers = {
									"org.hamcrest.MatcherAssert.assertThat",
									"org.hamcrest.Matchers.*",
									"org.hamcrest.CoreMatchers.*",
									"org.junit.jupiter.api.Assertions.*",
									"java.util.Objects.requireNonNull",
									"java.util.Objects.requireNonNullElse",
									"org.mockito.Mockito.*",
								},
								filteredTypes = {
									"com.sun.*",
									"io.micrometer.shaded.*",
									"java.awt.*",
									"jdk.*",
									"sun.*",
								},
							},
							sources = {
								organizeImports = {
									starThreshold = 9999,
									staticStarThreshold = 9999,
								},
							},
							codeGeneration = {
								toString = {
									template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
								},
							},
						},
					},

					-- Language server `initializationOptions`
					-- You need to extend the `bundles` with paths to jar files
					-- if you want to use additional eclipse.jdt.ls plugins.
					--
					-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
					--
					-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
					init_options = {
						bundles = {
							vim.fn.glob(
								javadebug_dir
									.. "com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.45.0.jar",
								1
							),
						},
					},
					capabilities = make_capabilities(),
					on_attach = function(client, bufnr)
						set_jdtls_keymap(client, bufnr)
						require("jdtls").setup_dap({ hotcodereplace = "auto" })
						vim.cmd([[
							command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
							command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
							command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
							command! -buffer JdtJol lua require('jdtls').jol()
							command! -buffer JdtBytecode lua require('jdtls').javap()
							command! -buffer JdtJshell lua require('jdtls').jshell()
						]])
					end,
				}
				require("jdtls").start_or_attach(config)
			end,
		})
	end,
}

local haskell_tools = {
	"MrcJkb/haskell-tools.nvim",
	event = { "BufReadPre", "BufNewFile" },
	-- lazy = false,
	branch = "1.x.x",
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
					require("telescope").load_extension("ht")
					map("n", "<leader>cl", vim.lsp.codelens.run, opts)
					map("n", "<leader>s", ht.hoogle.hoogle_signature, opts)
				end,
				single_file_support = true,
				default_settings = {
					haskell = { -- haskell-language-server options
						formattingProvider = "ormolu",
						checkProject = true, -- Setting this to true could have a performance impact on large mono repos.
					},
				},
			},
		})
		require("telescope").load_extension("ht")
	end,
}

local rust_tools = {
	"simrat39/rust-tools.nvim",
	event = { "BufReadPre", "BufNewFile" },
	-- ft = { "rust" },
	enabled = true,
	config = function()
		local rt = require("rust-tools")
		rt.setup({
			server = {
				capabilities = make_capabilities(),
				on_attach = function(client, bufnr)
					set_keymap(client, bufnr)
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
					show_parameter_hints = true,

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

					-- padding from the right if pight_align is true
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
	end,
}

local jsonls = {
	"b0o/schemastore.nvim",
	-- enabled = true,
	-- lazy = false,
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
			end,
		})
	end,
}

local null_ls = {
	"jose-elias-alvarez/null-ls.nvim",
	-- event = { "BufReadPre", "BufNewFile" },
	lazy = false,
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			border = "rounded",
			on_attach = function(client, bufnr)
				set_keymap(client, bufnr)
			end,
			sources = {
				null_ls.builtins.diagnostics.checkmake,
				null_ls.builtins.diagnostics.hadolint,
				null_ls.builtins.diagnostics.gitlint,
				null_ls.builtins.diagnostics.pylint.with({
					args = {
						"--from-stdin",
						"$FILENAME",
						"-f",
						"json",
						"--errors-only",
					},
				}),
				-- null_ls.builtins.diagnostics.swiftlint,
				-- null_ls.builtins.diagnostics.yamllint,
				null_ls.builtins.diagnostics.zsh,

				-- null_ls.builtins.code_actions.shellcheck,

				null_ls.builtins.formatting.autopep8,
				-- null_ls.builtins.formatting.clang_format,
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
				null_ls.builtins.formatting.swiftformat,

				-- null_ls.builtins.formatting.yamlfmt,
				null_ls.builtins.formatting.xmllint,
			},
		})
	end,
}

local copilot = {
	"zbirenbaum/copilot.lua",
	event = "VeryLazy",
	enabled = true,
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
						accept = "<M-;>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<M-'>",
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
}

local zk = {
	"mickael-menu/zk-nvim",
	enabled = false,
	cmd = {
		"ZkIndex",
		"ZkNotes",
		"ZkNew",
		"ZkNewFromTitleSelection",
		"ZkNewFromContentSelection",
		"ZkCd",
		"ZkBacklinks",
		"ZkLinks",
		"ZkInsertLink",
		"ZkMatch",
		"ZkTags",
	},
	config = function()
		require("zk").setup({
			-- can be "telescope", "fzf" or "select" (`vim.ui.select`)
			-- it's recommended to use "telescope" or "fzf"
			picker = "telescope",

			lsp = {
				-- `config` is passed to `vim.lsp.start_client(config)`
				config = {
					cmd = { "zk", "lsp" },
					name = "zk",
					on_attach = function(client, bufnr)
						set_keymap(client, bufnr)
					end,
				},

				-- automatically attach buffers in a zk notebook that match the given filetypes
				auto_attach = {
					enabled = false,
					filetypes = { "markdown" },
				},
			},
		})
		require("telescope").load_extension("zk")
	end,
}

-- local copilot = {
-- 	"github/copilot.vim",
-- 	event = "VeryLazy",
-- 	init = function()
-- 		vim.g.copilot_no_tab_map = true
-- 		vim.keymap.set("i", "<M-;>", [[copilot#Accept("\<CR>")]], { expr = true, script = true })
-- 	end,
-- }

-- local codium = {
-- 	"jcdickinson/codeium.nvim",
-- 	event = "VeryLazy",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		{
-- 			"jcdickinson/http.nvim",
-- 			build = "cargo build --workspace --release",
-- 		},
-- 	},
-- 	config = function()
-- 		require("codeium").setup({})
-- 	end,
--
-- }

-- local codium = {
-- 	"Exafunction/codeium.vim",
-- 	init = function()
-- 		vim.g.codeium_disable_bindings = 1
-- 	end,
-- 	event = "VeryLazy",
-- 	config = function()
-- 		-- Change '<C-g>' here to any keycode you like.
-- 		vim.keymap.set("i", "<M-;>", function()
-- 			return vim.fn["codeium#Accept"]()
-- 		end, { expr = true, silent = true })
-- 		vim.keymap.set("i", "<M-]>", function()
-- 			return vim.fn["codeium#CycleCompletions"](1)
-- 		end, { expr = true, silent = true })
-- 		vim.keymap.set("i", "<M-[>", function()
-- 			return vim.fn["codeium#CycleCompletions"](-1)
-- 		end, { expr = true, silent = true })
-- 		vim.keymap.set("i", "<M-'>", function()
-- 			return vim.fn["codeium#Clear"]()
-- 		end, { expr = true, silent = true })
-- 	end,
-- }

return {
	Lspconfig,
	clangd,
	jdtls,
	haskell_tools,
	rust_tools,
	null_ls,
	jsonls,
	zk,
	copilot,
	-- codium,
}
