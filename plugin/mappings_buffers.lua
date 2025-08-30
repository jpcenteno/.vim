vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { desc = "Next buffer" })
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { desc = "Previous buffer" })
vim.api.nvim_set_keymap('n', '<leader>bd', ':bp|bd#<CR>', { desc = "Delete buffer" })
