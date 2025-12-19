vim.api.nvim_create_user_command("DeleteFile", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    print("No file to delete!")
    return
  end

  local confirm = vim.fn.confirm("Delete file: " .. file .. "?", "&Yes\n&No", 2)
  if confirm ~= 1 then
    print("File deletion aborted.")
    return
  end

  local ok, err = os.remove(file)
  if not ok then
    print("Error deleting file: " .. err)
    return
  end

  Snacks.bufdelete()
  print("Deleted file: " .. file)
end, {})

vim.api.nvim_create_user_command("SetTabLength", function(opts)
  local len = tonumber(opts.args)
  if not len then
    print("Invalid argument. Please provide a number.")
    return
  end
  vim.opt.tabstop = len
  vim.opt.shiftwidth = len
  print("Tab length set to: " .. len)
end, { nargs = 1 })

vim.api.nvim_create_user_command("DetectIndent", function() require("indent_detect").detect() end, {})

