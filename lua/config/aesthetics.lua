local M = {}

M.set_colorscheme = function()
  vim.opt.termguicolors = false
  vim.opt.background = "dark"
  vim.cmd.colorscheme("base16-default-dark")
end

M.setup = function(_)
  -- Disable intro message.
  vim.opt.shortmess:append("I")

  -- Prevent syntax highlighting from breaking after very long lines.
  vim.opt.synmaxcol = 0

  -- Vertical scroll margin.
  vim.opt.scrolloff = 5

  -- Clip longer lines instead of wrapping.
  vim.opt.wrap = false

  -- Default text width. Override it in a per language / project basis.
  vim.opt.textwidth = 80

  -- Highlight row with cursor.
  vim.opt.cursorline = true

  M.set_colorscheme()
end

return M
