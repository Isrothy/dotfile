return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    enabled = false,
    ft = { "markdown" },
    keys = {
      {
        "<LOCALLEADER>mi",
        "<CMD>MoltenInit<CR>",
        noremap = true,
        silent = true,
        desc = "Molten init",
      },
      {
        "<LOCALLEADER>me",
        "<CMD>MoltenEvaluateOperator<CR>",
        noremap = true,
        silent = true,
        desc = "Molten evaluate operator",
      },
      {
        "<LOCALLEADER>mr",
        "<CMD>MoltenReevaluateCell<CR>",
        noremap = true,
        silent = true,
        desc = "Molten reevaluate cell",
      },
      {
        "<LOCALLEADER>mr",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        noremap = true,
        mode = { "v" },
        desc = "Molten evaluate visual",
      },
      {
        "<lOCALLEADER>mo",
        ":noautocmd MoltenEnterOutput<CR>",
        noremap = true,
        silent = true,
        desc = "Molten enter output",
      },
      {
        "<LOCALLEADER>mh",
        "<CMD>MoltenHideOutput<CR>",
        noremap = true,
        silent = true,
        desc = "Molten hide output",
      },
      {
        "<LOCALLEADER>md",
        "<CMD>MoltenDelete<CR>",
        noremap = true,
        silent = true,
        desc = "Molten delete",
      },
    },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_use_border_highlights = true
    end,
  },
}
