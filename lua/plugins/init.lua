return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("configs.conform"),
	},
	{
		"NvChad/ui",
		lazy = false,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			filters = {
				custom = { "node_modules", "target", "build", "dist", "out" },
				dotfiles = true,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end
				api.config.mappings.default_on_attach(bufnr)
				vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
			end,
			view = { adaptive_size = true, side = "right" },
		},
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-l>",
				},
			},
			panel = { enabled = false },
		},
	},

	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
	{
		"saghen/blink.cmp",
		build = "cargo build --release",
		opts = {
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
	},

	{ import = "nvchad.blink.lazyspec" },
	-- Auto Give Commit Messages
	{
		"ajatdarojat45/commitmate.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"CopilotC-Nvim/CopilotChat.nvim",
		},
		config = function()
			require("commitmate").setup({
				open_lazygit = true,
				ping_message = "CommitMate.nvim is ready",
			})
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		lazy = false,
		config = function()
			require("project_nvim").setup({
				detection_methods = { "lsp", "pattern" },
				patterns = { ".git", "package.json", "pubspec.yaml", "build.gradle.kts" },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"kotlin",
				"typescript",
				"java",
				"javascript",
				"dart",
				"gopls",
			},
		},
	},

	{
		"AlexandrosAlexiou/kotlin.nvim",
		ft = { "kotlin" },
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			local nvlsp = require("nvchad.configs.lspconfig")

			require("kotlin").setup({
				-- Pass NvChad's LSP mappings and capabilities
				on_attach = nvlsp.on_attach,
				capabilities = nvlsp.capabilities,

				root_markers = {
					"gradlew",
					".git",
					"mvnw",
					"settings.gradle",
				},

				-- Use the bundled JRE (let the plugin/Mason handle it)
				jre_path = nil,

				-- Auto-detect from project
				jdk_for_symbol_resolution = nil,

				jvm_args = {
					"-Xmx4g",
				},

				inlay_hints = {
					enabled = true,
					parameters = true,
					parameters_compiled = true,
					parameters_excluded = false,
					types_property = true,
					types_variable = true,
					function_return = true,
					function_parameter = true,
					lambda_return = true,
					lambda_receivers_parameters = true,
					value_ranges = true,
					kotlin_time = true,
				},
			})
		end,
	},
}
