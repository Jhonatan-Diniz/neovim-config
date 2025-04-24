vim.opt.nu = true

vim.opt.relativenumber = true
vim.opt.encoding = "utf-8"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.autoindent = true -- auto indentation
vim.opt.list = true -- show tab characters and trailing whitespace
-- 'n-v-c-i:block,r-cr-o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

vim.opt.termguicolors = true -- enable true color support

--vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--  pattern = {"*.py"},
--  callback = function()
--    vim.opt.textwidth = 79
--  end
--}) -- python formatting

-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--   pattern = {"*.js", "*.html", "*.css", "*.lua"},
--   callback = function()
--     vim.opt.tabstop = 2
--     vim.opt.softtabstop = 2
--     vim.opt.shiftwidth = 2
--   end
-- }) -- javascript formatting
