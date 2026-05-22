-- nvim-jdtls configuration for Java files
-- This runs every time a Java buffer is opened.
-- jdtls is excluded from mason-lspconfig's automatic_enable so it is
-- managed entirely here (allows workspace-aware root detection via bemol).

local jdtls = require('jdtls')

-- Find the jdtls executable installed by Mason
local mason_registry = require('mason-registry')
local jdtls_pkg = mason_registry.get_package('jdtls')
local jdtls_path = jdtls_pkg:get_install_path()
local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local config_dir = jdtls_path .. '/config_linux'

-- Unique data directory per project (avoids reindexing when switching projects)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name

-- Root detection: look for bemol-generated .project, or standard build files
local root_dir = require('jdtls.setup').find_root({
  '.project',        -- bemol generates this
  'build.gradle.kts',
  'build.gradle',
  'settings.gradle.kts',
  'settings.gradle',
  'pom.xml',
  '.git',
})

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx2g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', launcher,
    '-configuration', config_dir,
    '-data', workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      -- Let bemol-generated .classpath/.settings handle most config
      configuration = {
        -- Detect runtimes installed on the system
        runtimes = {},
      },
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      references = { includeDecompiledSources = true },
      format = { enabled = true },
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          'org.junit.Assert.*',
          'org.junit.jupiter.api.Assertions.*',
          'org.mockito.Mockito.*',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    -- nvim-jdtls extras: code generation, organize imports, extract variable/method
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.setup').add_commands()
  end,
}

jdtls.start_or_attach(config)
