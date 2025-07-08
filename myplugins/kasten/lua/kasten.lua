vim.api.nvim_set_keymap(
  "v",
  "<localleader>ln",
  ':lua require("kasten.link").insert_link()<CR>',
  { noremap = true, silent = true }
)
