local M = {}

M.setup = function(_)
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
  vim.opt.softtabstop = 4

  vim.opt.textwidth = 80
end

return M
