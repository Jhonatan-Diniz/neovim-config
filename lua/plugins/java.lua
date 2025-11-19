local jdtls_ok, jdtls = pcall(require, 'jdtls')
if not jdtls_ok then
  return
end

-- --- Begin Windows Specific Paths ---
local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls/'
-- You MUST update this path to your Java 17+ executable location
local java_exe = 'C:/Program Files/Java/jdk-25/bin/java.exe'
local launcher_jar = vim.fn.glob(jdtls_path .. 'plugins/org.eclipse.equinox.launcher_*.jar', false, true)[1]
local config_path = jdtls_path .. 'config_win'
-- --- End Windows Specific Paths ---

local config = {}
config.root_dir = jdtls.setup.find_root({'gradlew', 'mvnw', '.git', 'pom.xml', 'build.gradle'})

if not config.root_dir then
  print("JDTLS: Could not find project root. Not starting.")
  return
end

local project_name = vim.fn.fnamemodify(config.root_dir, ':p:h:t')
config.workspace_dir = vim.fn.stdpath('cache') .. '/jdtls-workspace/' .. project_name

config.cmd = {
  java_exe,
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.level=ALL',
  '-Xms1G',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  '-jar', launcher_jar,
  '-configuration', config_path,
  '-data', config.workspace_dir,
}

config.on_attach = function(client, bufnr)
  -- Setup your keymaps here
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<leader>o', jdtls.organize_imports, bufopts)
  -- Add other keymaps as needed
end

config.settings = {
  java = {
    -- Your general Java settings here
  }
}

-- Start the language server
jdtls.start_or_attach(config)
