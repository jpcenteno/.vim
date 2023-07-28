require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
      "clojure",
      "css",
      "eex",
      "elixir",
      "glsl",
      "heex",
      "javascript",
      "json",
      "ledger",
      "lua",
      "make",
      "nix",
      "rust",
      "solidity",
      "typescript",
      "vim",
      "vimdoc",
      "wgsl",
      "yaml"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},
  },
}

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Use `nvim-treesitter` for code folding                                ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- Enable folding and set foldmethod to 'expr'.
vim.opt.foldmethod = 'expr'

-- Set the fold expression to the Treesitter foldexpr.
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Open new buffers unfolded.
vim.opt.foldenable = false
