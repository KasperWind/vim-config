return function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'RRethy/vim-illuminate'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions

  use "windwp/nvim-autopairs"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  -- use 'p00f/nvim-ts-rainbow'
  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use 'nvim-treesitter/nvim-treesitter-context'

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  -- use 'akinsho/bufferline.nvim'
  use { 'willothy/nvim-cokeline', requires = { 'nvim-lua/plenary.nvim', "kyazdani42/nvim-web-devicons" }, config = true }
  use 'moll/vim-bbye'
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  -- use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use 'nvim-telescope/telescope-media-files.nvim'

  -- Colorscheme
  -- use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  -- use 'sainnhe/gruvbox-material'
  use {'catppuccin/nvim', as = 'catppuccin'}

  -- tmux
  use 'alexghergh/nvim-tmux-navigation'
  -- use 'christoomey/vim-tmux-navigation'

  -- Rust
  use 'simrat39/rust-tools.nvim'

  use 'theprimeagen/harpoon'

  -- Telescope dependencies
  use {'BurntSushi/ripgrep'}
  use {'sharkdp/fd'}

  -- Folder/File browser
  use 'nvim-tree/nvim-tree.lua'
  use {'nvim-tree/nvim-web-devicons'}

  -- Undo tree
  use 'mbbill/undotree'

  -- comment/uncomment
  use 'terrortylor/nvim-comment'

  -- dap
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'
  --
  -- go dap
  use 'leoluz/nvim-dap-go'

  -- zig lsp
  -- use 'ziglang/zig'

  -- use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}

  -- text edit tools
  use 'johmsalas/text-case.nvim'
  -- use {'fei6409/log-highlight.nvim'}

end
