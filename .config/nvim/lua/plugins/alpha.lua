local M = {
    "goolord/alpha-nvim",
    event = "VimEnter",
}

M.config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
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

    dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recently opened files", ":Telescope frecency<CR>"),
        dashboard.button("b", "  File browser", ":Telescope file_browser<CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("w", "  Find word", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  Load current dir session", ":SessionManage load_current_dir_session<CR>"),
        dashboard.button("l", "  Load session", ":SessionManage load_session<CR>"),
        -- dashboard.button("h", "  Neovim Check health", ":checkhealth<CR>"),
        dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
    }
    dashboard.config.opts.noautocmd = false
    alpha.setup(dashboard.config)

    -- disable tabline
    -- vim.api.nvim_create_autocmd("User AlphaReady", {
    -- 	callback = function()
    -- 		vim.opt.showtabline = 0
    -- 		return true
    -- 	end,
    -- })
    -- vim.api.nvim_create_autocmd("BufUnload", {
    -- 	pattern = "<buffer>",
    -- 	callback = function()
    -- 		vim.opt.showtabline = 2
    -- 		return true
    -- 	end,
    -- })

    vim.cmd([[
        autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    ]]
    )
end

return M
