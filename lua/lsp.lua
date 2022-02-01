local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's
-- ready (i.e. when installation is finished or if the server is already
-- installed).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    server:setup(opts)
end)

-- There was another configuration example at the [readme] that installed the
-- LSPs from a list. Personally, I prefer to manually install them when I need
-- them. This way, my system does not get cluttered with random LSPs for
-- languages I don't use anymore.
