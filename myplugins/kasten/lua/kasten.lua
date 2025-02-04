vim.api.nvim_set_keymap(
  'v',
  '<localleader>ln',
  ':lua require("kasten.telescope").insert_link()<CR>',
  { noremap = true, silent = true }
)
