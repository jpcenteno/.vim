return {
  "dhruvasagar/vim-table-mode",
  ft = "markdown",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true }),
      pattern = "markdown",
      callback = function()
        vim.api.nvim_command("TableModeEnable")
      end,
    })
  end,
}
