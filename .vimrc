" --------- WELCOME TO MY .VIMRC ! --------- "
" Runtimepath configuration {{{
set runtimepath+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
set runtimepath+=~/.fzf/bin/fzf " same for fzf
set runtimepath+=/usr/local/lib/python3.6/dist-packages/powerline/bindings/vim/ " Allowing powerline in vim
" }}}
" Vundle Plugins {{{
set nocompatible  " Remove backwards compatibility with vi.
 
call vundle#begin()
 
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Aesthetic plugins
Plugin 'vim-airline/vim-airline'        " Status bar
Plugin 'vim-airline/vim-airline-themes' " Status bar themes
" Plugin 'chriskempson/base16-vim'        " WAITING FOR FIX ON MASTER Base16 colourschemes
Plugin 'junegunn/goyo.vim'              " Distraction free vim!
Plugin 'mhinz/vim-startify'             " Fancy start screen
 
"Syntax / semantic plugins
Plugin 'kien/rainbow_parentheses.vim'   " Make parenthesis match colour
Plugin 'Valloric/YouCompleteMe'         " Syntax completion
Plugin 'scrooloose/syntastic'           " Syntax check for most languages.
Plugin 'godlygeek/tabular'              " Formats (tabularizes) according to patterns. Needed for vim-markdown (MUST come before vim-markdown)

" Miscelaneous
Plugin 'vim-scripts/ZoomWin'            " Toggles fullscreening of current buffer in a window, Mapping: <c-w>o 
Plugin 'vim-scripts/IndexedSearch'      " Shows number of matches for search commands
Plugin 'tpope/vim-fugitive'             " Git plugin
Plugin 'rbong/vim-flog'                 " Git log inside vim
Plugin 'airblade/vim-gitgutter'         " Shows what lines have been changed / added / deleted in git
Plugin 'tpope/vim-obsession'            " Vim session manager
Plugin 'junegunn/fzf'                   " fuzzy search finder 
Plugin 'junegunn/fzf.vim'               " To use fzf in vim
Plugin 'majutsushi/tagbar'              " Tagbar to see methods / variables
Plugin 'scrooloose/nerdtree'            " Tree directory navigation extension.
Plugin 'tpope/vim-dispatch'             " To run asynchronous tasks in vim
Plugin 'vim-scripts/SearchComplete'     " Tab completition inside search '/'
Plugin 'dbeniamine/cheat.sh-vim'        " Uses the wonderful cheat.sh web thingy.
Plugin 'mbbill/undotree'                " Undo tree visualizer
Plugin 'terryma/vim-multiple-cursors'   " Sublime text like multiple cursor feature 
Plugin 'roxma/vim-window-resize-easy'   " Allows to resize windows without typing <c-w> everytime


" Language specific 
" Plugin 'OmniSharp/omnisharp-vim'
Plugin 'vim-latex/vim-latex'            " For writing latex in vim
call vundle#end()            " required
 
" Vundle Commands
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" }}}
" Miscelaneous {{{
filetype on        " Allows for detection of Filetypes via file name, and sometimes by reading text inside file
filetype indent on " Filetype is detected and its corresponding indentation file is loaded
filetype plugin on " Filetype is detected and plugins that act on this filetype are loaded

" Use <Space> as leader key
let mapleader = " "

" Yank operations will put their output inside register '+'. 
" But not other oprations like delete or change. Those will use register '*'
set clipboard=unnamedplus 

" Allows backspace to delete anything. Otherwise it would not be possible to delete already written text
set backspace=indent,eol,start 
 
" Open vimrc in a new tab
nnoremap <leader>ev :tabe ~/.vimrc<CR>
" (Reload) Source vimrc from anywhere (doesn't work properly)
nnoremap <leader>r :source ~/.vimrc<CR>
 
" Use Ctrl+s to save file. 
" NOTE: in a terminal ctr-s stops input intake and ctr-q continues it. add 'stty -ixon' to allow for this input sequences.
nnoremap <C-S> :w<CR>
vnoremap <C-S> <Esc>:w<CR>
inoremap <C-S> <Esc>:w<CR>i

" Remove trailing whitespaces
nnoremap <leader>rw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>


" Search for visually selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
" }}}
" UI layout {{{
syntax enable

