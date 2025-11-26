-- `nvim-treesitter` is a plugin that acts as a _package manager_ for Tree-sitter
-- parsers within Neovim and also provides experimental features over the
-- internal Tree-sitter API.
--
-- I'm using this plugin for the package-managent features because I was unable
-- to get Tree-sitter parsers from Nixpkgs to work with my current editor setup.
return {
  "nvim-treesitter/nvim-treesitter",

  -- NOTE: Development on the `master` branch has been frozen. New development
  -- (with breaking changes) is being done at the `main` branch. However, the
  -- latest version didn't work on my computer, so I'm resorting out to the
  -- compatibility one.
  branch = "master",

  lazy = false, -- Does not support lazy mode.

  config = function()
    require("nvim-treesitter.configs").setup({
      -- NOTE: This setting will change after switching from `master` to the `main`
      -- branch.
      highlight = { enable = true },
    })
  end,
}
