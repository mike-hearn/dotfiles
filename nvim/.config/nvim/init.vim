" Initial load config {{{ ·····················································


" Install vim-plug on first load
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" set/create backup directories
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set undodir=~/.vim/tmp/undo

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif

if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

" }}}

" {{{ Settings ································································

syntax enable

set autochdir                   " Autoset working dir to current file's dir
set autoindent                  " Copy the indentation from the previous line
set nobackup                    " Advised by setting by coc.nvim
set nowritebackup               " Advised by setting by coc.nvim
set colorcolumn=80              " Visually mark col 80
set cmdheight=2
set fillchars+=vert:│           " Sleeker split character between panes
set formatoptions-=t
set hidden                      " Allows changing buffers w/o outright closing them
set ignorecase                  " Ignore case when searching
set iskeyword+=\-               " Makes '-' char part of a word for tags, searching, etc
set matchtime=3                 " Time in tenths of seconds to show match
set mouse=a                     " Mouse support in iTerm et al
set nofoldenable                " Start without folds
set noshowmode                  " Hides --INSERT-- because lightline handles it
set nostartofline               " Cursor maintains position when switching buffers
set noswapfile
set nowrap                      " Don't automatically wrap on load
set relativenumber number       " Show line numbers, make 'em relative to the current line
set shiftround                  " Rounds your tabs if you're on a weird interval, like 3 spaces in, will move it to 4 (instead of 7)
set shiftwidth=4                " Amount of whitespace to insert
set shortmess+=c
set showmatch                   " Highlight matching paren, brace, bracket
set signcolumn=yes
set smartcase                   " Ignore case if search pattern is lowercase
set softtabstop=4               " Fine-tunes amount of insert whitespace
set spellsuggest=best,10        " Spelling
set tabstop=4                   " Specifies width of tab character
set tw=79                       " Width of document (used by gd)
set undofile                    " Undo history maintained across sessions
set undolevels=1000             " Save last 1000 changes"
set undoreload=10000            " Load last 10,000 changes?
set wildmenu                    " Visual autocomplete for command menu
set updatetime=300              " UI update time for things like git-gutter

" Set python to homebrew version
let homebrew_prefix=systemlist("brew --prefix")[0]
let g:python_host_prog=homebrew_prefix . "/bin/python"
let g:python3_host_prog=homebrew_prefix . "/bin/python3"

" ========================================================================= }}}

" Mappings {{{ ································································

let g:mapleader = ","
let maplocalleader = "\\"

" Easy escaping
inoremap jj <ESC>
inoremap kj <ESC>
inoremap jk <ESC>

" Sensible traversal using j/k
nnoremap j gj
nnoremap k gk

" Easier jumping to beginning & end
noremap H ^
noremap L g_

" Quick delete entire line
nnoremap D 0C<Esc>

" Buffer management; for additiona mappings, see tinymode PluginSettings()
noremap  <Leader>a <C-^>
nnoremap <Leader>n :bp<CR>
nnoremap <Leader>m :bn<CR>
nnoremap <Leader>x :b #<CR>:bd #<CR>
nnoremap <Leader>q <C-w>q
nnoremap <Leader>X :BufOnly<CR>

" Home key buffer navigation
nnoremap <Leader>ja :BufferHistoryJumpTo 0<CR>
nnoremap <Leader>js :BufferHistoryJumpTo 1<CR>
nnoremap <Leader>jd :BufferHistoryJumpTo 2<CR>
nnoremap <Leader>jf :BufferHistoryJumpTo 3<CR>
nnoremap <Leader>jg :BufferHistoryJumpTo 4<CR>
nnoremap <Leader>jh :BufferHistoryJumpTo 5<CR>

" Tab using leader + N/M
nnoremap <Leader>N :tabprevious<CR>
nnoremap <Leader>M :tabnext<CR>

" Easier formatting of paragraphs
vnoremap Q gq
nnoremap Q gqap

