local nvlsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")

-- 1. Setup global defaults for the 2026 Native API
vim.lsp.config("*", {
	on_init = nvlsp.on_init,
	on_attach = nvlsp.on_attach,
	capabilities = nvlsp.capabilities,
})

-- 2. Define path to the Vue TypeScript plugin (System-wide or Mason)
-- If using Mason: vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local vue_plugin_path = "/usr/lib/node_modules/@vue/typescript-plugin"

-- 3. Configure TypeScript (ts_ls) with Vue Support
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

-- 4. Configure Vue Language Server (vue_ls)
-- FIX: We disable its definitionProvider so 'gd' jumps directly via ts_ls
vim.lsp.config("vue_ls", {
	cmd = { "/usr/bin/vue-language-server", "--stdio" },
	on_attach = function(client, bufnr)
		-- This stops the "multiple definitions" menu from appearing
		client.server_capabilities.definitionProvider = false
		nvlsp.on_attach(client, bufnr)
	end,
	init_options = {
		vue = {
			hybridMode = true,
		},
	},
})

-- 5. Define and Enable other servers
local servers = { "html", "cssls", "tailwindcss", "luals", "jdtls", "sqls", "gopls", "dartls" }

for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, {}) -- Inherits global config from '*'
end

-- Specialized Kotlin config
vim.lsp.config("kotlin_language_server", {
	root_markers = { "settings.gradle", "build.gradle", "build.gradle.kts", ".git" },
})

-- 6. Activate all servers
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

-- Handle specific definition logic globally to ensure "Direct Jump"
vim.lsp.handlers["textDocument/definition"] = function(_, result, ctx, config)
	if not result or vim.tbl_isempty(result) then
		return
	end
	if vim.tbl_islist(result) and #result > 1 then
		-- Always jump to the first result (usually the source code)
		vim.lsp.util.jump_to_location(result[1], "utf-8")
	else
		vim.lsp.util.jump_to_location(result, "utf-8")
	end
end

require("telescope").load_extension("projects")
