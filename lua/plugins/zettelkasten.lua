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
    {
      "<localleader>ln",
      function()
        require("zettelkasten.edit").surround_visual_selection_with_link_to_note()
      end,
      mode = "v",
      ft = { "markdown" },
      desc = "Surround with link to note",
    },
  },
}
