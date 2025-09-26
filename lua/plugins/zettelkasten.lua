return {
  dir = vim.fn.stdpath("config") .. "/myplugins/zettelkasten",
  keys = {
    {
      "<leader>nn",
      function()
        require("zettelkasten").new_note()
      end,
      desc = "New note",
    },
    {
      "<leader>no",
      function()
        require("zettelkasten.pickers").open_note()
      end,
      desc = "Open note",
    },
  },
}
