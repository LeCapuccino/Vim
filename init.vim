" --------------- General Configuration Files ---------------

source ~\appdata\local\nvim\config\plugins.vim
source ~\appdata\local\nvim\config\setup.vim
source ~\appdata\local\nvim\config\mapping.vim
source ~\appdata\local\nvim\config\themes.vim
source ~\appdata\local\nvim\config\startify.vim

" --------------- Plugins Configuration Files ---------------

source ~\appdata\local\nvim\plugins\shade.vim
source ~\appdata\local\nvim\plugins\lualine.vim
source ~\appdata\local\nvim\plugins\telescope.vim
source ~\appdata\local\nvim\plugins\lsp.vim

" --------------- Require Plugins ---------------

source ~\appdata\local\nvim\plugins\requires.vim

" --------------- Initialization --------------

:call UpdateThemeVariation()
:call UpdateTheme()
