-- space bar leader key
vim.g.mapleader = " "
-- buffer nav
vim.keymap.set("n", "<tab>", ":bn<cr>")
vim.keymap.set("n", "<s-tab>", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")
vim.keymap.set("n", "<leader>f",":%s/<C-r><C-w>/")
vim.keymap.set("n", "<leader>r", ":let @/='' <enter>")
vim.keymap.set("n", "<leader>s", ":/<C-r><C-w><enter>")
-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
