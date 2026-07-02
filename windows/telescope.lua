-- Select multiple tabs
-- https://github.com/nvim-telescope/telescope.nvim/issues/1048
local myactions = {}

local transform_mod = require("telescope.actions.mt").transform_mod
local action_state = require "telescope.actions.state"
local state = require "telescope.state"
local telescope_pickers = require "telescope.pickers"
local action_set = require "telescope.actions.set"


local get_entries = function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()
    return #multi_selection > 1 and multi_selection or { action_state.get_selected_entry() }
end

local set_status_with_close_func = function(prompt_bufnr, orig_status, orig_picker, close_func)
    orig_status.picker = orig_picker
    orig_picker.close_windows = close_func
    state.set_status(prompt_bufnr, orig_status)
end

--- works around telescope's api (bad hack)
local get_action_set_edit_with_multi_support = function(command)
    return function(prompt_bufnr)
        local orig_status = state.get_status(prompt_bufnr)
        local orig_picker = orig_status.picker
        local orig_close_windows = orig_picker.close_windows

        for _, entry in ipairs(get_entries(prompt_bufnr)) do
          state.set_global_key("selected_entry", entry)
          set_status_with_close_func(prompt_bufnr, orig_status, orig_picker, function() end)
          action_set.edit(prompt_bufnr, command)
        end

        set_status_with_close_func(prompt_bufnr, orig_status, orig_picker, orig_close_windows)
        telescope_pickers.on_close_prompt(prompt_bufnr)
    end
end

local my_find_files
my_find_files = function(opts, no_ignore)
  opts = opts or {}
  no_ignore = vim.F.if_nil(no_ignore, false)
  opts.attach_mappings = function(_, map)
    map({ "n", "i" }, "<C-h>", function(prompt_bufnr) -- <C-h> to toggle modes
      local prompt = require("telescope.actions.state").get_current_line()
      require("telescope.actions").close(prompt_bufnr)
      no_ignore = not no_ignore
      my_find_files({ default_text = prompt }, no_ignore)
    end)
    return true
  end

  if no_ignore then
    opts.no_ignore = true
    opts.hidden = true
    opts.prompt_title = "Find Files <ALL>"
    require("telescope.builtin").find_files(opts)
  else
    opts.prompt_title = "Find Files"
    require("telescope.builtin").find_files(opts)
  end
end

-- vim.keymap.set("n", "<leader>F", my_find_files) -- you can then bind this to whatever you want

--- Like actions.select_tab but supports multiple selections
myactions.select_tab = get_action_set_edit_with_multi_support(action_state.select_key_to_edit_key("tab"))
--- Like actions.select_vertical but supports multiple selections
myactions.select_vertical = get_action_set_edit_with_multi_support(action_state.select_key_to_edit_key("vertical"))

myactions = transform_mod(myactions)

local function stopinsert(callback)
    return function(prompt_bufnr)
        vim.cmd.stopinsert()
        vim.schedule(function()
            callback(prompt_bufnr)
        end)
    end
end

require('telescope').setup({
    defaults = {
        initial_mdoe = "normal",
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        scroll_strategy = "limit", 
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 40,
        },
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-q>"] = require('telescope.actions').send_selected_to_qflist 
                        + require('telescope.actions').open_qflist,
                ["<c-t>"] = stopinsert(myactions.select_tab),
            },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- add this 
        },
    },
    extensions = {
            fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or respect_case"
                                             -- the default case_mode is "smart_case"
            initial_mdoe = "normal",
            }
    },
})
-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
-- If you later switch picker plugins, this is where to update these mappings.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf

    -- Find references for the word under your cursor.
    vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

    -- Jump to the implementation of the word under your cursor.
    -- Useful when your language has ways of declaring types without an actual implementation.
    vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

    -- Jump to the definition of the word under your cursor.
    -- This is where a variable was first declared, or where a function is defined, etc.
    -- To jump back, press <C-t>.
    vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

    -- Fuzzy find all the symbols in your current document.
    -- Symbols are things like variables, functions, types, etc.
    vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

    -- Fuzzy find all the symbols in your current workspace.
    -- Similar to document symbols, except searches over your entire project.
    vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

    -- Jump to the type of the word under your cursor.
    -- Useful when you're not sure what type a variable is and you want to see
    -- the definition of its *type*, not where it was *defined*.
    vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
  end,
})

vim.keymap.set('n', 'gt', function()
  require('telescope.builtin').lsp_type_definitions({ jump_type = 'tab' })
end, { desc = 'Goto type definition in new tab' })
vim.keymap.set('n', 'gd', function()
  require('telescope.builtin').lsp_definitions({ jump_type = 'tab' })
end, { desc = 'Goto definition in new tab' })

