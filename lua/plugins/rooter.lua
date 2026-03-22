return {
  "notjedi/nvim-rooter.lua",
  config = function()
    require("nvim-rooter").setup {
      rooter_patterns = { ".git", ".hg", ".svn", "build.gradle.kts", "settings.gradle.kts", "pubspec.yaml" },
    }
  end,
}
