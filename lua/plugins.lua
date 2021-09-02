require 'paq-nvim' {
  'navarasu/onedark.vim' ; 
  'savq/paq-nvim';                  

  'tpope/vim-dispatch';
  {'rcarriga/vim-ultest', run=UpdateRemotePlugins};
  'vim-test/vim-test';
  'neovim/nvim-lspconfig';         
  'nvim-lua/lsp_extensions.nvim';
	{'nvim-treesitter/nvim-treesitter', run=TSUpdate};

  'hrsh7th/nvim-compe';
--	'neoclide/coc.nvim';
	{'junegunn/fzf', run=vim.fn["fzf#install()"]};
	
	'tpope/vim-fugitive';
	'rhysd/vim-clang-format';

  {'lervag/vimtex', opt=true};    
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  'itchyny/lightline.vim';
	'puremourning/vimspector';
	'szw/vim-maximizer'
}

 -- 'hrsh7th/nvim-compe';
