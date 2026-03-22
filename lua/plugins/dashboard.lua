return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      "notjedi/nvim-rooter.lua",
      config = function()
        require("nvim-rooter").setup {
          rooter_patterns = { ".git", "build.gradle.kts", "settings.gradle.kts", "pom.xml", "Makefile", "pubspec.yaml" },
        }
      end,
    },
  },
  config = function()
    local builtin = require "telescope.builtin"

    -- Custom logo (Astronaut themed to match your wallpaper)
    local logo = [[
            ████ ██████            █████      ██                    
          ███████████               █████                             
          █████████ ███████████████████ ███   ███████████   
         █████████  ███     █████████████ █████ ██████████████   
         █████████ ██████████ █████████ █████ █████ ████ █████   
       ███████████ ███    ███ █████████ █████ █████ ████ █████  
      ██████  █████████████████████ ████ █████ █████ ████ ██████ 
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    require("dashboard").setup {
      theme = "hyper",
      config = {
        header = vim.split(logo, "\n"),
        shortcut = {
          {
            icon = " ",
            desc = "Files",
            group = "Label",
            action = function()
              builtin.find_files()
            end,
            key = "f",
          },
          {
            icon = " ",
            desc = "Database",
            group = "Number",
            action = "enew | SQLua",
            key = "d",
          },
          {
            icon = " ",
            desc = "Recent",
            group = "DiagnosticHint",
            action = function()
              builtin.oldfiles()
            end,
            key = "r",
          },
          {
            icon = " ",
            desc = "Config",
            group = "Number",
            action = function()
              builtin.find_files { cwd = vim.fn.stdpath "config" }
            end,
            key = "c",
          },
          {
            icon = "󰒲 ",
            desc = "Lazy",
            group = "Label",
            action = "Lazy",
            key = "l",
          },
          {
            icon = " ",
            desc = "Quit",
            group = "Number",
            action = "qa",
            key = "q",
          },
        },
      },
    }

    -- This autocmd ensures NvimTree refreshes its root after the dashboard opens a file
    vim.api.nvim_create_autocmd("BufReadPost", {
      callback = function()
        if package.loaded["nvim-tree"] then
          require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
        end
      end,
    })
  end,
}
