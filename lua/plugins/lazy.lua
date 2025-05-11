local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
     vim.api._echo({
       { "Failed to clone lazy.:\n", "ErrorMsg" },
       { out, "WarningMsg" },
       { "\nPress any key to exit..." },
     }, true, {})
     vim.fn.getchar()
     os.exit(1)
   end
end

vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  { "savq/melange-nvim" },
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { 'https://github.com/clangd/coc-clangd.git' },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      theme = {
          variant = "default"
      }
    }
  },
  {
      "startup-nvim/startup.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
      config = function()
        require "startup".setup({theme="custom_theme"})
      end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        vim.keymap.set("n", "<space><space>", require("telescope.builtin").find_files)
        vim.keymap.set("n", "<space>wf", require("telescope.builtin").grep_string)
        vim.keymap.set("n", "<space>ww", require("telescope.builtin").live_grep)
    end
  },
  {
    "slugbyte/lackluster.nvim",
    opts = {
        transparent = true,
        styles = {
        sidebars = "transparent",
        float = "transparent",
      },
    },
    lazy = false,
    priority = 1000,
    --vim.cmd.colorscheme("lackluster")
    -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
    -- vim.cmd.colorscheme("lackluster-mint")
  },
  {
    "ficcdaf/ashen.nvim",
    lazy = false,
    priority = 1000,
    -- configuration is optional!
    opts = {
      -- your settings here
    },
  },

  -- Transparent Background
  { "xiyaowong/transparent.nvim" },

  -- TreeSitter 

  { "nvim-treesitter/nvim-treesitter", version = false,
     dependencies =  { "HiPhish/rainbow-delimiters.nvim" },
     build = function()
       require("nvim-treesitter.install").update({ with_sync = true })
     end,
     config = function()
       require("nvim-treesitter.configs").setup({
         ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "javascript", "cmake", "python" },
         auto_install = true,
         highlight = { enable = true, additional_vim_regex_highlighting = false },
         incremental_selection = {
           enable = true,
           keymaps = {
             init_selection = "<C-n>",
             node_incremental = "<C-n>",
             scope_incremental = "<C-s>",
             node_decremental = "<C-m>",
           }
         }
       })
     end
   },
    -- File tree
   {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    requires = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
        require("nvim-tree").setup {
            view = {
               side = "right",
               width = 40,
           },
        }
      end,
   },

   -- Visualize buffers as tabs
   {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

   -- Lenguage server for python and javascript
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  -- Mason
  {
    'williamboman/mason.nvim',
    lazy = true,
    config = true,
  },

  -- Autocompletion
  {
     'hrsh7th/nvim-cmp',
     dependencies = {
       {'hrsh7th/cmp-nvim-lsp'},
       {'L3MON4D3/LuaSnip'},
       {'saadparwaiz1/cmp_luasnip'},
       {'rafamadriz/friendly-snippets'},
       {'hrsh7th/vim-vsnip'},
       {'hrsh7th/vim-vsnip-integ'},
       {'kitagry/vs-snippets'},
       {'cstrap/python-snippets'}
     },
     event = 'InsertEnter',
     config = function()
       -- Here is where you configure the autocompletion settings.
       -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')

      require("luasnip.loaders.from_vscode").lazy_load()
       cmp.setup({
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-o>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),

          snippet = {
              expand = function(args)
                  require("luasnip").lsp_expand(args.body)
              end,
          },

          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
          }, {
            { name = 'buffer' },
          })
        })
     end
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'OrangeT/vim-csharp'
    },
  },
  {
    'hrsh7th/cmp-nvim-lsp',
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
    local cmp = require'cmp'
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = '_lsp' },
          --{ name = 'vsnip' }, -- For vsnip users.
          { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        })
      })
    end,
  },

  -- Autocompletion

  -- html autotag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      local autotag = require("nvim-ts-autotag")
      autotag.setup({
        per_filetype = {
          ['html'] = {
            enable_close = false
          }
        }
      })

    end
  },
  -- Close pairs like () or {} etc...
  { "windwp/nvim-autopairs", config = true },

  {"OmniSharp/omnisharp-vim"},

  {
    'mfussenegger/nvim-jdtls',
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')

      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      require('mason-lspconfig').setup({
            ensure_installed = {
                "pyright",
                "jdtls"
            },
            handlers = {
            -- this first function is the "default handler"
            -- it applies to every language server without a "custom handler"
            function(server_name)
                require('lspconfig')[server_name].setup({})
            end,
            -- this is the "custom handler" for `lua_ls`
            lua_ls = function()
                -- (Optional) Configure lua language server for neovim
                local lua_opts = lsp_zero.nvim_lua_ls()
                require('lspconfig').lua_ls.setup(lua_opts)
            end,
            }
        })
    end
    },
})
