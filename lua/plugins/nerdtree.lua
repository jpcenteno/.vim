return {
  "preservim/nerdtree",
  dependencies = {
    "ryanoasis/vim-devicons",
  },
  keys = {
    { "<leader>ft", ":NERDTreeToggle<CR>", "File tree" },
  },
  config = function()
    vim.g.webdevicons_enable_nerdtree = 1
  end,
}
