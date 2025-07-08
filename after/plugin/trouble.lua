local trouble = require("trouble")

trouble.setup({
  auto_close = true, -- auto close when there are no items.
  focus = true, -- Focus the window when opened
  open_no_results = true, -- open the trouble window when there are no results
})

-- Make the fold triangles the same color as the file name.
vim.api.nvim_set_hl(0, "TroubleFoldIcon", { link = "TroubleFile" })

vim.diagnostic.config({
  -- Disable inline LSP messages since Trouble.vim makes them redundant.
  virtual_text = false,
})
