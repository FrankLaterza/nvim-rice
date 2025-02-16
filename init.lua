-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })
