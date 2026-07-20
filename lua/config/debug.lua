vim.api.nvim_create_user_command("DebugRuntimePath", function()
  vim.cmd("new")

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.opt.runtimepath:get())

  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.modifiable = false
  vim.bo.readonly = true
end, {
  desc = "Show the runtimepath, one entry per line",
})
