return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    local nvlsp = require "nvchad.configs.lspconfig"

    require("flutter-tools").setup {
      ui = {
        border = "rounded",
        -- notification_style = "nvim-notify",
        notification_style = "native",
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
        prefix = "//",
        enabled = true,
      },
      fvm = true,
      dev_log = {
        enabled = false,
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
        capabilities = nvlsp.capabilities,
        on_attach = nvlsp.on_attach,
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          updateImportsOnRename = true,
        },
      },
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.dart",
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })
  end,
}
