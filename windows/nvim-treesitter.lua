local parsers = { 'bash', 'c', 'cpp', 'python', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
require('nvim-treesitter').install(parsers)

local function treesitter_try_attach(buf, language)
  -- Check if a parser exists and load it
  if not vim.treesitter.language.add(language) then return end
  -- Enable syntax highlighting and other treesitter features
  vim.treesitter.start(buf, language)

  -- Enable treesitter based folds
  -- For more info on folds see `:help folds`
  -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  -- vim.wo.foldmethod = 'expr'

  -- Check if treesitter indentation is available for this language, and if so enable it
  -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
  local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

  -- Enable treesitter based indentation
  if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed_parsers, language) then
      -- Enable the parser if it is already installed
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
      require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
    else
      -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
      treesitter_try_attach(buf, language)
    end
  end,
})


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
        vim.api.nvim_set_hl(0, "@function.builtin", { fg = "LightBlue", bg = "", italic = false, underline = false, sp = ""})
        vim.api.nvim_set_hl(0, "@constructor", { fg = "Tan", bg = "", italic = false, underline = false, sp = ""})
        vim.api.nvim_set_hl(0, "@function.method", { fg = "LightRed", bg = "", italic = true, underline = false, sp = ""})
        vim.api.nvim_set_hl(0, "@function.method.call", { fg = "LightRed", bg = "", italic = false, underline = false, sp = ""})
        vim.api.nvim_set_hl(0, '@lsp.type.type.cpp', { link = 'Type' })
        vim.api.nvim_set_hl(0, '@lsp.type.class.cpp', { link = 'Type' })
        vim.api.nvim_set_hl(0, '@lsp.type.enum.cpp', { link = 'Type' })
        vim.api.nvim_set_hl(0, '@lsp.type.struct.cpp', { link = 'Type' })
        vim.api.nvim_set_hl(0, '@lsp.type.class.cpp', { fg = 'LightPink' })
	end,
})

