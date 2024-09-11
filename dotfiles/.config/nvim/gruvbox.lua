require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = false,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {
        -- bright_green = "#8ec07c", -- aqua
        -- bright_green = "#ebdbb2", -- aqua
        -- bright_yellow = "#458588", -- mustard

        -- bright_green = "#d5c4a1", -- gray bg
        -- bright_yellow = "#d79921", -- mustard
        -- bright_orange = "#83a598", -- light blue
    },
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
