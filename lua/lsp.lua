local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require('lspconfig')

mason.setup()

-- What value is `mason-lspconfig` providing here?
mason_lspconfig.setup({
    ensure_installed = { "rust_analyzer" },
    automatic_installation = true,
})

local on_attach = function(client, bufnr)
end

local servers = { 'rust_analyzer' }

for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach
    }
end
