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
    '--branch=stable',
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)

-- Always show the sign column so diagnostics don't shift the display
vim.opt.signcolumn = 'yes'
-- Lower CursorHold delay for faster document highlight (default 4000ms)
vim.opt.updatetime = 300

require('lazy').setup({
  -- Colorscheme (overrides .vimrc's joshdick/onedark.vim which remains for plain vim)
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[set termguicolors]])
      require('onedark').setup({ style = 'dark' })
      require('onedark').load()
    end,
  },
  -- Tpope essentials (mirror .vimrc for nvim-specific loading)
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
  -- LSP infrastructure
  {'mason-org/mason.nvim'},
  {'mason-org/mason-lspconfig.nvim'},
  {'neovim/nvim-lspconfig'},
  -- Java LSP (ftplugin-driven, not auto-enabled by mason-lspconfig)
  {'mfussenegger/nvim-jdtls'},
  -- Autocompletion
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/cmp-vsnip'},
  {'hrsh7th/vim-vsnip'},
  -- UI
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'c', 'lua', 'vim', 'vimdoc', 'query',
          'java', 'kotlin',
          'javascript', 'typescript', 'html',
          'elixir', 'heex',
        },
        sync_install = false,
        highlight = { enable = true },
        indent = {
          enable = true,
          disable = { 'java' },
        },
      })
    end,
  },
})

---
-- LSP setup (native Neovim 0.11+ pattern, replaces lsp-zero)
---

-- Advertise cmp capabilities to all language servers
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
  capabilities = lsp_capabilities,
})

-- Per-server configuration via vim.lsp.config (replaces lsp-zero handlers)
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
    },
  },
})

vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'standard',
      },
    },
  },
})

-- Mason installs servers, mason-lspconfig auto-enables them via vim.lsp.enable()
require('mason').setup({
  pip = {
    install_args = { '--constraint', os.getenv('HOME') .. '/.config/pip/constraints.txt' },
  },
})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls', 'basedpyright', 'ruby_lsp', 'smithy_ls',
    'kotlin_language_server', 'eslint', 'lua_ls', 'jdtls',
  },
  -- jdtls is managed by nvim-jdtls via ftplugin, not auto-enabled here
  automatic_enable = {
    exclude = { 'jdtls' },
  },
})

-- LSP keymaps and document highlight on attach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gz', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'tr', function() require('trouble').toggle('diagnostics') end, opts)

    -- Highlight other references of symbol under cursor
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.supports_method('textDocument/documentHighlight') then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = ev.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = ev.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

---
-- Document highlight (native, replaces vim-illuminate)
---
local exclude_highlight_ft = { 'help', 'git', 'markdown', 'snippets', 'text',
  'gitconfig', 'alpha', 'dashboard', 'dirbuf', 'dirvish', 'fugitive' }

vim.api.nvim_set_hl(0, 'LspReferenceText', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'LspReferenceRead', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { link = 'Visual' })

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'LspReferenceText', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'LspReferenceRead', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { link = 'Visual' })
  end,
})

require('ibl').setup({
  indent = { char = '|' },
  scope = { enabled = true },
  exclude = {
    filetypes = exclude_highlight_ft,
    buftypes = { 'terminal' },
  },
})

---
-- Autocompletion config
---
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
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
    end, { 'i', 's', 'c' }),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-c>'] = cmp.mapping.abort(),
    -- cmdline only
    ['<C-n>'] = { c = cmp.mapping.select_next_item() },
    ['<C-p>'] = { c = cmp.mapping.select_prev_item() },
    ['<C-e>'] = { c = cmp.mapping.abort() },
    ['<C-y>'] = { c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }) },
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
        end,
      },
    },
  }),
  experimental = {
    ghost_text = true,
  },
})

cmp.setup.cmdline('/', {
  sources = { { name = 'buffer' } },
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources(
    { { name = 'path' } },
    { { name = 'cmdline' } }
  ),
})
