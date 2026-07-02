-- [[ Autocomplete Engine ]]
require('blink.cmp').setup {
  keymap = {
    -- 'default' (recommended) for mappings similar to built-in completions
    --   <c-y> to accept ([y]es) the completion.
    --    This will auto-import if your LSP supports it.
    --    This will expand snippets if the LSP sent a snippet.
    -- 'super-tab' for tab to accept
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- For an understanding of why the 'default' preset is recommended,
    -- you will need to read `:help ins-completion`
    --
    -- No, but seriously. Please read `:help ins-completion`, it is really good!
    --
    -- All presets have the following mappings:
    -- <tab>/<s-tab>: move to right/left of your snippet expansion
    -- <c-space>: Open menu or open docs if already open
    -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
    -- <c-e>: Hide menu
    -- <c-k>: Toggle signature help
    --
    -- See `:help blink-cmp-config-keymap` for defining your own keymap
		-- The 'default' preset includes the following mappings:
		-- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      	-- ['<C-e>'] = { 'hide', 'fallback' },
      	-- ['<C-y>'] = { 'select_and_accept', 'fallback' },
      	-- ['<Up>'] = { 'select_prev', 'fallback' },
      	-- ['<Down>'] = { 'select_next', 'fallback' },
      	-- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      	-- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
      	-- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      	-- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      	-- ['<Tab>'] = { 'snippet_forward', 'fallback' },
      	-- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      	-- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        -- preset = 'default',
        -- ["<Tab>"] = { "select_next", "fallback" },
        -- ["<S-Tab>"] = { "select_prev", "fallback" },
      preset = 'default',
	  ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },

    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  },
  cmdline = {
      keymap = {
          preset = 'inherit',
          --- <C-Space> inherited from top-level keymap
      }
  },
  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono',
  },

  completion = {
    -- By default, you may press `<c-space>` to show the documentation.
    -- Optionally, set `auto_show = true` to show the documentation after a delay.
    -- documentation = { auto_show = true, auto_show_delay_ms = 500 },
    documentation = { auto_show = true},
	list = {
      selection = {
			preselect = false,
			auto_insert = true,
		},
	},
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
	providers = {
		  buffer = {
			name = 'Buffer',
			module = 'blink.cmp.sources.buffer',
			-- Tweak performance options
			opts = {
			  -- Suggest from all listed and open buffers
			  get_bufnrs = function()
				return vim.tbl_filter(function(bufnr)
				  return vim.fn.buflisted(bufnr) == 1
				end, vim.api.nvim_list_bufs())
			  end,
			}
		  }
		},

  },

  snippets = { preset = 'luasnip' },

  -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
  -- which automatically downloads a prebuilt binary when enabled.
  --
  -- By default, we use the Lua implementation instead, but you may enable
  -- the rust implementation via `'prefer_rust_with_warning'`
  --
  -- See `:help blink-cmp-config-fuzzy` for more information
  fuzzy = { implementation = 'lua' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}


