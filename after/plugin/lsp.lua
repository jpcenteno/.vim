-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ NeoVim LSP setup:                                                     ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- LSP-Zero setup guide:
-- https://github.com/VonHeikemen/lsp-zero.nvim#quickstart-for-the-impatient
--
-- Configuration options for LSP servers with official support:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr) -- Ignored first argument `client`.
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- Adds a border to the `:LspInfo` and other windows.
require('lspconfig.ui.windows').default_options.border = 'single'

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Per-language LSP setup:                                               ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local lspconfig = require('lspconfig')

lsp_zero.setup_servers({
  'rust_analyzer', -- Installed by my Rust provisioning script.
  'vimls',         -- Optionally installed by my NeoVim setup script.
  'eslint',        -- `npm i -g vscode-langservers-extracted` (provided by my sdk_typescript role)
  'clojure_lsp',   -- Add `clojure-lsp` to Nix development shell.
})

lspconfig.elixirls.setup {
  cmd = { "elixir-ls" }
}

lspconfig.denols.setup {
  -- Prevent attachment into a Node project.
  -- See https://docs.deno.com/runtime/manual/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

require 'lspconfig'.gopls.setup {}

lspconfig.nil_ls.setup {
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
}

lspconfig.tsserver.setup {
  -- Prevent attachment into a Deno project.
  -- See https://docs.deno.com/runtime/manual/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
  root_dir = lspconfig.util.root_pattern("package.json"),
  single_file_support = false
}

-- > If you primarily use lua-language-server for Neovim, and want to provide completions, analysis,
-- > and location handling for plugins on runtime path, you can use the following settings.
-- >
-- > -- Source: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Cmp config                                                            ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'async_path' },
  }, {
    { name = 'buffer' },
  })
})
