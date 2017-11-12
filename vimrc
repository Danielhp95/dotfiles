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
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this lin

let mapleader = " "

syntax on
set number

set wildmenu " Shows file manu for commands like :e <Tab>

set incsearch " When searching, go directly to matches
set hlsearch  " Highlight matches

set autoindent " Well... it autoindents

set ruler " Display position of cursor

set expandtab " Expand tabs fr spaces
set tabstop=4
set shiftwidth=4
set nowrap

set backspace=eol,start,indent " Go to next or previous line with movement commands

set clipboard=unnamedplus

" Tab movement
nnoremap H :tabprevious<cr> 
nnoremap L :tabnext<cr>

" Scroll keeping the cursor in the same position in the screen
nnoremap K <C-y>k
nnoremap J <C-e>j

" Useful insert mode commmands
"   Go back a word
inoremap <C-H> <Esc>bi 
"   Go up a word
inoremap <C-L> <Esc>wwi

" Multi-and single-line comments in Python
nnoremap # I# <Esc>
vnoremap # :s/^/# <CR>:noh<CR>

" Shortcuts to move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Use Ctrl+s to save file quickly TODO
" nnoremap <C-S> :w<CR>
" vnoremap <C-S> <Esc>:w<CR>
" inoremap <C-S> <Esc>:w<CR>

" Autoswap command
let g:autoswap_detect_tmux = 1


" PLUGIN SETTINGS " 

" Settings for fugitive git plugin
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


" Ignore certain files with CtrlP
" CHANGE FOR WHAT YOU ARE WORKING ON
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|o|class)$',
  \ }

"------------ NERDTree ------------- " 
" If NERDTree is the only buffer left open, close it
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Opens/Closes NERDTree in a tab
nnoremap <leader>t :NERDTreeToggle<cr>

"------------ Syntastic ------------- " 
" Go to next/previous error
nnoremap <leader>e :lnext<cr> 
nnoremap <leader>E :prev<cr>

nnoremap <leader>te :ToggleErrors<cr>

function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
