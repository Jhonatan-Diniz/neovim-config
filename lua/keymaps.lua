-- space bar leader key
vim.g.mapleader = " "
-- buffer nav
vim.keymap.set("n", "<tab>", ":bn<cr>")
vim.keymap.set("n", "<s-tab>", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")
vim.keymap.set("n", "<leader>f",":%s/<C-r><C-w>/")
vim.keymap.set("n", "<leader>r", ":let @/='' <enter>")
