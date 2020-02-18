" --------- WELCOME TO MY NEOVIM init.vim! --------- "
" Runtimepath configuration {{{
set runtimepath+=~/.fzf/bin/fzf " same for fzf
set runtimepath+=/usr/local/lib/python3.6/dist-packages/powerline/bindings/vim/ " Allowing powerline in vim
" }}}
" Vim-Plug PLUGINS {{{

" If vim-plug is not installed, install it and download / install all plugins
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

" function for installing vim-markdown-preview plugin
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

call plug#begin()

" Aesthetic plugins
Plug 'vim-airline/vim-airline'        " Status bar
Plug 'vim-airline/vim-airline-themes' " Status bar themes
Plug 'Soares/base16.nvim'
Plug 'junegunn/goyo.vim'              " Distraction free vim!
Plug 'junegunn/limelight.vim'         " Dim paragraphs above and below current paragraph
Plug 'mhinz/vim-startify'             " Fancy start screen
Plug 'kien/rainbow_parentheses.vim'   " Rainbow parenthesis!
Plug 'ryanoasis/vim-devicons'         " Adds nice looking devicons to plugins
 
"Syntax / semantic plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Miscelaneous
Plug 'janko/vim-test'                         " Utilities to run tests
Plug 'vim-scripts/IndexedSearch'              " Shows number of matches for search commands
Plug 'rbong/vim-flog'                         " Git log inside vim
Plug 'airblade/vim-gitgutter'                 " Shows what lines have been changed / added / deleted in git
Plug 'tpope/vim-fugitive'                     " Git integration with vim
Plug 'tpope/vim-obsession'                    " Vim session manager
Plug 'junegunn/fzf'                           " fuzzy search finder 
Plug 'junegunn/fzf.vim'                       " To use fzf in vim
Plug 'liuchengxu/vista.vim'                   " Tagbar to see methods / variables
Plug 'scrooloose/nerdtree'                    " Tree directory navigation extension.
Plug 'vim-scripts/SearchComplete'             " Tab completition inside search '/'
Plug 'dbeniamine/cheat.sh-vim'                " Uses the wonderful cheat.sh web thingy.
Plug 'mbbill/undotree'                        " Undo tree visualizer
Plug 'terryma/vim-multiple-cursors'           " Sublime text like multiple cursor feature 
Plug 'roxma/vim-window-resize-easy'           " Allows to resize windows without typing <c-w> everytime
Plug 'jpalardy/vim-slime'  " To send code to Python interpreter or other REPL tool (Read Evaluate Print Loop)
Plug 'liuchengxu/vim-clap'  " Floating windows whilst searching for stuff


" Language specific 
" Plug 'OmniSharp/omnisharp-vim'
Plug 'vim-latex/vim-latex', {'for' : 'tex'} " For writing latex in vim
Plug 'fatih/vim-go', {'for' : 'go'}         " Go plugin!
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') } " Markdown live previwer
call plug#end()
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
nnoremap <leader>ev :tabe ~/.config/nvim/init.vim<CR>
nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>
 
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
set wildmode=full " Show matches bash style

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
" Language Specific: Python {{{
" Set debugger trace

autocmd FileType python map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>

" }}}
" Language Specific: Go {{{
" Set debugger trace

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
"autocmd FileType go nmap <leader>s  <Plug>(go-test) FIGURE OUT MAPPING

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

" }}}
" PLUGIN: Base16-vim {{{
"let g:base16_transparent_background = 1

" let base16colorspace=256
" if filereadable(expand("~/.vimrc_background"))
"     let base16colorspace=256
"     source ~/.vimrc_background
" endif

" }}}
" PLUGIN: NERDTree {{{
nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>ff :NERDTreeFind<cr>
let NERDTreeIgnore = ['\.meta$','\.pyc$','\.sln$']

