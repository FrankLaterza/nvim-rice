return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required dependency
  },
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open Lazygit" }, -- Keybinding to open Lazygit
  },
}
