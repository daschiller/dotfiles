" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'ConradIrwin/vim-bracketed-paste'
" Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf'
call plug#end()

" Get the defaults that most users want
" (includes restoring of cursor position)
source $VIMRUNTIME/defaults.vim

" vim-airline
let g:airline#extensions#tabline#enabled = 1
" nerdtree
map <C-n> :NERDTreeToggle<CR>
" jedi-vim
let g:jedi#use_splits_not_buffers = "top"
let g:jedi#popup_on_dot = 0
" ale
let g:ale_linters = {
\   'python': ['flake8'],
\}
" ignore line length errors (E501)
let g:ale_python_flake8_options = '--extend-ignore=E501'
let g:ale_fixers = {
\   'python': ['isort', 'black'],
\}

set nocompatible
set encoding=utf-8
if exists("$TMUX")
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors
set cursorline
set background=dark
colorscheme solarized8

" syntax highlighting
syntax on
filetype plugin indent on

" recommended settings
set showcmd     " Show (partial) command in status line
set showmatch   " Show matching brackets
set ignorecase  " Do case insensitive matching
set smartcase   " Do smart case matching
set incsearch   " Incremental search
set autowrite   " Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned
set mouse=a     " Enable mouse usage (all modes)

set relativenumber number
set splitbelow splitright
set shiftwidth=4
set tabstop=4
set expandtab
" show whitespace characters
set list
"set listchars=tab:→\ ,trail:␣,extends:…,eol:⏎
set listchars=tab:→\ ,trail:␣

" place swap, backup and undo files in special directories
if !isdirectory($HOME . '/.vim/swap')
    call mkdir($HOME . '/.vim/swap', 'p')
endif
if !isdirectory($HOME . '/.vim/backup')
    call mkdir($HOME . '/.vim/backup', 'p')
endif
if !isdirectory($HOME . '/.vim/undo')
    call mkdir($HOME . '/.vim/undo', 'p')
endif
set directory^=$HOME/.vim/swap//
set backupdir^=$HOME/.vim/backup//
set undodir^=$HOME/.vim/undo//

" shorten timeout
set ttimeoutlen=100
set updatetime=100
