local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require('lspconfig')
local trouble = require("trouble")

--------------------------------------------------------------------------------
-- Mason: LSP Installer
--------------------------------------------------------------------------------

mason.setup()

-- What value is `mason-lspconfig` providing here?
mason_lspconfig.setup({
    ensure_installed = { "rust_analyzer", "shellcheck", "elixirls" },
    automatic_installation = true,
})

--------------------------------------------------------------------------------
-- Configure LSPs
--------------------------------------------------------------------------------

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = { 'rust_analyzer', "elixirls" }

for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach
    }
end

--------------------------------------------------------------------------------
-- NULL-LS
--------------------------------------------------------------------------------

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck
    },
})


--------------------------------------------------------------------------------
-- Error display                                                              --
--------------------------------------------------------------------------------

-- Configure how inline diagnostics are shown.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- When the same line has more than one LSP message, prioritize them by
        -- severity (i.e. Prioritize an error over an info message).
        severity_sort = true,

        -- Don't display the diagnostic messages inline. Use `Trouble.nvim` to
        -- read them instead.
        virtual_text = false
    }
)

-- Use color-coded `●` symbols for the LSP gutter.
vim.cmd [[
    sign define DiagnosticSignError text=● linehl= texthl=DiagnosticSignError numhl=
    sign define DiagnosticSignWarn text=● linehl= texthl=DiagnosticSignWarn numhl=
    sign define DiagnosticSignInfo text=● linehl= texthl=DiagnosticSignInfo numhl=
    sign define DiagnosticSignHint text=● linehl= texthl=DiagnosticSignHint numhl=
]]

trouble.setup {}

--------------------------------------------------------------------------------
-- AutoComple                                                                 --
--------------------------------------------------------------------------------

local cmp = require('cmp')

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
    }, {
      { name = 'buffer' },
    })
}

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
