return {
  "philosofonusus/ecolog.nvim",
  keys = {
    { "<leader>eg", "<cmd>EcologGoto<cr>", desc = "Go to env file" },
    { "<leader>ep", "<cmd>EcologPeek<cr>", desc = "Ecolog peek variable" },
    { "<leader>eh", "<cmd>EcologShellToggle<cr>", desc = "Toggle shell variables" },
    { "<leader>es", "<cmd>EcologSelect<cr>", desc = "Switch env file" },
  },
  cmd = {
    "EcologPeek",
    "EcologRefresh",
    "EcologSelect",
    "EcologGoto",
    "EcologGotoVar",
    "EcologShelterToggle",
    "EcologShelterLinePeek",
    "EcologEnvGet",
    "EcologSnacks",
  },
  lazy = true,
  opts = {
    integrations = {
      nvim_cmp = false,
      blink_cmp = true,
      snacks = {
        shelter = {
          mask_on_copy = false, -- Whether to mask values when copying
        },
        keys = {
          copy_value = "<c-V>", -- Copy variable value to clipboard
          copy_name = "<c-K>", -- Copy variable name to clipboard
          append_value = "<c-A>", -- Append value at cursor position
          append_name = "<cr>", -- Append name at cursor position
        },
      },
      fzf = {
        shelter = {
          mask_on_copy = false,
        },
        mappings = {
          copy_value = "ctrl-v",
          copy_name = "ctrl-k",
          append_value = "ctrl-a",
          append_name = "enter",
        },
      },
    },
    shelter = {
      configuration = {
        partial_mode = true,
        mask_char = "•",
      },
      modules = {
        cmp = false, -- Mask values in completion
        peek = true, -- Mask values in peek view
        files = false, -- Mask values in files
        telescope = false, -- Mask values in telescope
        telescope_previewer = false, -- Mask values in telescope preview buffers
        fzf = true, -- Mask values in fzf picker
        fzf_previewer = true, -- Mask values in fzf preview buffers
        snacks_previewer = true,
      },
    },
    load_shell = true,
    types = true,
    path = vim.fn.getcwd(), -- Path to search for .env files
    preferred_environment = "development", -- Optional: prioritize specific env files
  },
}
