return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = {},
    notifier = {},
    picker = { ui_select = true },
  },
  keys = {
    { "<leader><leader>", function() Snacks.picker.commands() end,  desc = "Commands" },
    { "<leader>bb",       function() Snacks.picker.buffers() end,   desc = "Find buffers" },
    { "<leader>ff",       function() Snacks.picker.files() end,     desc = "Find files" },
    { "<leader>fg",       function() Snacks.picker.git_files() end, desc = "Find git files" },
    { "<leader>fr",       function() Snacks.picker.grep() end,      desc = "Grep PWD" },
  },
}
