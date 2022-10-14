local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require('lspconfig')

mason.setup()

mason_lspconfig.setup({
    ensure_installed = { "rust_analyzer" },
    automatic_installation = true,
})

lspconfig['rust_analyzer'].setup{}
