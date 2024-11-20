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

local function header()
    local lines = {}

    for i, chars in pairs(neovim_delta_corps_preist1) do
        local line = {
            type = "text",
            val = chars,
            opts = {
                hl = "StartLogo" .. i,
                shrink_margin = false,
                position = "center",
            },
        }

        table.insert(lines, line)
    end

    return lines
end

return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = false,

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        local fortune = require("alpha.fortune")

        dashboard.section.buttons.val = {
            dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
            dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", " " .. " Recent files", ":Telescope frecency <CR>"),
            dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
            dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
            dashboard.button("s", " " .. " Restore Session", ":SessionLoad<CR>"),
            dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
            dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        }
        dashboard.section.footer.val = fortune()
        dashboard.config.opts.noautocmd = false

        alpha.setup({
            layout = {
                { type = "padding", val = 4 },
                { type = "group", val = header() },
                { type = "padding", val = 2 },
                dashboard.section.buttons,
                dashboard.section.footer,
            },
            opts = dashboard.config,
        })

        vim.cmd([[
			augroup Alpha
				autocmd!
				autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
			augroup END
			]])
    end,
}
