local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', 't',     api.node.open.tab, opts('Open: New Tab'))
end
require("nvim-tree").setup {
    on_attach = my_on_attach,
    filters = {
        dotfiles = true,
    },
}

