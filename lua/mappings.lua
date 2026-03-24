require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Code Action
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP code action" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
    float_opts = {
      row = 0.35,
      col = 0.35,
      width = 0.5,
      height = 0.5,
    },
  }
end, { desc = "terminal toggle floating term" })

-- Transprent Background
map(
  "n",
  "<leader>tt",
  ":lua require('base46').toggle_transparency()<CR>",
  { noremap = true, silent = true, desc = "Toggle Background Transparency" }
)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Flutter
map("n", "<leader>rr", "<cmd>FlutterRun<cr>", { desc = "Flutter Run" })
map("n", "<leader>rd", "<cmd>FlutterDebug<cr>", { desc = "Flutter Debug" })
map("n", "<leader>re", "<cmd>FlutterEmulators<cr>", { desc = "Flutter Emulators" })
map("n", "<leader>rv", "<cmd>FlutterDevices<cr>", { desc = "Flutter Devices" })
map("n", "<leader>rl", "<cmd>FlutterReload<cr>", { desc = "Hot Reload" })
map("n", "<leader>rR", "<cmd>FlutterRestart<cr>", { desc = "Hot Restart" })
map("n", "<leader>rq", "<cmd>FlutterQuit<cr>", { desc = "Quit Flutter" })
map("n", "<leader>ro", "<cmd>FlutterOutlineToggle<cr>", { desc = "Flutter Outline" })
map("n", "<leader>rL", "<cmd>FlutterLogToggle<cr>", { desc = "Flutter Log" })
map("n", "<leader>rc", "<cmd>FlutterLogClear<cr>", { desc = "Clear Flutter Log" })
map("n", "<leader>ra", "<cmd>FlutterAttach<cr>", { desc = "Attach to App" })
map("n", "<leader>rt", "<cmd>FlutterDevTools<cr>", { desc = "Flutter DevTools" })

-- Lazy
map("n", "<leader>l", ":Lazy<cr>", { desc = "Lazy" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Lazygit
map("n", "<leader>gg", function()
  -- Create a buffer for the terminal
  local buf = vim.api.nvim_create_buf(false, true)

  -- Calculate window size (80% of screen)
  local width = math.ceil(vim.o.columns * 0.8)
  local height = math.ceil(vim.o.lines * 0.8)

  -- Open a floating window
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.ceil((vim.o.columns - width) / 2),
    row = math.ceil((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
  })

  -- Start LazyGit in that buffer
  vim.fn.termopen "lazygit"

  -- Automatically enter insert mode
  vim.cmd "startinsert"
end, { desc = "Git Open LazyGit (Native)" })
