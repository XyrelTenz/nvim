local nvlsp = require("nvchad.configs.lspconfig")
local mason_registry = require("mason-registry")

local servers = { "html", "cssls", "tailwindcss", "luals", "kotlin_lsp", "jdtls", "gopls", "sqls", "volar" }
require("telescope").load_extension("projects")

for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, {
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	})
end

local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
	.. "/node_modules/@vue/language-server"

vim.lsp.config("ts_ls", {
	on_attach = nvlsp.on_attach,
	on_init = nvlsp.on_init,
	capabilities = nvlsp.capabilities,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

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

vim.lsp.config("gopls", {
	on_attach = nvlsp.on_attach,
	capabilities = nvlsp.capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			completeUnimported = true,
			usePlaceholders = true,
		},
	},
})

vim.lsp.enable({ "html", "cssls", "ts_ls", "tailwindcss", "kotlin_lsp", "dartls", "jdtls", "gopls", "sqls", "volar" })
