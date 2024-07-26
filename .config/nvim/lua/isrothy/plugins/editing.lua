return {
	{
		"hrsh7th/nvim-cmp",
		enabled = true,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"dmitmel/cmp-cmdline-history",
			"hrsh7th/cmp-nvim-lua",
			"ray-x/cmp-treesitter",
			{
				"tzachar/cmp-fuzzy-buffer",
				dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
			},
			{
				"tzachar/cmp-fuzzy-path",
				dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
			},
			{ "lukas-reineke/cmp-under-comparator" },
			{ "onsails/lspkind-nvim" },
			{ "rcarriga/cmp-dap" },
			{ "chrisgrieser/cmp_yanky" },
			{
				"tamago324/cmp-zsh",
				opts = {
					zshrc = true,
					filetypes = { "zsh" },
				},
			},
		},

		config = function()
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			local function get_default_cmp_source()
				local cmp = require("cmp")
				return cmp.config.sources({
					{ name = "lazydev", group_index = 0 },
					{ name = "nvim_lsp" },
					-- { name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp_document_symbol" },
					-- { name = "luasnip" },
				}, {
					{ name = "calc" },
					{ name = "buffer" },
					{ name = "fuzzy_buffer" },
					{ name = "path" },
					{ name = "treesitter" },
					{ name = "cmp_yanky" },
					{ name = "fuzzy_path", option = { fd_timeout_msec = 100 } },
				})
			end

			local kind_icons = {
				Copilot = "",
				Text = "",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰇽",
				Variable = "󰂡",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰅲",
			}

			-- nvim-cmp setup
			local cmp = require("cmp")
			local compare = require("cmp.config.compare")

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
						-- require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					documentation = cmp.config.window.bordered(),
					-- completion = {
					-- 	col_offset = -3,
					-- 	side_padding = 0,
					-- },
				},
				mapping = cmp.mapping.preset.insert({
					["<c-b>"] = cmp.mapping.scroll_docs(-4),
					["<c-f>"] = cmp.mapping.scroll_docs(4),
					["<c-Space>"] = cmp.mapping.complete(),
					["<c-q>"] = cmp.mapping.abort(),
					["<cr>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.snippet.active({ direction = 1 }) then
							vim.schedule(function()
								vim.snippet.jump(1)
							end)
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.snippet.active({ direction = -1 }) then
							vim.schedule(function()
								vim.snippet.jump(-1)
							end)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				formatting = {
					format = function(entry, item)
						-- This concatonates the icons with the name of the item kind
						item.kind = string.format("%s %s", kind_icons[item.kind], item.kind)
						item.menu = ({
							buffer = "[Buf]",
							nvim_lsp = "[LSP]",
							-- luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							latex_symbols = "[LaTeX]",
							treesitter = "[TS]",
							fuzzy_buffer = "[FZ]",
							fuzzy_path = "[FZ]",
							path = "[Path]",
							calc = "[Calc]",
							codeium = "[CDM]",
							yanky = "[YANK]",
							dap = "[DAP]",
							zsh = "[ZSH]",
						})[entry.source.name]

						local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
						item = require("lspkind").cmp_format({
							with_text = false,
							maxwidth = 64,
							mode = "symbol_text",
							ellipsis_char = "...",
						})(entry, item)
						if color_item.abbr_hl_group then
							item.kind_hl_group = color_item.abbr_hl_group
							item.kind = color_item.abbr
						end
						return item
					end,
					fields = { "abbr", "kind", "menu" },
					expandable_indicator = true,
				},

				sources = get_default_cmp_source(),

				sorting = {
					priority_weight = 2,
					comparators = {
						require("cmp_fuzzy_path.compare"),
						require("cmp_fuzzy_buffer.compare"),
						compare.offset,
						compare.exact,
						compare.score,
						require("cmp-under-comparator").under,
						compare.recently_used,
						compare.kind,
						compare.sort_text,
						compare.length,
						compare.order,
					},
				},
				enabled = function()
					return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
						or require("cmp_dap").is_dap_buffer()
				end,
			})

			cmp.setup.filetype("lua", {
				sources = cmp.config.sources((function()
					local sources = get_default_cmp_source()
					sources[#sources + 1] = { name = "nvim_lua", group_index = 1 }
					return sources
				end)()),
			})

			cmp.setup.filetype("zsh", {
				sources = cmp.config.sources((function()
					local sources = get_default_cmp_source()
					sources[#sources + 1] = { name = "zsh", group_index = 1 }
					return sources
				end)()),
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" },
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
				sources = {
					{ name = "dap" },
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "nvim_lsp_document_symbol" },
					{ name = "cmdline_history" },
					{ name = "buffer" },
					{ name = "fuzzy_buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "cmdline" },
				}, {
					{ name = "cmdline_history" },
					{ name = "path" },
					{ name = "fuzzy_path", option = { fd_timeout_msec = 100 } },
				}),
			})
		end,

		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "LargeBuf",
				group = vim.api.nvim_create_augroup("cmp_large_file", { clear = true }),
				callback = function()
					local cmp = require("cmp")
					cmp.setup.buffer({
						sources = {
							{ name = "calc" },
							-- { name = "buffer" },
							-- { name = "fuzzy_buffer" },
						},
					})
				end,
			})
		end,
	},

	{
		"garymjr/nvim-snippets",
		opts = {
			friendly_snippets = true,
			global_snippets = { "all", "global" },
		},
		dependencies = { "rafamadriz/friendly-snippets" },
	},

	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		enabled = true,
		opts = {
			map_bs = true,
			map_c_h = true,
			check_ts = true,
			map_c_w = true,
			enable_check_bracket_line = true,
			ignored_next_char = "[%w%.]",
			disable_filetype = {
				"TelescopePrompt",
				"spectre_panel",
			},
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				manual_position = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"RRethy/nvim-treesitter-endwise",
		enabled = true,
		event = { "InsertEnter" },
	},

	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			opts = {
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = true,
			},
		},
	},
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
		opts = {},
	},
}
