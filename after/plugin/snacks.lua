local snacks = require('snacks')

snacks.setup({
  picker = {
    ui_select = true,
  },
  notifier = {}
})

vim.api.nvim_set_keymap('n', '<leader>bb', '', {
  callback = snacks.picker.buffers,
  desc = "Find Buffers",
})

vim.api.nvim_set_keymap('n', '<leader>ff', '', {
  callback = snacks.picker.files,
  desc = "Find files",
})

vim.api.nvim_set_keymap('n', '<leader>fg', '', {
  callback = snacks.picker.git_files,
  desc = 'Find Git files',
})

vim.api.nvim_set_keymap('n', '<leader>fr', '', {
  callback = snacks.picker.grep,
  desc = 'Grep',
})

vim.api.nvim_set_keymap('n', '<leader><leader>', '', {
  callback = snacks.picker.commands,
  desc = 'Commands',
})
