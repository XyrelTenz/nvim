-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "kanagawa-dragon",
  transparent = true,
}

M.general = {
  n = {
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "Toggle transparency",
    },
  },
}
-- M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    enabled = false, -- Fixed from 'enableb' to 'enabled'
  },
}

return M
