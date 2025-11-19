-- vim.cmd.colorscheme 'base16-black-metal-gorgoroth'
-- vim.cmd.colorscheme 'base16-black-metal-bathory'
vim.cmd.colorscheme 'lackluster-hack'
vim.opt.termguicolors = true --bufferline

require("bufferline").setup{} --bufferline

vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })

