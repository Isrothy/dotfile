local CMP = {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	enabled = true,
	-- init = function()
	-- vim.api.nvim_create_autocmd({ "InsertEnter", "CursorHoldI" }, {
	-- 	callback = function(_)
	-- 		local cmp = require("cmp")
	-- 		cmp.complete()
	-- 	end,
	-- })
	-- end,
}

CMP.dependencies = {
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lsp-document-symbol",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-calc",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"dmitmel/cmp-cmdline-history",
	"hrsh7th/cmp-nvim-lua",
	"saadparwaiz1/cmp_luasnip",
	"ray-x/cmp-treesitter",
	"L3MON4D3/LuaSnip",
	{
		"tzachar/cmp-fuzzy-buffer",
		dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
	},
	{
		"tzachar/cmp-fuzzy-path",
		dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
	},
	{
		"lukas-reineke/cmp-under-comparator",
	},
	{
		"onsails/lspkind-nvim",
	},
}

CMP.config = function()
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
	local luasnip = require("luasnip")

	cmp.setup({
		-- experimental = {
		-- 	ghost_text = { hlgroup = "Comment" },
		-- },
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},

		window = {
			-- completion = cmp.config.window.bordered(),
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
			["<c-e>"] = cmp.mapping.abort(),
			["<cr>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
				vim_item.menu = ({
					buffer = "[Buf]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[LaTeX]",
					treesitter = "[TS]",
					fuzzy_buffer = "[FZ]",
					fuzzy_path = "[FZ]",
					path = "[Path]",
					calc = "[Calc]",
					codeium = "[CDM]",
				})[entry.source.name]

				local kind = require("lspkind").cmp_format({
					with_text = false,
					maxwidth = 64,
					mode = "symbol_text",
					ellipsis_char = "...",
				})(entry, vim_item)
				-- local strings = vim.split(kind.kind, "%s", { trimempty = true })
				-- kind.kind = " " .. (strings[1] or "") .. " "
				-- kind.menu = "    (" .. (strings[2] or "") .. ")"
				return kind
			end,
		},

		sources = cmp.config.sources({
			-- { name = "copilot" },
			-- { name = "codeium" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "nvim_lsp_document_symbol" },
			{ name = "luasnip" },
			{ name = "nvim_lua" },
		}, {
			{ name = "calc" },
			{ name = "treesitter" },
			{ name = "buffer" },
			{ name = "fuzzy_buffer" },
			{ name = "path" },
			{ name = "fuzzy_path", option = { fd_timeout_msec = 100 } },
			-- {
			-- 	name = "spell",
			-- 	option = {
			-- 		keep_all_entries = false,
			-- 		enable_in_context = function()
			-- 			return require("cmp.config.context").in_treesitter_capture("spell")
			-- 		end,
			-- 	},
			-- },
			-- { name = "look" },
		}),

		sorting = {
			priority_weight = 2,
			comparators = {
				-- require("copilot_cmp.comparators").prioritize,
				-- require("copilot_cmp.comparators").score,
				require("cmp_fuzzy_path.compare"),
				require("cmp_fuzzy_buffer.compare"),
				compare.offset,
				compare.exact,
				compare.score,
				require("cmp-under-comparator").under,
				compare.recently_used,
				require("clangd_extensions.cmp_scores"),
				compare.kind,
				compare.sort_text,
				compare.length,
				compare.order,
			},
		},
	})

	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "cmp_git" },
		}, {
			{ name = "buffer" },
		}),
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
			{ name = "fuzzy_path" },
		}),
		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
				vim_item.menu = ({
					buffer = "[Buf]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[LaTeX]",
					treesitter = "[TS]",
					fuzzy_buffer = "[FZ]",
					fuzzy_path = "[FZ]",
					path = "[Path]",
					calc = "[Calc]",
				})[entry.source.name]

				local kind = require("lspkind").cmp_format({
					with_text = false,
					mode = "symbol_text",
					ellipsis_char = "...",
				})(entry, vim_item)
				return kind
			end,
		},
	})
	-- vim.cmd([[
	-- autocmd InsertEnter * call s:on_insert_enter()
	-- function! s:on_insert_enter()
	-- lua <<EOF
	--   vim.schedule(function()
	--     local cmp = require('cmp')
	--     cmp.complete({
	--       config = {
	--         sources = {
	--           { name = 'copilot' }
	--         }
	--       }
	--     })
	--   end)
	-- EOF
	-- endfunction
	-- ]])
end
local LuaSnip = {
	"L3MON4D3/LuaSnip",
	version = "v1.1.x",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load({
			include = {
				"bash",
				"c",
				"cpp",
				"css",
				"html",
				"java",
				"javascript",
				"javascriptreact",
				"json",
				"kotlin",
				"lua",
				"objective-c",
				"python",
				"rust",
				"swift",
				"typescript",
				"typescriptreact",
			},
		})
	end,
}

-- local copilot = {
-- 	"zbirenbaum/copilot-cmp",
-- 	enabled = false,
-- 	dependencies = {
-- 		"zbirenbaum/copilot.lua",
-- 	},
-- 	event = "InsertEnter",
-- 	config = function()
-- 		require("copilot_cmp").setup({
-- 			method = "getCompletionsCycling",
-- 			formatters = {
-- 				label = require("copilot_cmp.format").format_label_text,
-- 				insert_text = require("copilot_cmp.format").format_insert_text,
-- 				preview = require("copilot_cmp.format").deindent,
-- 			},
-- 		})
-- 	end,
-- }

return {
	CMP,
	LuaSnip,
	-- copilot,
}
