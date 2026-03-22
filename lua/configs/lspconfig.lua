local nvlsp = require "nvchad.configs.lspconfig"

local servers = { "html", "cssls", "ts_ls", "tailwindcss", "luals", "kotlin_lsp" }

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
end

vim.lsp.config("kotlin_lsp", {
  -- single_file_support = false,
  -- capabilities = nvlsp.capabilities,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  root_dir = vim.fs.root(0, { "settings.gradle", "build.gradle", ".git", "build.gradle.kts" }),
})

vim.lsp.config("dartls", {
  capabilities = nvlsp.capabilities,
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
})

vim.lsp.enable { "html", "cssls", "ts_ls", "tailwindcss", "kotlin_lsp", "dartls" }
