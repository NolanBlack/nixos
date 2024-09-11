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
-- require('telescope').load_extension('fzf')
require('telescope')

