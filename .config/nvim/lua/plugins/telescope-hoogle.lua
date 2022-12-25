return {
    "luc-tielen/telescope_hoogle",
    ft = "haskell",
    cmd = { "Telescope" },
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("telescope").load_extension("hoogle")
    end,
}
