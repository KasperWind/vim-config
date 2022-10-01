require "paq" {
  'savq/paq-nvim';                  

  'joshdick/onedark.vim';
  'ellisonleao/gruvbox.nvim';
  'tpope/vim-dispatch';
--  {'rcarriga/vim-ultest', run=UpdateRemotePlugins};
  'vim-test/vim-test';
  'neovim/nvim-lspconfig';         
  'nvim-lua/lsp_extensions.nvim';
	{'nvim-treesitter/nvim-treesitter', run=TSUpdate};

  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-cmdline';
  'hrsh7th/nvim-cmp';

  'hrsh7th/cmp-vsnip';
  'hrsh7th/vim-vsnip';
  'hrsh7th/vim-vsnip-integ';

--	'neoclide/coc.nvim';
	{'junegunn/fzf', run=vim.fn["fzf#install()"]};

	'tpope/vim-fugitive';
	'rhysd/vim-clang-format';

  {'lervag/vimtex', opt=true};    
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  'nvim-treesitter/nvim-treesitter';
  'antoinemadec/FixCursorHold.nvim';
  'nvim-neotest/neotest';
  'itchyny/lightline.vim';
	'puremourning/vimspector';
	'szw/vim-maximizer';
  'skywind3000/asyncrun.vim';
}

 -- 'hrsh7th/nvim-compe';
