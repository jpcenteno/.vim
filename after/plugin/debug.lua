vim.api.nvim_create_user_command("DebugRuntimePath", function()
  require("config.debug").display_runtime_path()
end, {
  desc = "Show the runtimepath",
})
