" vim-plug
" ========
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" export FANCY_TERM=1 in ~/.xprofile to enable
if exists("$FANCY_TERM") && ! exists("$TMUX")
    let FANCY = 1
else
    let FANCY = 0
endif

call plug#begin('~/.vim/plugged')
" tpope
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-dispatch'
" general plugins
    Plug 'ConradIrwin/vim-bracketed-paste'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf'
" coding
    " Plug 'davidhalter/jedi-vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'dense-analysis/ale'
" themes
    Plug 'lifepillar/vim-solarized8'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'arcticicestudio/nord-vim'
    Plug 'dracula/vim'
if FANCY
    Plug 'ryanoasis/vim-devicons'
endif
call plug#end()


" Get the defaults that most users want
" (includes restoring of cursor position)
source $VIMRUNTIME/defaults.vim


" jedi-vim
" ========
" let g:jedi#use_splits_not_buffers = "top"
" let g:jedi#popup_on_dot = 0


" vim-airline (install fonts-powerline)
" ===========
let g:airline#extensions#tabline#enabled = 1
if FANCY
    let g:airline_powerline_fonts = 1
endif


" fzf
" ===
if executable("bat")
    let $FZF_DEFAULT_OPTS="--preview='bat -p --color=always {}'"
else
    let $FZF_DEFAULT_OPTS="--preview='less {}'"
endif


" ale
" ===
" Debian package names:
" flake8 pydocstyle isort black
" clangd clang-format bear
"
" The C/C++ language server needs a compilation database,
" which can be created with bear from a plain Makefile.
"
" pylsp can be installed via pip (or pipx):
" pipx install --system-site-packages 'python-lsp-server[all]'
let g:ale_default_navigation = 'split'
let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
let g:ale_linters = {
\   'python': ['pylsp', 'flake8', 'pydocstyle'],
\   'c': ['clangd'],
\   'cpp': ['clangd'],
\}
if executable("pylsp")
    " pylsp has it's own linters
    let g:ale_linters_ignore = ['flake8', 'pydocstyle']
    let g:ale_python_pylsp_config = {
    \   'pylsp': {
    \     'plugins': {
    \       'pycodestyle': {
    \         'ignore': ["E501"]
    \       },
    \       'pydocstyle': {
    \         'enabled': v:true,
    \         'ignore': ["D1"]
    \       },
    \       'yapf': {
    \         'enabled': v:false
    \       },
    \     }
    \   }
    \}
else
    " ignore line length errors (E501)
    let g:ale_python_flake8_options = '--extend-ignore=E501'
    " ignore missing docstrings errors (D1*)
    let g:ale_python_pydocstyle_options = '--ignore=D1'
endif
let g:ale_fixers = {
\   'python': ['isort', 'black'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'sh': ['shfmt'],
\}
let g:ale_c_clangformat_options = '-style="{BasedOnStyle: llvm, IndentWidth: 4}"'
let g:ale_cpp_clangformat_options = '-style="{BasedOnStyle: llvm, IndentWidth: 4}"'
let g:ale_c_clangd_options = '--enable-config'
let g:ale_cpp_clangd_options = '--enable-config'
" let g:ale_c_clangd_options = '"--query-driver=~/platformio/**/*gcc*,/usr/bin/**/*gcc*"'
" let g:ale_cpp_clangd_options = '"--query-driver=~/platformio/**/*g++,/usr/bin/**/*g++"'
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_set_balloons = 1
" enable right click context menu
if has("gui_running")
    set mousemodel=popup_setpos
    let g:ale_popup_menu_enabled = 1
endif


" key bindings
" ============
imap <expr> <C-Space> pumvisible() ? "<C-n>" : "<Plug>(ale_complete)"
" used for Ctrl + Space in terminal
imap <C-@> <C-Space>
nmap <leader>d <Plug>(ale_go_to_definition)
nmap <leader>f <Plug>(ale_fix)
nmap <leader>t <Plug>(ale_go_to_type_definition)
nmap <leader>h <Plug>(ale_hover)
nmap <leader>z :FZF<CR>
nmap <C-n> :NERDTreeToggle<CR>


" theming
" =======
if exists("$TMUX")
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
" disable background color erase
" (fixes background rendering in kitty, probably other terminals too)
let &t_ut = ""
" disable detection of terminal version string
" (fixes redraw bug with kitty and devicons)
let &t_RV = ""
set termguicolors
set cursorline
set background=dark
" correctly load colorscheme on first install
autocmd vimenter * nested colorscheme solarized8


" recommended settings (from Debian)
" ====================
set showmatch   " Show matching brackets
set ignorecase  " Do case insensitive matching
set smartcase   " Do smart case matching
set autowrite   " Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned

" general settings
" ================
" shorten timeout
set mouse=a
set ttymouse=sgr
set balloonevalterm
set updatetime=100
" zsh-like command completion
set wildmode=longest,list,full
set relativenumber number
set splitbelow splitright
set shiftwidth=4
set tabstop=4
set expandtab
" show whitespace characters
set list
"set listchars=tab:→\ ,trail:␣,extends:…,eol:⏎
set listchars=tab:→\ ,trail:␣
autocmd FileType c,cpp setlocal commentstring=//\ %s
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

