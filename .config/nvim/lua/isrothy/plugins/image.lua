return {
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    cmd = { "PasteImage" },
    keys = {
      { "<LEADER>#", "<CMD>PasteImage<CR>", desc = "Paste image" },
      {
        "<LEADER>#/",
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
