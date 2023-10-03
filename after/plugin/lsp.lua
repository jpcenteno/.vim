local lsp = require('lsp-zero')

lsp.preset('recommended')

-- Tip: Execute `:Mason` to get a list of LSP servers.
lsp.ensure_installed({
    'lua_ls',
    'vimls',
    'pyright', -- Python LSP
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                                                                       ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- Configure format on save using LSP integration:
-- ===============================================
--
-- Why is this config here instead of `ftplugin/<lang>.vim`?
-- ---------------------------------------------------------
--
-- While I prefer to place language-specific settins in the `ftplugin/`
-- directory, I had to place this here because it depends on the LSP server
-- setup.
--
-- While some posts on the internet suggest implementing this as an `autocmd`:
-- ```
-- autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
-- ```
-- This approach might fail on save if the LSP server is not configured.
lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
    }
})

-- local sign_icon = "△"
-- local sign_icon = "▲"
-- local sign_icon = "•"
local sign_icon = "◆"
lsp.set_sign_icons({
    error = sign_icon,
    warn = sign_icon,
    hint = sign_icon,
    info = sign_icon,
})

lsp.setup()

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Autocomplete                                                          ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- The `lsp-zero` README recommends to use `nvim-cmp` directly to set its
-- mappings. It is important to setup `cmp` after `lsp-zero`.

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Navigate back and forward throug autocomplete suggestions.
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),

        -- Navigate between LuaSnip placeholders
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Snippets                                                              ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

require('luasnip.loaders.from_vscode').lazy_load()
