local nvlsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")
vim.lsp.config("*", {
	on_init = nvlsp.on_init,
	on_attach = nvlsp.on_attach,
	capabilities = nvlsp.capabilities,
})

local vue_plugin_path = "/usr/lib/node_modules/@vue/typescript-plugin"

vim.lsp.config("ts_ls", {
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_plugin_path,
				languages = { "vue" },
			},
		},
	},
})

vim.lsp.config("vue_ls", {
	cmd = { "/usr/bin/vue-language-server", "--stdio" },
	on_attach = function(client, bufnr)
		client.server_capabilities.definitionProvider = false
		nvlsp.on_attach(client, bufnr)
	end,
	init_options = {
		vue = {
			hybridMode = true,
		},
	},
})

local servers = { "html", "cssls", "tailwindcss", "luals", "jdtls", "sqls", "gopls", "dartls" }

for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, {})
end

vim.lsp.config("kotlin_lsp", {
	on_attach = nvlsp.on_attach,
	capabilities = nvlsp.capabilities,
	on_init = nvlsp.on_init,
	root_dir = vim.fs.root(0, { "settings.gradle.kts", "build.gradle.kts", "settings.gradle", "build.gradle", ".git" }),
})

vim.lsp.enable({
	"html",
	"cssls",
	"ts_ls",
	"tailwindcss",
	"luals",
	"kotlin_lsp",
	"dartls",
	"jdtls",
	"gopls",
	"sqls",
	"vue_ls",
})

require("telescope").load_extension("projects")
