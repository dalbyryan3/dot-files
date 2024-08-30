local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    "joshdick/onedark.vim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[set termguicolors]])
      vim.cmd([[colorscheme onedark]])
    end,
  },
  {'tpope/vim-commentary'},
  {'tpope/vim-sleuth'},
  {'tpope/vim-fugitive'},
  {'tpope/vim-obsession'},
  {'tpope/vim-surround'},
  {'tpope/vim-repeat'},
  {'tpope/vim-unimpaired'},
  {'tpope/vim-eunuch'},
  {'tpope/vim-vinegar'},
  {'tpope/vim-flagship'},
  {'tpope/vim-tbone'},
  {'tpope/vim-rsi'},
  {'tpope/vim-abolish'},
  {'ntpeters/vim-better-whitespace'},
  {'junegunn/fzf'},
  {'junegunn/fzf.vim'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'udalov/kotlin-vim'},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
  },
  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    }
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
  },
  {
    'hrsh7th/cmp-buffer',
  },
  {
    'folke/trouble.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  -- vsnip
  {'hrsh7th/cmp-vsnip'},
  {'hrsh7th/vim-vsnip'},
})

---
-- LSP setup
---
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
  vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', {buffer = bufnr})
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', {buffer = bufnr})
  vim.keymap.set('n', 'gz', '<cmd>lua vim.lsp.buf.rename()<cr>', {buffer = bufnr})
  vim.keymap.set('n', 'g.', '<cmd>lua vim.lsp.buf.code_action()<cr>', {buffer = bufnr})
  vim.keymap.set('n', 'tr', function() require('trouble').toggle('diagnostics') end)
end)

--- if you want to know more about lsp-zero and mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed= {'tsserver', 'basedpyright', 'ruby_lsp', 'smithy_ls', 'kotlin_language_server', 'eslint'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      -- (Optional) configure lua language server
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
    basedpyright = function()
      require('lspconfig').basedpyright.setup({
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard"
            }
          }
        }
      })
    end,
  }
})

---
-- Autocompletion config
---
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
	if not entry then
	  cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
	else
	  cmp.confirm()
	end
      else
        fallback()
      end
    end, {"i","s","c",}),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-c>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
  }),
  experimental = {
    ghost_text = true,
  }
})

vim.lsp.set_log_level('debug')

