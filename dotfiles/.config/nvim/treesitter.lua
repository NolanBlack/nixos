require('nvim-treesitter')

-- :h treesitter-highlight-groups for details
-- :h ctermfg for color names
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
        vim.api.nvim_set_hl(0, "@variable.parameter", { link = "variable" })
        -- vim.api.nvim_set_hl(0, "@variable.member", { link = "variable" })
        vim.api.nvim_set_hl(0, "@variable.member", { fg = "LightGrey", bg = "", italic = false, underline = false, sp = ""})
        vim.api.nvim_set_hl(0, "@function", { fg = "LightRed", bg = "", italic = true, underline = false, sp = ""})
        vim.api.nvim_set_hl(0, "@function.call", { fg = "Tan", bg = "", italic = false, underline = false, sp = ""})
        vim.api.nvim_set_hl(0, "@function.builtin", { fg = "Tan", bg = "", italic = false, underline = false, sp = ""})
        vim.api.nvim_set_hl(0, "@constructor", { fg = "Tan", bg = "", italic = false, underline = false, sp = ""})
        vim.api.nvim_set_hl(0, "@function.method", { fg = "LightRed", bg = "", italic = true, underline = false, sp = ""})
        vim.api.nvim_set_hl(0, "@function.method.call", { fg = "LightRed", bg = "", italic = false, underline = false, sp = ""})
	end,
})
