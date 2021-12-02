" --------------- Plugins ---------------

call plug#begin(stdpath('data') . '/plugged')

" ---------- Color Themes

Plug 'sainnhe/edge'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/sonokai'
Plug 'rose-pine/neovim'
Plug 'shaunsingh/nord.nvim'

" ---------- Color Highlight

Plug 'norcalli/nvim-colorizer.lua'

" ---------- Shades

Plug 'folke/twilight.nvim'

" ---------- Icons

Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

" ---------- File Tree

Plug 'kyazdani42/nvim-tree.lua'

" ---------- Symbols and Tags Visualizer

Plug 'liuchengxu/vista.vim'

" ---------- Language Server Protocol

Plug 'glepnir/lspsaga.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" ---------- Autocompletation

Plug 'ms-jpq/coq_nvim',       {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts',  {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

" ---------- Cursor

Plug 'mg979/vim-visual-multi'

" ---------- Treesitter

"Plug 'nvim-treesitter/nvim-treesitter'

" ---------- Fuzzy Finder

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}

" ---------- Auto Pairs

Plug 'windwp/nvim-autopairs'

" ---------- Other

Plug 'nvim-lua/plenary.nvim'

call plug#end()