" Code folding
nnoremap <space> za
vnoremap <space> zf
vnoremap <leader>za :call FoldAroundSelection()<CR>
nnoremap <silent> z0 :call UnfoldAndRememberScrollPosition(0)<CR>
nnoremap <silent> z1 :call UnfoldAndRememberScrollPosition(1)<CR>
nnoremap <silent> z2 :call UnfoldAndRememberScrollPosition(2)<CR>
nnoremap <silent> z3 :call UnfoldAndRememberScrollPosition(3)<CR>
nnoremap <silent> z4 :call UnfoldAndRememberScrollPosition(4)<CR>
nnoremap <silent> z5 :call UnfoldAndRememberScrollPosition(5)<CR>
nnoremap <silent> z6 :call UnfoldAndRememberScrollPosition(6)<CR>
nnoremap <silent> z7 :call UnfoldAndRememberScrollPosition(7)<CR>
nnoremap <silent> z8 :call UnfoldAndRememberScrollPosition(8)<CR>
nnoremap <silent> z9 :call UnfoldAndRememberScrollPosition(9)<CR>

" Window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle NERDTree
map <C-\> :NERDTreeToggle<CR>
nnoremap <Leader>F :NERDTreeFind<CR>

" Move lines up/down with ease (alt + j/k)
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==

" Save, and exit insert-mode afterward
inoremap <D-s> <Esc>:w<CR>
nnoremap <D-s> :w<CR>
vnoremap <D-s> :w<CR>

" Super undo with Gundo.vim
nnoremap <leader>u :GundoToggle<CR>

" Vertically split the current & alternative buffer
nnoremap <leader>V :b #<CR>:vsp #<CR>
nnoremap <leader>v :call SplitAndMaintainPosition()<CR><C-w><C-w>
nnoremap <leader>A :on<CR>
nnoremap <leader>S :call ShiftSplitAndLock()<CR>
nnoremap <leader>D :call TriShiftSplitAndLock()<CR>

nnoremap <C-n> :call NumberToggle()<cr>

" Map <Leader>w to save, because I already do it accidentally
nnoremap <leader>w :w<CR>
inoremap <leader>w <Esc>:w<CR>
nnoremap <leader>W :wa<CR>
inoremap <leader>W <Esc>:wa<CR>

" Search for the visual selection with // in visual mode
vnoremap // y/<C-R>"<CR>

" Quick editing/re-loading of config & functions file
nnoremap <leader>R :source ~/.config/nvim/init.vim<CR>
            \ :source ~/.config/nvim/init.vim<CR>
            \ :echo "Neovim config reloaded!"<CR>
nnoremap <leader>ef :e ~/.config/nvim/functions.vim<CR>
nnoremap <leader>eF :so ~/.config/nvim/functions.vim<CR>
nnoremap <leader>ec :e ~/.config/nvim/init.vim<CR>

" Ag search for visually selected text
vnoremap <leader>f y:Ag <C-R>0<CR>

" C-i now incremeents, because C-a is tmux prefix
nmap <leader>i <C-a>

" Remap arrow keys for blink/mobile usage
nnoremap <up> <c-u>
nnoremap <down> <c-d>

" Map c-] to go to definition
function! GoToDefinition() abort
    let l:originalpos = getpos('.')
    let l:newlinepos = getpos('.')
    let l:original_filename = expand('%')

    if l:originalpos == l:newlinepos
        silent! execute "YcmCompleter GoTo"
        let l:newlinepos = getpos('.')
    endif

    if l:originalpos == l:newlinepos
        silent! call jedi#goto_assignments()
        let l:newlinepos = getpos('.')
    endif

    if l:originalpos == l:newlinepos
        silent! call CocActionAsync('jumpDefinition')
        let l:newlinepos = getpos('.')
    endif

    if l:originalpos == l:newlinepos
        silent! execute "normal g\<c-]>"
        let l:newlinepos = getpos('.')
    endif

    if l:originalpos == l:newlinepos
        echo "No definition found."
    endif
endfunction
nnoremap <silent> <c-]> :call GoToDefinition()<CR>


" }}}

" {{{ Functions ·······························································

" {{{ Stable Functions

