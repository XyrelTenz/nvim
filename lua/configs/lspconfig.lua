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

vim.lsp.config("kotlin_language_server", {
	root_markers = { "settings.gradle", "build.gradle", "build.gradle.kts", ".git" },
})

vim.lsp.enable({
	"html",
	"cssls",
	"ts_ls",
	"tailwindcss",
	"luals",
	"kotlin_language_server",
	"dartls",
	"jdtls",
	"gopls",
	"sqls",
	"vue_ls",
})

vim.lsp.handlers["textDocument/definition"] = function(_, result, ctx, config)
	if not result or vim.tbl_isempty(result) then
		return
	end
	if vim.tbl_islist(result) and #result > 1 then
		vim.lsp.util.jump_to_location(result[1], "utf-8")
	else
		vim.lsp.util.jump_to_location(result, "utf-8")
	end
end

require("telescope").load_extension("projects")
