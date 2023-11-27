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

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Per-language LSP setup:                                               ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local lspconfig = require('lspconfig')

lsp_zero.setup_servers({
    'lua_ls',        -- Optionally installed by my NeoVim setup script.
    'rust_analyzer', -- Installed by my Rust provisioning script.
    'vimls',         -- Optionally installed by my NeoVim setup script.
    'eslint',        -- `npm i -g vscode-langservers-extracted` (provided by my sdk_typescript role)
})

lspconfig.denols.setup {
    -- Prevent attachment into a Node project.
    -- See https://docs.deno.com/runtime/manual/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.tsserver.setup {
    -- Prevent attachment into a Deno project.
    -- See https://docs.deno.com/runtime/manual/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
    root_dir = lspconfig.util.root_pattern("package.json"),
    single_file_support = false
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
