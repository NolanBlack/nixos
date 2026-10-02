-- Disable the default Tab mapping
vim.g.copilot_no_tab_map = true

-- Map Right Arrow to accept suggestion
vim.api.nvim_set_keymap("i", "<Right>", 'copilot#Accept("<CR>")', { silent = true, script = true, expr = true })

