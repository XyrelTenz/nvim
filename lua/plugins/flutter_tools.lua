return {
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			local nvlsp = require("nvchad.configs.lspconfig")

			local flutter_sdk = vim.fn.expand("~/.cache/flutter_sdk")
			local flutter_bin = flutter_sdk .. "/bin/flutter"
			local dart_bin = flutter_sdk .. "/bin/cache/dart-sdk/bin/dart"

			if vim.fn.executable(flutter_bin) ~= 1 or vim.fn.executable(dart_bin) ~= 1 then
				vim.notify(
					"Flutter SDK is unavailable at " .. flutter_sdk .. ". Mount the Dart 3.13 SDK before opening Dart files.",
					vim.log.levels.ERROR
				)
				return
			end

			require("flutter-tools").setup({
				flutter_path = flutter_bin,

				fvm = false,

				emulator_args = {
					"--enable-gpu-libvulkan",
					"--gpu",
					"host",
				},
				executable = {
					env = {
						QT_QPA_PLATFORM = "xcb",
					},
				},
				ui = {
					border = "rounded",
				},
				decorations = {
					statusline = {
						app_version = true,
						device = true,
					},
				},
				debugger = {
					enabled = false,
					run_via_dap = false,
				},
				widget_guides = {
					enabled = true,
				},
				closing_tags = {
					highlight = "Comment",
					prefix = "///",
					enabled = true,
				},
				dev_log = {
					filter = nil,
					enabled = true,
					open_cmd = "15split",
				},
				outline = {
					auto_open = false,
					width = 100,
				},
				dev_tools = {
					autostart = false,
					auto_open_browser = false,
				},
				lsp = {
					cmd = { dart_bin, "language-server", "--protocol=lsp" },
					capabilities = nvlsp.capabilities,
					on_attach = nvlsp.on_attach,
					settings = {
						showTodos = true,
						completeFunctionCalls = true,
						renameFilesWithClasses = "prompt",
						updateImportsOnRename = true,
						dart_code_metrics = true,
					},
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.dart",
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end,
	},
	{
		"sidlatau/flutter-icons.nvim",
		dependencies = { "folke/snacks.nvim" },
	},
}