set laststatus=2  " Makes statusline always visible (bottom line showing file, mode.. etc)
set number        " Shows line numbers
set showcmd       " Shows commands as they are being typed. In visual mode, shows the size of the selected area. In block visual mode, shows the dimensions of the selected block (linesXcolumns)
set wildmenu      " Shows file suggestion menu for commands like :e <Tab>
set wildmode=list:longest " Show matches bash style

set ruler " Display position of cursor. (line, column,    % of file)

set foldmethod=marker " check :help foldmethod string "{{{,}}}" will be used for folds
set foldlevel=0 " Folds closed by default
" }}}
" Search {{{
set incsearch " When searching, go directly to matches
set hlsearch  " Highlight matches

" Removes highlight from matched searched terms
nnoremap <leader>h :nohlsearch<cr>
set smartcase " When searching, ignore case unless a Upper case is specified by user, then become case sensitive.
" }}}
" Space & Tabs {{{
set expandtab " In Insert mode: Use the appropriate number of spaces to insert a <Tab>
set tabstop=4 " Number of spaces that a <Tab> counts for
set shiftwidth=4 " Number of spaces to use for each step of indention with commands like '>>' or '<<'.
set nowrap " Don't wrap lines if line length exceeds display length

" Toggles wrap
nnoremap <leader>tw :set wrap!<cr>
" " }}}
" Movement {{{
" Tab movement
nnoremap H :tabprevious<cr> 
nnoremap L :tabnext<cr>
 
" Scroll keeping the cursor in the same position in the screen
nnoremap <C-k> <C-y>k
nnoremap <c-j> j<c-e>
" }}}
" Spelling {{{
map <leader>ss :setlocal spell!<cr>

" Shortcuts:
" Go to next/previous highlighted word (n, p)
map <leader>sn ]s
map <leader>sp [s
" Add to dictionary
map <leader>sa zg
" Show Suggestions
map <leader>sc z=
" }}}
" PLUGIN: vim-fugitive {{{
 
" Most copied from
" https://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/
" set diffopt+=vertical
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
" nnoremap <leader>gt :Gcommit -v -q %:p<CR>

nnoremap <leader>gd :Gdiff<CR>

" nnoremap <leader>ge :Gedit<CR>
" nnoremap <leader>gr :Gread<CR>
" nnoremap <leader>gw :Gwrite<CR><CR>
" " nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
" nnoremap <leader>gl :bot copen<CR>:set modifiable<CR>:read !git lgnocolor<CR>ggdd:noh<CR>
" nnoremap <leader>gp :Ggrep<Space>
" nnoremap <leader>gm :Gmove<Space>
" nnoremap <leader>gb :Git branch<Space>
" nnoremap <leader>go :Git checkout<Space>
" nnoremap <leader>gps :Dispatch! git push<CR>
" nnoremap <leader>gpl :Dispatch! git pull<CR>
" noremap <leader>o do:diffupdate<CR>
" noremap <leader>p dp:diffupdate<CR>

" " }}}
" PLUGIN: Base16-vim {{{
set t_Co=256 " terminal with 256 colours

" let base16colorspace=256
" if filereadable(expand("~/.vimrc_background"))
"     let base16colorspace=256
"     source ~/.vimrc_background
" endif

" }}}
" PLUGIN: NERDTree {{{
" Opens/Closes NERDTree
nnoremap <leader>t :NERDTreeToggle<cr>
" Finds file in tree
nnoremap <leader>ff :let current_file=expand('%:p')<cr>:NERDTreeFind<cr>:echo current_file<cr>

" If NERDTree is the only buffer left open, close it
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
 
" Remove the "?" text and bookmark text from UI
let NERDTreeMinimalUI = 1

" Ignore files
let NERDTreeIgnore = ['\.meta$','\.pyc$','\.sln$']
" }}}
" PLUGIN: Syntastic {{{
"
highlight link SyntasticError Error
 
" let g:syntastic_check_on_open = 1 " Check syntax on open
" let g:syntastic_always_populate_loc_list = 1 " Errors will be populated in location list immediately after being found

" The error window will automatically open when errors are detected, and automatically close when none are detected
" let g:syntastic_auto_loc_list = 1 
 