" If NERDTree is the only buffer left open, close it
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Remove the "?" text and bookmark text from UI
let NERDTreeMinimalUI = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_nerdtree = 1
" }}}
"" PLUGIN: Syntastic {{{
""
"highlight link SyntasticError Error
" 
"" let g:syntastic_check_on_open = 1 " Check syntax on open
"" let g:syntastic_always_populate_loc_list = 1 " Errors will be populated in location list immediately after being found
"
"" The error window will automatically open when errors are detected, and automatically close when none are detected
"" let g:syntastic_auto_loc_list = 1 
" 
"" PYTHON
"let g:syntastic_python_checkers=["flake8"]
"" Ignore the following errors: 'white space before operator'(E221), 
"" 'Line too long'(E501)
"" 'Missing whitespace around operator'(E226){{{}}}
"" 'At least two spaces between inline comments'(E261)
"" 'Multiple statements in one line'(E701)
"" 'Module import not at the top of file'(E402)
"" 'Do not assign lambda to a variable, use def instead' (E731)
"" 'Comparison against False literal with stupid syntax'(E712)
"" 'Multiple spaces after ':' '(E241)
"" 'Redifinition of unused variable' (F811) Messes up with pytest.fixtures
"let g:syntastic_python_flake8_args="--ignore=E221,E226,E501,E261,E701,E402,E731,E712,E241,F811"
"let g:syntastic_python_python_exec = 'python3'
" 
"" LATEX
"let g:syntastic_tex_checkers = ['chktex']
"
"" JAVA
"" Disable syntastic for java by fooling syntastic to thinking that javac has
"" been loaded
"" let g:loaded_syntastic_java_javac_checker = 1
"
"" Go to next/previous error
"nnoremap <leader>e :call LocationNext()<cr> 
"nnoremap <leader>E :call LocationPrevious()<cr>
"
"" Wrap both ways when searching for next and previous errors
"function! LocationNext()
"    try
"        lnext
"    catch /^Vim\%((\a\+)\)\=:E553/
"        lfirst
"    endtry
"endfunction
"
"function! LocationPrevious()
"    try
"        lprev
"    catch /^Vim\%((\a\+)\)\=:E553/
"        llast
"    endtry
"endfunction
"
"" Toggle error location list
"nnoremap <leader>se :call ShowErrors()<cr>
"
"function! ShowErrors()
"    let old_last_winnr = winnr('$')
"    lclose
"    if old_last_winnr == winnr('$')
"        " Nothing was closed, open syntastic error location panel
"        Errors
"    endif
"endfunction

" }}}
" PLUGIN: COC {{{

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" }}}
" PLUGIN: fzf-vim {{{

nnoremap <c-L> :BLines<CR>
nnoremap <c-P> :Files<CR>
nnoremap <leader><c-P> :Files ~<CR>
nnoremap <c-F> :Ag<CR>
nnoremap <c-B> :Buffers<CR>
nnoremap <c-H> :Help<CR>

let g:fzf_files_options = "--preview 'bat --plain --color \"always\" {}'"

" general
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
let $FZF_DEFAULT_OPTS="--reverse " " top to bottom

" use rg by default
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" floating fzf window with borders
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 1, max([200, &columns - 20])])
    let height = min([&lines - 1, max([25, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction


" Show registers and their content
command! Registers call fzf#run(fzf#wrap({
        \ 'source': GetRegisters(),
        \ 'sink': function('UseRegister')}))

function! UseRegister(line)
  execute ':put ' a:line[1]
endfunction

function! GetRegisters()
  redir => cout
  silent registers
  redir END
  return split(cout, "\n")[1:11]
endfunction


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
" PLUGIN: Limelight {{{
let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Toggle limelight
nnoremap <C-l><C-l> :Limelight!!<CR>
" }}}
" PLUGIN: Vista {{{
nnoremap <leader>vt :Vista coc<cr>G
nnoremap <leader>vf :Vista finder<cr>
" let g:vista_default_executive = 'coc'

let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_sidebar_width = 40  " Default of 30 was too narrow


" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc 
" set statusline+=%{NearestMethodOrFunction()}
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" function! NearestMethodOrFunction() abort
"   return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" }}}
" PLUGIN: vim-slime {{{
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
" }}}
" PLUGIN: vim-instant-markdown {{{
" Allow for mathjax
let g:instant_markdown_mathjax = 1
" Don't start instant markdown preview
let g:instant_markdown_autostart = 0
" }}}
" PLUGIN: vim-test {{{
nnoremap t<c-f> :TestFile<cr>
nnoremap t<c-n> :TestNearest<cr>
" }}}}
" MISCELANEOUS {{{
set t_Co=256 " terminal with 256 colours

" To nicely format paragraphs in latex
if filereadable(expand("~/.config/nvim/FormatParagraph.vim"))
 source ~/.config/nvim/FormatParagraph.vim
endif

nnoremap <leader>m :call FormatParagraph()<CR>
" }}}
" Default Highlights {{{
" Default highlights MUST be at the end of the vimrc because some plugins
" override higlight settings
" Bold text selected in visual mode
highlight Folded ctermbg=0 cterm=bold
highlight Visual ctermbg=237 cterm=bold
" Set the font of the matching searched terms to *bold*
highlight Search cterm=bold
highlight IncSearch cterm=bold ctermbg=230
" Pmenu relates to floating windows
highlight Pmenu               ctermfg=15    ctermbg=0
highlight PmenuThumb          ctermbg=7
highlight PmenuSBar           ctermbg=8
" ctermbg = 11 also works really well for PmenuSel
highlight PmenuSel            ctermfg=0     ctermbg=6 cterm=bold

hi Normal guibg=NONE ctermbg=None
" }}}
