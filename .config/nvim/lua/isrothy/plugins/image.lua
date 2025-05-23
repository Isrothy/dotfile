return {
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    cmd = { "PasteImage" },
    keys = {
      { "<leader>#", "<cmd>PasteImage<cr>", desc = "Paste image" },
      {
        "<leader>#/",
        function()
          Snacks.picker.files({
            ft = { "jpg", "jpeg", "png", "webp" },
            confirm = function(self, item, _)
              self:close()
              require("img-clip").paste_image({}, "./" .. item.file) -- ./ is necessary for img-clip to recognize it as path
            end,
          })
        end,
        desc = "Image",
      },
    },
    opts = {},
  },
}