" PYTHON
let g:syntastic_python_checkers=["flake8"]
" Ignore the following errors: 'white space before operator'(E221), 
" 'Line too long'(E501)
" 'Missing whitespace around operator'(E226){{{}}}
" 'At least two spaces between inline comments'(E261)
" 'Multiple statements in one line'(E701)
" 'Module import not at the top of file'(E402)
" 'Do not assign lambda to a variable, use def instead' (E731)
" 'Comparison against False literal with stupid syntax'(E712)
" 'Multiple spaces after ':' '(E241)
let g:syntastic_python_flake8_args="--ignore=E221,E226,E501,E261,E701,E402,E731,E712,E241"
let g:syntastic_python_python_exec = 'python3'
 
" LATEX
let g:syntastic_tex_checkers = ['chktex']

" JAVA
" Disable syntastic for java by fooling syntastic to thinking that javac has
" been loaded
" let g:loaded_syntastic_java_javac_checker = 1

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
nnoremap <leader>se :call ShowErrors()<cr>

function! ShowErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

" }}}
" PLUGIN: YouCompleteMe {{{
" NOTE: Vim needs to be compiled with the python flag. This is the case if `:echo has('python')' returns '1'
" This plugin has an installation component. You will need to run 'python ~/.vim/bundle/YouCompleteMe/install.py --all'
 
set runtimepath +=~/.vim/bundle/YouCompleteMe

" number of characters the user needs to type 
" before identifier-based completion suggestions are triggered.
let g:ycm_min_num_of_chars_for_completion = 0
 
" Show documentation in the bottom of screen
set splitbelow

nnoremap <leader>sd :YcmCompleter GetDoc<cr>
nnoremap <leader>sr :YcmCompleter GoToReferences<cr>
nnoremap <leader>st :YcmCompleter GetType<cr>
 
" }}}
" PLUGIN: fzf-vim {{{

nnoremap <c-L> :BLines<CR>
nnoremap <c-P> :Files<CR>
nnoremap <c-F> :Ag<CR>
nnoremap <c-B> :Buffers<CR>
nnoremap <c-H> :Help<CR>

" }}}
" PLUGIN: Rainbow-Parentheses {{{
" VimEnter is an event that happens immediately after all Vim initialization has been completed
" Syntax is an event that happens after the filetype of a file has been inferred
" Effectively keeps RainbowParentheses always on
autocmd VimEnter * RainbowParenthesesToggle " Calls RainbowParenthesesToggle after entering vim. Activating RainbowParentheses
autocmd Syntax * RainbowParenthesesLoadRound  
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces
" }}}
" PLUGIN: vim-airline {{{
set encoding=utf-8 " Needed by vim-airline to work with powerfonts
let g:airline_theme='simple'

" Enables vim-airline for tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts= 1
" }}}
" PLUGIN: vim-latex {{{
let g:tex_flavor='latex' " To tell vim-latex that we are dealing with LaTeX files
set conceallevel=1
let g:tex_conceal='mgs' " Check :help g:tex_conceal

" TIP: if you write your \label's as \label{fig:something}, then if you
" " type in \ref{fig: and press you will automatically cycle through
" " all the figure labels. Very useful!
set iskeyword+=:

" '\\ref\{'
" '\v(\\ref\{(\w+))@<=}' 

" In order to compile latex file using ./compile script
nnoremap <leader><c-c> :silent !./compile.sh<CR>

" }}}
" PLUGIN: Goyo {{{
" Open Goyo (focus) on the current buffer
nnoremap <leader>gg :Goyo<CR>
" Uses Goyo callback function to auto-reset the bold highlight for visual terms
autocmd! User GoyoLeave nested call <SID>goyo_leave()

function! s:goyo_leave()
    highlight Visual cterm=bold
endfunction

" }}}
" PLUGIN: Tagbar {{{
nnoremap <leader>tb :TagbarToggle<cr>
" }}}
" Default Highlights {{{
" Default highlights MUST be at the end of the vimrc because some plugins
" override higlight settings
" Bold text selected in visual mode
highlight Visual cterm=bold
" Set the font of the matching searched terms to *bold*
highlight Search cterm=bold
highlight IncSearch cterm=bold

" Transparent background!
" TODO: change after base16 issue in master has been fixed
" The background will still be transparent
set background=dark
hi Normal guibg=NONE ctermbg=NONE
" }}}