" Writes current full file path to ~/.vim_history unless it is part of a
" plugin (hence the check for ///, e.g. fugitive:///...)
function! WriteFileToHistory() abort
    if expand('%:p') !~ "\/\/\/"
        call system('touch ~/.vim_history')
        call system('echo '.shellescape(expand('%:p')).' >> ~/.vim_history')
    endif
endfunction


" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction


" Restore current view settings.
function! AutoRestoreWinView() abort
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction


function! FoldAroundSelection() abort
    if !exists("b:originalfoldmethod")
        let b:originalfoldmethod = &foldmethod
    endif
    set foldmethod=manual

    normal zE
    normal 
    normal `<k
    normal zfgg
    normal `>j
    normal zfG
    normal `<
endfunction


function! RemoveAllFoldsAndResetFoldmethod() abort
    if exists("b:originalfoldmethod")
        let &foldmethod = b:originalfoldmethod
    endif
    normal zRzz
endfunction


function! UnfoldAndRememberScrollPosition(foldlevel) abort
    " Grab initial line & curs position
    let l:originalpos = getpos('.')
    let l:originalline = l:originalpos[1]
    let l:originalcurs = l:originalpos[2]

    " Grab original winline, i.e. position from the top of the vim window
    let l:winline = winline()

    " Unfold based on foldlevel
    if a:foldlevel == 0
        :call RemoveAllFoldsAndResetFoldmethod()
    else
        normal zM
        set foldnestmax=2
        if (a:foldlevel - 1) > 0
            execute "set foldnestmax=". a:foldlevel
            execute "normal". (a:foldlevel - 1). "zr"
        endif
    endif

    " Send the current line to the top, then scroll it down so the current
    " position matches the previous winline
    normal zt
    let l:topwinline = winline()
    if (l:winline - l:topwinline) > 0
        execute "normal! ". (l:winline - l:topwinline). "\<C-y>"
    endif

endfunction

function! SplitAndMaintainPosition() abort
    only
    let l:winview = winsaveview()
    :vsp %
    call winrestview(l:winview)
endfunc

function! ShiftSplitAndLock() abort
    " When a pane is split in two, this will shift the right page a full page
    " view, and scrollbind the two panes, so double the length is visible
    only
    vsplit
    set noscrollbind
    wincmd w
    set noscrollbind
    execute "normal! \<C-F>"
    set scrollbind
    wincmd w
    set scrollbind
endfunction

function! TriShiftSplitAndLock() abort
    " Same as ShiftSplitAndLock, except creates three scrollbound panes.

    " First window
    only
    set noscrollbind
    let current_win = winnr()
    vsplit
    wincmd l

    " Second window
    set noscrollbind
    execute "normal! \<C-F>"
    vsplit
    wincmd l

    " Third window
    set noscrollbind
    execute "normal! \<C-F>"
    set scrollbind

    wincmd h
    set noscrollbind
    set scrollbind

    wincmd h
    set noscrollbind
    set scrollbind
endfunction


" Toggle between standard and relative line numbers
function! NumberToggle() abort
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" Remove dead files from MRU list
function! Refresh_MRU() abort
    for l:file in fzf_mru#mrufiles#list('raw')
        let l:to_remove = []
        if !filereadable(l:file)
            call add(l:to_remove, l:file)
        endif
        if len(l:to_remove) > 0
            call fzf_mru#mrufiles#remove(l:to_remove)
        endif
    endfor
endfunction

" }}}
" {{{ Test Functions
"

command! -nargs=0 -range SortWords call SortWords()
" Add a mapping, go to your string, then press vi",s
" vi" selects everything inside the quotation
" ,s calls the sorting algorithm
vmap ,s :SortWords<CR>
" Normal mode one: ,s to select the string and sort it
nmap ,s vi",s

function! SortWords() abort
    " Get the visual mark points
    let StartPosition = getpos("'<")
    let EndPosition = getpos("'>")

    if StartPosition[0] != EndPosition[0]
        echoerr "Range spans multiple buffers"
    elseif StartPosition[1] != EndPosition[1]
        " This is a multiple line range, probably easiest to work line wise

        " This could be made a lot more complicated and sort the whole
        " lot, but that would require thoughts on how many
        " words/characters on each line, so that can be an exercise for
        " the reader!
        for LineNum in range(StartPosition[1], EndPosition[1])
            call setline(LineNum, join(sort(split(getline('.'), ' ')), " "))
        endfor
    else
        " Single line range, sort words
        let CurrentLine = getline(StartPosition[1])

        " Split the line into the prefix, the selected bit and the suffix

        " The start bit
        if StartPosition[2] > 1
            let StartOfLine = CurrentLine[:StartPosition[2]-2]
        else
            let StartOfLine = ""
        endif
        " The end bit
        if EndPosition[2] < len(CurrentLine)
            let EndOfLine = CurrentLine[EndPosition[2]:]
        else
            let EndOfLine = ""
        endif
        " The middle bit
        let BitToSort = CurrentLine[StartPosition[2]-1:EndPosition[2]-1]

        " Move spaces at the start of the section to variable StartOfLine
        while BitToSort[0] == ' '
            let BitToSort = BitToSort[1:]
            let StartOfLine .= ' '
        endwhile
        " Move spaces at the end of the section to variable EndOfLine
        while BitToSort[len(BitToSort)-1] == ' '
            let BitToSort = BitToSort[:len(BitToSort)-2]
            let EndOfLine = ' ' . EndOfLine
        endwhile

        " Sort the middle bit
        let Sorted = join(sort(split(BitToSort, ' ')), ' ')
        " Reform the line
        let NewLine = StartOfLine . Sorted . EndOfLine
        " Write it out
        call setline(StartPosition[1], NewLine)
    endif
endfunction


"
" }}}

" }}}

" Plugins {{{ ·································································

    call plug#begin('~/.local/share/nvim/plugged')

    " Start with sensible defaults
    Plug 'tpope/vim-sensible'

    " Themes
    Plug 'chriskempson/base16-vim'
    Plug 'mike-hearn/base16-vim-lightline'

    " Syntax & IDE plugins
    Plug 'posva/vim-vue', {'for': 'vue'}
    Plug 'fatih/vim-go'
    Plug 'jceb/vim-orgmode'
    Plug 'tpope/vim-speeddating', { 'for': 'org'}  " Required by orgmode
    Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
    Plug 'ekalinin/Dockerfile.vim', { 'for': ['Dockerfile', 'docker-compose'] }
    Plug 'tweekmonster/django-plus.vim', { 'for': ['Dockerfile', 'docker-compose'] }
    Plug 'chr4/nginx.vim'
    Plug 'amadeus/vim-mjml'
    Plug 'sheerun/vim-polyglot' " Multi-language pack

    " Linters/Formatters/Checkers
    Plug 'dense-analysis/ale'
    Plug 'maximbaz/lightline-ale'
    Plug 'prettier/vim-prettier', {'do': 'yarn install'}

    " IDE & Productivity Features
    Plug 'itchyny/lightline.vim' " Lightweight powerline-esque bar at bottom of window
    Plug 'mike-hearn/vim-buftabline-with-devicons' " List buffers at top of vim window
    Plug 'tpope/vim-commentary' " Comment stuff out with gcc
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } " Sidebar file explorer (c+\)
    Plug 'tpope/vim-fugitive' " Git management within vim
    Plug 'tpope/vim-unimpaired' " Key bindings for vim-fugitive
    Plug 'tpope/vim-repeat' " Repeatable events from plugins
    Plug 'airblade/vim-gitgutter' " Show which lines have been edited from git working version
    Plug 'vim-scripts/tinymode.vim' " Allows for repetitve shortcuts w/o typing prefix key, e.g. ^W++- instead of ^W+^W+^W-
    Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' } " Tracks undo history like a git tree
    Plug 'vim-scripts/BufOnly.vim' " Close all buffers except open
    Plug 'airblade/vim-rooter' " Sets the pwd to git root
    Plug 'teranex/jk-jumps.vim' " Adds a 'jump' when using, eg, 10j to move, useful for c+o/c+i navigation
    Plug 'mike-hearn/vim-buffer-history' " Keeps track of buffer history
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  } " Installs fzf if not already installed
    Plug 'junegunn/fzf.vim' " My favorite fuzzy search
    Plug 'mike-hearn/vim-combosearch' " Trying to create my own code search
    Plug 'tpope/vim-obsession' " Remember vim session state
    Plug 'christoomey/vim-tmux-navigator' " Treats vim splits as tmux panes, allowing same shortcuts
    Plug 'jiangmiao/auto-pairs' " Completes the pair for ( and { and [ etc
    Plug 'tmux-plugins/vim-tmux-focus-events' " For auto-reloading on focus
    Plug 'mattn/emmet-vim' " Shortcuts to quickly scaffold html
    Plug 'fisadev/vim-isort', { 'on': ['Isort'] } " Autosort python imports
    Plug 'SirVer/ultisnips' " My custom snippets for code reuse
    Plug 'honza/vim-snippets' " Community custom snippets
    Plug 'tpope/vim-surround' " Shortcuts to modify characters/code around an object, eg add quotes on a string
    Plug 'editorconfig/editorconfig-vim' " Imports editorconfig file
    Plug 'romainl/vim-cool' " Un-highlights text if you navigate away from word
    Plug 'tpope/vim-sleuth' " Basically triggers :noh once you move your cursor off a highlighted word
    Plug 'tpope/vim-tbone'  " Adds tmux commands to vim, specifically copying into tmux clipboard
    Plug 'ludovicchabant/vim-gutentags' " Automatically creates tags file
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'pbogut/fzf-mru.vim'
    Plug 'mike-hearn/vim-remote-vscode-connection'
    Plug 'danilamihailov/beacon.nvim'

    " Completion
    Plug 'Shougo/neco-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc-neco'

    " Local settings
    Plug 'embear/vim-localvimrc'

    call plug#end()

" }}}

" {{{ Plugin Settings ·························································

" {{{ Ale
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '·'

let g:ale_linters = {
            \   'sh': ['shellcheck'],
            \   'go': ['go build'],
            \   'css': ['stylelint'],
            \   'scss': ['stylelint'],
            \   'python': ['pylint', 'flake8'],
            \   'vue': ['vls']
            \}

let g:ale_fixers = {
            \   'css': ['stylelint', 'prettier'],
            \   'go': ['gofmt'],
            \   'html': ['prettier'],
            \   'html.handlebars': ['prettier'],
            \   'javascript': ['eslint', 'prettier'],
            \   'json': ['prettier'],
            \   'python': ['isort', 'black'],
            \   'scss': ['stylelint', 'prettier', 'remove_trailing_lines'],
            \   'sh': ['shfmt'],
            \   'vue': ['prettier'],
            \   'xml': ['xmllint'],
            \}

let g:ale_python_black_options = '--line-length=80'
autocmd FileType html.handlebars let b:ale_javascript_prettier_options = '--parser=glimmer'

let g:jsx_ext_required = 0
" }}}
" {{{ beacon.nvim
let g:beacon_size = 40
" }}}
" {{{ BufTabLine
let g:buftabline_numbers = 2
let g:buftabline_indicators = 1
let g:buftabline_separators = 0
hi! link BufTabLineCurrent LightlineLeft_normal_0
hi! link BufTabLineActive TabLineSel

map π :call AutoPairsToggle()<CR>
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)
" }}}
" {{{ Colors
let base16theme = $BASE16_THEME
try
    execute "colorscheme ".base16theme
    let csunderscores = substitute(base16theme, '-', '_', 'g')
catch
    execute "colorscheme base16-".base16theme
    let csunderscores = "base16_".substitute(base16theme, '-', '_', 'g')
endtry


autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" }}}
" {{{ Completion (coc.nvim)

" Use <c-k> for trigger completion.
inoremap <silent><expr> <c-k> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>

function! s:show_documentation() abort
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


" }}}
" {{{ devicons
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
" }}}
" {{{ EasyMotion
map s <Plug>(easymotion-s)
" }}}
" {{{ emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" }}}
" {{{ fugitive.vim
nmap <leader>gs :Gstatus<cr>gg<C-n>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gw :Gwrite<cr>
nmap <leader>gr :Gread<cr>
nmap <leader>gcc :Gwrite<cr>:Gcommit<cr>I
" }}}
" {{{ FZF

let g:fzf_layout = { 'down': '~40%' }

" Mappings
nmap <Leader>s :Buffers<CR>
nmap <Leader>f :FZFMru<CR>

let g:fzf_files_options =
            \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

autocmd VimEnter * command! -bang -nargs=* FileAndCodeSearch
            \ call fzf#vim#grep(
            \   'fd | sed "s/$/:0:0/g"; rg --smart-case --column --hidden --max-columns=500  --glob=\!".git" --line-number --no-heading --color=always "[A-Za-z0-9]"', 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0
            \)

autocmd VimEnter * command! -bang -nargs=* Ag
            \ call fzf#vim#grep(
            \   'rg --smart-case --column --hidden --max-columns=500  --glob=\!".git" --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0
            \)


autocmd VimEnter * command! -bang -nargs=* Aga
            \ call fzf#vim#grep(
            \   'rg -uuuu --smart-case --column --max-columns=500  --glob=\!".git" --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0
            \)

" For use with FZF's grep functionality to replicate :History
" Read file history from ~/.vim_history rather than ':oldfiles' (see
" WriteFileToHistory function for where each buffer is written to Vim
" history)
if executable('tac')
    command! -bang -nargs=* FilesFromVimHistory
                \ call fzf#vim#grep('tac ~/.vim_history | cat -n | sort -uk2 | sort -nk1 | cut -f2- | sed "s/$/:1/"', 0)
else
    command! -bang -nargs=* FilesFromVimHistory
                \ call fzf#vim#grep('tail -r ~/.vim_history | cat -n | sort -uk2 | sort -nk1 | cut -f2- | sed "s/$/:1/"', 0)
endif
" }}}
" {{{ Gitgutter
let g:gitgutter_max_signs = 1500
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '┃'
" }}}
" {{{ Gutentags
let g:gutentags_ctags_tagfile = '.git/tags'
let g:gutentags_ctags_extra_args = ['--fields=+l', '--tag-relative=yes']
" }}}
" {{{ Indentline
let g:indentLine_color_term = 18
let g:indentLine_char = '│'
" }}}
" {{{ jedi
let g:jedi#popup_select_first = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#usages_command = ""
let g:jedi#completions_enabled = 0

command! -bang JediUsage  call jedi#usages()
command! -bang JediRename call jedi#rename()
" }}}
" {{{ lightline
let g:lightline = {}
let g:lightline.colorscheme = csunderscores
let g:lightline.component = {
            \ 'customlineinfo': "Line %{line('.') . '/' . line('$')}",
            \ }
let g:lightline.component_expand = {
            \ 'linter_checking': 'lightline#ale#checking',
            \ 'linter_warnings': 'lightline#ale#warnings',
            \ 'linter_errors': 'lightline#ale#errors',
            \ 'linter_ok': 'lightline#ale#ok',
            \ }
let g:lightline.component_type = {
            \ 'linter_checking': 'left',
            \ 'linter_warnings': 'warning',
            \ 'linter_errors': 'error',
            \ 'linter_ok': 'left',
            \ }
let g:lightline.component_function = {
            \ 'cocstatus': 'coc#status'
            \ }
let g:lightline.active = {
            \ 'left': [
            \            [ 'mode', 'paste' ],
            \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
            \            [ 'readonly', 'filename', 'modified' ],
            \  ],
            \ 'right': [
            \            [ 'filetype'],
            \            [ 'customlineinfo' ],
            \ ]
            \}

  " Use auocmd to force lightline update.
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
" }}}
" {{{ MRU (most recent files)
let MRU_Max_Entries = 10000
" }}}
" {{{ NERDCommenter
let g:NERDSpaceDelims=1
" }}}
" {{{ NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeIgnore = [
            \ 'node_modules',
            \ '\.pyc$',
            \ '__pycache__']

let g:NERDTreeGitStatusIndicatorMap = {
            \ 'Modified'  : '✹',
            \ 'Staged'    : '✚',
            \ 'Untracked' : '✭',
            \ 'Renamed'   : '➜',
            \ 'Unmerged'  : '═',
            \ 'Deleted'   : '✖',
            \ 'Dirty'     : '✗',
            \ 'Clean'     : '✔︎',
            \ 'Ignored'   : '',
            \ 'Unknown'   : '?'
            \ }
" }}}
" {{{ org-mode
let g:org_agenda_files = ['~/Dropbox/org/*.org']
" }}}
" {{{ python-mode
let g:pymode_warnings = 0
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_motion = 0
let g:pymode_options = 0
let g:pymode_indent = 0
let g:pymode_breakpoint_bind = ''
" }}}
" {{{ tinymode
" tinymode.vim - Buffer mappings
call tinymode#EnterMap("bufferchange", "<Leader>m", "m")
call tinymode#EnterMap("bufferchange", "<Leader>n", "n")
call tinymode#Map("bufferchange", "m", "bn")
call tinymode#Map("bufferchange", "n", "bp")

" tinymode.vim - Tab mappings
call tinymode#EnterMap("tabchange", "<Leader>M", "M")
call tinymode#EnterMap("tabchange", "<Leader>N", "N")
call tinymode#EnterMap("tabchange", "<M", "M")
call tinymode#EnterMap("tabchange", "<N", "N")
call tinymode#Map("tabchange", "M", "tabnext")
call tinymode#Map("tabchange", "N", "tabprevious")

" tinymode.vimm - Window size mappings
call tinymode#EnterMap("winsize", "<C-W>+", "+")
call tinymode#EnterMap("winsize", "<C-W>-", "-")
call tinymode#Map("winsize", "+", "3wincmd +")
call tinymode#Map("winsize", "-", "3wincmd -")
call tinymode#EnterMap("winsize", "<C-W>>", ">")
call tinymode#EnterMap("winsize", "<C-W><", "<")
call tinymode#Map("winsize", ">", "3wincmd >")
call tinymode#Map("winsize", "<", "3wincmd <")
" }}}
" {{{ UltiSnips
let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsJumpBackwardTrigger="<NUL>"
let g:UltiSnipsJumpForwardTrigger="<NUL>"
nnoremap <Leader>U :UltiSnipsEdit<CR>
" }}}
" {{{ vim-black
let g:black_linelength = 79
" }}}
" {{{ vim-commentary
nnoremap <silent> <leader>c<space> :Commentary<CR>
vnoremap <silent> <leader>c<space> :Commentary<CR>
" }}}
" {{{ vim-combosearch
let g:combosearch_trigger_key = "<c-p>"
let g:combosearch_trigger_key_all = "<c-t>"
let g:combosearch_pattern_length = 3
let g:combosearch_ignore_patterns = [".git", "node_modules", ".venv"]
let g:combosearch_fzf_exact_match = 1
" }}}
" {{{ vim-localvimrc
let g:localvimrc_persistent = 2
" }}}
" {{{ vim-rooter
let g:rooter_silent_chdir = 1
" }}}
" {{{ vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
" }}}

" }}}

" {{{ Colors ··································································
" Fixes a bug with termguicolors and tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

exec 'hi ALEError cterm=underline ctermfg=1 gui=bold,undercurl guifg=' . g:terminal_color_1
exec 'hi ALEErrorSign ctermbg=0 ctermfg=1 guifg=' . g:terminal_color_1
exec 'hi ALEWarning cterm=underline ctermfg=3 gui=bold,undercurl guifg=' . g:terminal_color_3
exec 'hi ALEWarningSign ctermbg=0 ctermfg=3 guifg=' . g:terminal_color_3
exec 'hi CocErrorSign ctermfg=1 ctermbg=0'
exec 'hi CocHintSign ctermfg=green ctermbg=0'
exec 'hi CocInfoSign ctermfg=3 ctermbg=0'
exec 'hi CocWarningSign ctermfg=3 ctermbg=0'
exec 'hi ColorColumn ctermbg=18'
exec 'hi CursorLine ctermbg=0'
exec 'hi CursorLineNr ctermbg=0 guibg=0'
exec 'hi DiffAdd ctermbg=0'
exec 'hi DiffChange ctermbg=0'
exec 'hi DiffDelete ctermbg=0'
exec 'hi DiffText ctermbg=0'
exec 'hi FoldColumn ctermbg=0 ctermfg=white'
exec 'hi Folded ctermbg=0 ctermfg=20 guibg=0'
exec 'hi GitGutterAdd ctermbg=0 guibg=0'
exec 'hi GitGutterChange ctermbg=0 guibg=0'
exec 'hi GitGutterChangeDelete ctermbg=0 guibg=0'
exec 'hi GitGutterDelete ctermbg=0 guibg=0'
exec 'hi LineNr ctermbg=0 guibg=0'
exec 'hi NonText ctermfg=bg guifg=bg'
exec 'hi Pmenu ctermbg=18'
exec 'hi PmenuSel ctermfg=0 ctermbg=7'
exec 'hi QuickFixLine ctermbg=19'
exec 'hi SignColumn ctermbg=0 ctermfg=15 guibg=0'
exec 'hi StatusLineNC ctermbg=0'
exec 'hi TabLine ctermbg=18'
exec 'hi TabLineFill ctermbg=18 ctermfg=20'
exec 'hi TabLineSel ctermbg=19'
exec 'hi VertSplit ctermbg=NONE guibg=NONE'
exec 'hi VertSplit ctermfg=20'
exec 'hi Visual ctermbg=19'
" }}}

" Filetype/Autoload Settings {{{ ··············································

" {{{ General file settings

" Write filename to history file on open/read
augroup write_file
  autocmd!
  autocmd BufReadPost * call WriteFileToHistory()
augroup END

" When switching buffers, preserve window view.
augroup save_restore_win_view
  autocmd!
  autocmd BufLeave * call AutoSaveWinView()
  autocmd BufEnter * call AutoRestoreWinView()
augroup END

" }}}
" {{{ CSS/SCSS
augroup filetype_css
  autocmd!
  autocmd FileType css setlocal foldmethod=syntax
augroup END
" }}}
" {{{ Go
augroup filetype_go
  autocmd!
  autocmd FileType go setlocal foldmethod=syntax
augroup END
" }}}
" {{{ HTML/Handlebars/Mustache
augroup filetype_html_handlebars_etc
  autocmd!
  autocmd FileType handlebars,html,html.handlebars setlocal foldmethod=indent
  autocmd FileType htmldjango setlocal foldmethod=indent
augroup END
" }}}
" {{{ Javascript/JSX
augroup filetype_javascript_jsx
  autocmd!
  autocmd FileType javascript,javascript.jsx,json setlocal foldmethod=syntax
  autocmd FileType javascript,javascript.jsx,json nnoremap <buffer> <leader>b odebugger;<esc>k
  autocmd FileType javascript,javascript.jsx,json nnoremap <buffer> <leader>B Odebugger;<esc>j
augroup END
" }}}
" {{{ JSON
augroup filetype_json
  autocmd!
  autocmd FileType json setlocal foldmethod=syntax
augroup END
" }}}
" {{{ Python
augroup filetype_python
  autocmd!
  autocmd FileType python setlocal foldmethod=indent
  autocmd FileType python nnoremap <buffer> <leader>b oimport ipdb<CR>ipdb.set_trace()  # XXX BREAKPOINT<esc>k
  autocmd FileType python nnoremap <buffer> <leader>B Oimport ipdb<CR>ipdb.set_trace()  # XXX BREAKPOINT<esc>j
augroup END
" }}}
" {{{ sh
augroup filetype_sh
  autocmd!
  autocmd FileType sh setlocal foldmethod=indent
augroup END
" }}}
" {{{ Vim
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal shiftwidth=4
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" {{{ YAML
augroup filetype_yaml
  autocmd!
  autocmd FileType yaml setlocal foldmethod=indent
augroup END
" }}}

" }}}

" vim: foldmethod=marker: foldlevel=0: foldenable
