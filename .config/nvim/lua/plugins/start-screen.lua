local apple = {
	[[                    'c.]],
	[[                 ,xNMM.]],
	[[               .OMMMM]],
	[[              OMMM0]],
	[[    .;loddo:' loolloddol;.     ████████╗██╗  ██╗██╗███╗   ██╗██╗  ██╗]],
	[[   cKMMMMMMMMMMNWMMMMMMMMMM0:  ╚══██╔══╝██║  ██║██║████╗  ██║██║ ██╔╝]],
	[[ .KMMMMMMMMMMMMMMMMMMMMMMMWd.     ██║   ███████║██║██╔██╗ ██║█████╔╝]],
	[[ XMMMMMMMMMMMMMMMMMMMMMMMX.       ██║   ██╔══██║██║██║╚██╗██║██╔═██╗]],
	[[;MMMMMMMMMMMMMMMMMMMMMMMM:        ██║   ██║  ██║██║██║ ╚████║██║  ██╗]],
	[[:MMMMMMMMMMMMMMMMMMMMMMMM:        ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝]],
	[[.MMMMMMMMMMMMMMMMMMMMMMMMX.    ██████╗ ██╗███████╗███████╗███████╗██████╗ ███████╗███╗   ██╗████████╗]],
	[[ kMMMMMMMMMMMMMMMMMMMMMMMMWd.  ██╔══██╗██║██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝████╗  ██║╚══██╔══╝]],
	[[ .XMMMMMMMMMMMMMMMMMMMMMMMMMMk ██║  ██║██║█████╗  █████╗  █████╗  ██████╔╝█████╗  ██╔██╗ ██║   ██║]],
	[[  .XMMMMMMMMMMMMMMMMMMMMMMMMK. ██║  ██║██║██╔══╝  ██╔══╝  ██╔══╝  ██╔══██╗██╔══╝  ██║╚██╗██║   ██║]],
	[[    kMMMMMMMMMMMMMMMMMMMMMMd   ██████╔╝██║██║     ██║     ███████╗██║  ██║███████╗██║ ╚████║   ██║]],
	[[     ;KMMMMMMMWXXWMMMMMMMk.    ╚═════╝ ╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝]],
	[[       .cooc,.    .,coo:.]],
}
local neovim_delta_corps_preist1 = {
	[[███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄   ]],
	[[███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ ]],
	[[███   ███   ███    █▀  ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
	[[███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
	[[███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
	[[███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███ ]],
	[[███   ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███ ]],
	[[ ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀  ]],
}
return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		enabled = true,

		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = neovim_delta_corps_preist1

			dashboard.section.buttons.val = {
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("s", "🜛  Smart open", ":Telescope smart_open<CR>"),
				dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
				dashboard.button("g", "  Find word", ":Telescope live_grep<CR>"),
				dashboard.button("c", "  Load current dir session", ":SessionManage load_current_dir_session<CR>"),
				dashboard.button("l", "  Load session", ":SessionManage load_session<CR>"),
				dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
			}
			dashboard.config.opts.noautocmd = false
			alpha.setup(dashboard.config)

			vim.cmd([[
			augroup Alpha
				autocmd!
				autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
				autocmd User AlphaReady set statuscolumn= | autocmd BufUnload <buffer> set statuscolumn=%!v:lua.get_statuscol()
			augroup END
			]])
		end,
	},
	{
		"willothy/veil.nvim",
		-- event = "VimEnter",
		lazy = false,
		enabled = false,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("veil.builtin")

			require("veil").setup({
				sections = {
					builtin.sections.animated(builtin.headers.frames_nvim, {
						hl = { fg = "#5de4c7" },
					}),
					builtin.sections.buttons({
						{
							icon = "",
							text = "Find Files",
							shortcut = "f",
							callback = function()
								require("telescope.builtin").find_files()
							end,
						},
						{
							icon = "",
							text = "Find Word",
							shortcut = "w",
							callback = function()
								require("telescope.builtin").live_grep()
							end,
						},
						{
							icon = "",
							text = "Buffers",
							shortcut = "b",
							callback = function()
								require("telescope.builtin").buffers()
							end,
						},
					}),
				},
				builtin.sections.oldfiles(),
				mappings = {},
				startup = true,
				listed = false,
			})
		end,
	},
}
