" --------- WELCOME TO MY .VIMRC ! --------- "
" Colourscheme {{{
syntax enable
set background=dark
set t_Co=256 " terminal with 256 colours

" }}}
" Vundle Plugins {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive' " Git plugin
Plugin 'ctrlpvim/ctrlp.vim' " File navitagion
Plugin 'tacahiroy/ctrlp-funky' " Check if you want this
Plugin 'tpope/vim-obsession' " Vim session manager
Plugin 'gioele/vim-autoswap' " Dealing with swap files
Plugin 'scrooloose/nerdtree' " Tree directory navigation extension.
Plugin 'tpope/vim-dispatch' " Running processes in the background 
Plugin 'mhinz/vim-startify' " nice startup menu
" Plugin 'Valloric/YouCompleteMe' " Syntax completion
" Plugin 'vim-latex/vim-latex' " CHECK HOW TO USE THIS

" Plugin 'jpalardy/vim-slime' Consider using this for python

Plugin 'scrooloose/syntastic' " Syntax check for most languages.

call vundle#end()            " required
filetype plugin indent on    " required

" Vundle Commands
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" }}}
" Miscelaneous {{{
let mapleader = " "
set clipboard=unnamedplus

nnoremap <leader>ev :tabe ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

" Multi-and single-line comments in Python
nnoremap # I# <Esc>
vnoremap # :s/^/# <CR>:noh<CR>


" Use Ctrl+s to save file quickly TODO
" nnoremap <C-S> :w<CR>
" vnoremap <C-S> <Esc>:w<CR>
" inoremap <C-S> <Esc>:w<CR>

" }}}
" UI layout {{{

syntax enable
set number  " Shows line numbers
set showcmd " Shows commands as they are being typed
set showmatch " Highlight matching parenthesis
set wildmenu " Shows file manu for commands like :e <Tab>
set autoindent " Well... it autoindents

set ruler " Display position of cursor

set foldmethod=marker " check :help foldmethod
set foldlevel=0 " Folds closed by default

" }}}
" Search {{{
set incsearch " When searching, go directly to matches
set hlsearch  " Highlight matches
nnoremap <leader>h :nohlsearch<cr>
set ignorecase
set smartcase
highlight Search ctermbg=55 cterm=bold

" }}}
" Space & Tabs {{{
set expandtab " Expand tabs fr spaces
set tabstop=4
set shiftwidth=4
set nowrap
" }}}
" Movement {{{
" Tab movement
nnoremap H :tabprevious<cr> 
nnoremap L :tabnext<cr>

" Scroll keeping the cursor in the same position in the screen
nnoremap <C-k> <C-y>k
nnoremap <C-j> <C-e>j

" Useful insert mode commmands
"   Go back a word
inoremap <C-H> <Esc>bi 
"   Go up a word
inoremap <C-L> <Esc>wwi

" Shortcuts to move lines up and down
nnoremap <A-j> :move +1<CR>==
nnoremap <A-k> :move -2<CR>==
inoremap <A-j> <Esc>:move +1<CR>==gi
inoremap <A-k> <Esc>:move -2<CR>==gi
vnoremap <A-j> :move '>+1<CR>gv=gv
vnoremap <A-k> :move '<-2<CR>gv=gv
" }}}
" Default Highlights {{{
" Bold text selected in visual mode
highlight Visual cterm=bold
" Light grey background colour
highlight Visual ctermbg=8
" }}}
" PLUGIN: Autoswap {{{
let g:autoswap_detect_tmux = 1
" }}}
" PLUGIN: vim-fugitive {{{


" Most copied from
" https://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/
set diffopt+=vertical
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
" nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gl :bot copen<CR>:set modifiable<CR>:read !git lgnocolor<CR>ggdd:noh<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>
noremap <leader>o do:diffupdate<CR>
noremap <leader>p dp:diffupdate<CR>

highlight DIffChange cterm=bold ctermbg=89
highlight DIffAdd    cterm=bold ctermbg=28
highlight DIffDelete cterm=bold ctermbg=9 
highlight DiffText   cterm=bold ctermbg=93

" }}}
" PLUGIN: CtrlP {{{

" Ignore certain files with CtrlP
" CHANGE FOR WHAT YOU ARE WORKING ON
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|o|class)$',
  \ }

" }}}
" PLUGIN: NERDTree {{{
" If NERDTree is the only buffer left open, close it
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Opens/Closes NERDTree in a tab
nnoremap <leader>t :NERDTreeToggle<cr>

" }}}
" PLUGIN: Syntastic {{{

let g:syntastic_check_on_open = 1 " Check syntax on open

let g:syntastic_python_checkers=["flake8"]
" Ignore the following errors: 'white space before operator'(E221), 
" 'Line too long'(E501)
" 'Missing whitespace around operator'(E226)
let g:syntastic_python_flake8_args="--ignore=E221,E226,E501"
let g:syntastic_tex_checkers = ['chktex']


" Go to next/previous error
nnoremap <leader>e :call LocationNext()<cr> 
nnoremap <leader>E :call LocationPrevious()<cr>

" Wrap both ways when searching for next and previous errors
function! LocationNext()
    try
        lnext
    catch /^Vim\%((\a\+)\)\=:E553/
        lfirst
    endtry
endfunction

function! LocationPrevious()
    try
        lprev
    catch /^Vim\%((\a\+)\)\=:E553/
        llast
    endtry
endfunction

" Toggle error location list
nnoremap <leader>te :call ToggleErrors()<cr>

function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

let g:syntastic_always_populate_loc_list = 1 " Open error list if there are any
" }}}
" PLUGIN: vim-obsession {{{

set laststatus=2 " Always show statusline
set statusline+=%{ObsessionStatus()} " Show vim session on statusline

" }}}
