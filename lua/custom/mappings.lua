local M = {}

-- TODO: Will fix the acception suggestion
M.copilot = {
  i = {
    ["<C-l>"] = {
      function()
        require("blink.cmp").accept()
      end,
      "Blink Accept (includes Copilot)",
    },
  },
}

return M
