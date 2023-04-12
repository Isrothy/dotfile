return {
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_markdown_css = "/Users/jiangjoshua/.config/nvim/style/markdown.css"
			vim.g.mkdp_highlight_css = "/Users/jiangjoshua/.config/nvim/style/highlight.css"
			vim.g.mkdp_theme = "dark"
		end,
	},
	{

		"gaoDean/autolist.nvim",
		ft = { "markdown" },
		enabled = true,
		config = function()
			local autolist = require("autolist")
			autolist.setup({
				enabled = true,
				list_cap = 50,
				colon = {
					indent_raw = true,
					indent = true,
					preferred = "-",
				},
				invert = {
					indent = false,
					toggles_checkbox = true,
					ul_marker = "-",
					ol_incrementable = "1",
					ol_delim = ".",
				},
				lists = {
					markdown = {
						"unordered",
						"digit",
						"ascii",
					},
					text = {
						"unordered",
						"digit",
						"ascii",
					},
					tex = { "latex_item" },
					plaintex = { "latex_item" },
				},
				list_patterns = {
					unordered = "[-+*]", -- - + *
					digit = "%d+[.)]", -- 1. 2. 3.
					ascii = "%a[.)]", -- a) b) c)
					latex_item = "\\item",
				},
				checkbox = {
					left = "%[",
					right = "%]",
					fill = "x",
				},
			})
			local function mapping_hook(mode, mapping, hook, alias)
				vim.keymap.set(mode, mapping, function(motion)
					local keys = hook(motion, alias or mapping)
					if not keys then
						keys = ""
					end
					return keys
				end, { expr = true, buffer = true })
			end
			mapping_hook("i", "<cr>", autolist.new)
			mapping_hook("i", "<tab>", autolist.indent)
			mapping_hook("i", "<s-tab>", autolist.indent, "<c-d>")
			mapping_hook("n", "dd", autolist.force_recalculate)
			mapping_hook("n", "o", autolist.new)
			mapping_hook("n", "O", autolist.new_before)
			mapping_hook("n", ">>", autolist.indent)
			mapping_hook("n", "<<", autolist.indent)
			mapping_hook("n", "<c-r>", autolist.force_recalculate)
			mapping_hook("n", "<leader>i", autolist.invert_entry, "")
		end,
	},
}
