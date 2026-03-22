return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Load default mappings first
        api.config.mappings.default_on_attach(bufnr)

        -- Add your custom mappings
        vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
      end,
      view = {
        adaptive_size = true,
        side = "right",
      },
    },
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

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
        "typescript-language-server",
        "java",
        "javascript",
        "dart",
      },
    },
  },
}
