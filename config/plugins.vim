" --------------- Plugins ---------------

call plug#begin(stdpath('data') . '/plugged')

" ---------- Color Themes

Plug 'dracula/vim'
Plug 'sainnhe/edge'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/sonokai'
Plug 'rose-pine/neovim'
Plug 'elvessousa/sobrio'
Plug 'cocopon/iceberg.vim'
Plug 'wadackel/vim-dogrun'
Plug 'shaunsingh/nord.nvim'
Plug 'mhartington/oceanic-next'
Plug 'FrenzyExists/aquarium-vim'
Plug 'drewtempelmeyer/palenight.vim'

" ---------- Color Highlight

Plug 'norcalli/nvim-colorizer.lua'

" ---------- Shades

Plug 'sunjon/shade.nvim'
Plug 'folke/twilight.nvim'

" ---------- Status Bar

Plug 'shadmansaleh/lualine.nvim'

" ---------- Icons

Plug 'kyazdani42/nvim-web-devicons'
Plug 'yamatsum/nvim-nonicons'

" ---------- Language Server Protocol

Plug 'neovim/nvim-lspconfig'

" ---------- Autocompletation

Plug 'ms-jpq/coq_nvim',       {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts',  {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

" ---------- Treesitter

"Plug 'nvim-treesitter/nvim-treesitter'

" ---------- Fuzzy Finder

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}

Plug 'junegunn/fzf', {'do': {-> fzf#install()}}

" ---------- Other

Plug 'nvim-lua/plenary.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()
