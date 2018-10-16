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
set backup
set colorcolumn=80              " Visually mark col 80
set fillchars+=vert:│           " Sleeker split character between panes
set fo-=t                       " Don't wrap at 80 characters when typing
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
set smartcase                   " Ignore case if search pattern is lowercase
set softtabstop=4               " Fine-tunes amount of insert whitespace
set spellsuggest=best,10        " Spelling
set tabstop=4                   " Specifies width of tab character
set tw=79                       " Width of document (used by gd)
set undofile                    " Undo history maintained across sessions
set undolevels=1000             " Save last 1000 changes"
set undoreload=10000            " Load last 10,000 changes?
set wildmenu                    " Visual autocomplete for command menu

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
nnoremap <Leader>r :on<CR>
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
nnoremap <leader>v :b #<CR>:vsp #<CR>
nnoremap <leader>V :call SplitAndMaintainPosition()<CR>
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

" }}}

" {{{ Functions ·······························································

" {{{ Stable Functions

" Writes current full file path to ~/.vim_history unless it is part of a
" plugin (hence the check for ///, e.g. fugitive:///...)
function! WriteFileToHistory()
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
function! AutoRestoreWinView()
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


function! FoldAroundSelection()
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


function! RemoveAllFoldsAndResetFoldmethod()
    if exists("b:originalfoldmethod")
        let &foldmethod = b:originalfoldmethod
    endif
    normal zRzz
endfunction


function! UnfoldAndRememberScrollPosition(foldlevel)
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

function! SplitAndMaintainPosition()
    only
    let l:winview = winsaveview()
    :vsp %
    call winrestview(l:winview)
endfunc

function! ShiftSplitAndLock()
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

function! TriShiftSplitAndLock()
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
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" }}}
" {{{ Test Functions
"
" (Nothing currently being tested.)
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
    Plug 'sheerun/vim-polyglot'
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    Plug 'python-mode/python-mode', { 'for': 'python' }
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'jceb/vim-orgmode'
    Plug 'tpope/vim-speeddating'  " Required by orgmode
    Plug 'ternjs/tern_for_vim'
    Plug 'HerringtonDarkholme/yats.vim'

    " Linters/Formatters/Checkers
    Plug 'w0rp/ale'
    Plug 'tell-k/vim-autopep8', { 'for': 'python' }
    Plug 'ambv/black', { 'for': 'python' }
    Plug 'prettier/vim-prettier', {
                \'do': 'yarn install',
                \'for': ['javascript', 'javascript.jsx', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

    " IDE & Productivity Features
    Plug 'itchyny/lightline.vim' " Lightweight powerline-esque bar at bottom of window
    Plug 'ap/vim-buftabline' " List buffers at top of vim window
    Plug 'Lokaltog/vim-easymotion' " Quickly jump to specific character on screen
    Plug 'tpope/vim-commentary' " Comment stuff out with gcc
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } " Sidebar file explorer (c+\)
    Plug 'Xuyuanp/nerdtree-git-plugin' " Show file git status in nerdtree
    Plug 'tpope/vim-fugitive' " Git management within vim
    Plug 'tpope/vim-unimpaired' " Key bindings for vim-fugitive
    Plug 'tpope/vim-repeat' " Repeatable events from pugins
    Plug 'airblade/vim-gitgutter' " Show which lines have been edited from git working version
    Plug 'vim-scripts/tinymode.vim' " Allows for repetitve shortcuts w/o typing prefix key, e.g. ^W++- instead of ^W+^W+^W-
    Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' } " Tracks undo history like a git tree
    Plug 'vim-scripts/BufOnly.vim' " Close all buffers except open
    Plug 'airblade/vim-rooter' " Sets the pwd to git root
    Plug 'teranex/jk-jumps.vim' " Adds a 'jump' when using, eg, 10j to move, useful for c+o/c+i navigation
    Plug 'mike-hearn/vim-buffer-history' " Keeps track of buffer history
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  } " Installs fzf if not already installed
    Plug 'junegunn/fzf.vim' " My favorite fuzzy search
    Plug 'tpope/vim-obsession' " Remember vim session state
    Plug 'christoomey/vim-tmux-navigator', { 'branch': 'indicator' } " Treats vim splits as tmux panes, allowing same shortcuts
    Plug 'jiangmiao/auto-pairs' " Completes the pair for ( and { and [ etc
    Plug 'tmux-plugins/vim-tmux-focus-events' " For auto-reloading on focus
    Plug 'mattn/emmet-vim' " Shortcuts to quickly scaffold html
    Plug 'Chiel92/vim-autoformat' " Integrate yapf & other autoformatters
    Plug 'fisadev/vim-isort', { 'on': ['Isort'] } " Autosort python imports
    Plug 'SirVer/ultisnips' " My custom snippets for code reuse
    Plug 'honza/vim-snippets' " Community custom snippets
    Plug 'tpope/vim-surround' " Shortcuts to modify characters/code around an object, eg add quotes on a string
    Plug 'majutsushi/tagbar' " Shows tags in sidebar
    Plug 'junegunn/rainbow_parentheses.vim' " Colors matching parentheses for easier parsing
    Plug 'editorconfig/editorconfig-vim' " Imports editorconfig file
    Plug 'junegunn/vim-slash' " Un-highlights text if you navigate away from word
    Plug 'tpope/vim-sleuth' " Basically triggers :noh once you move your cursor off a highlighted word
    Plug 'junegunn/vim-peekaboo' " Peek into vim registers
    Plug 'Yggdroot/indentLine'   " Adds vertical line to clearly show indent levels
    Plug 'tpope/vim-tbone'  " Adds tmux commands to vim, specifically copying into tmux clipboard

    " Completion
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-tmux'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-tagprefix'
    Plug 'ncm2/ncm2-ultisnips'
    Plug 'mhartington/nvim-typescript', {
                \ 'do': './install.sh',
                \ 'for': ['typescript', 'javascript', 'javascript.jsx']}
    Plug 'ncm2/ncm2-jedi', {'for': ['python']}
    Plug 'ncm2/ncm2-cssomni', {'for': ['css', 'scss', 'sass']}
    Plug 'ncm2/ncm2-go', {'for': ['go']}
    Plug 'ncm2/ncm2-vim', {'for': ['vim']}
    Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }

    call plug#end()

" }}}

" {{{ Plugin Settings ·························································

" {{{ Ale
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '·'

" ALELint settings
let g:ale_linters = {
            \   'go': ['go build'],
            \   'css': ['stylelint'],
            \   'scss': ['stylelint'],
            \}

" ALEFix settings
let g:ale_fixers = {
            \   'javascript': ['eslint', 'prettier'],
            \   'html': ['tidy'],
            \   'css': ['stylelint', 'prettier'],
            \   'scss': ['stylelint', 'prettier', 'remove_trailing_lines'],
            \   'python': ['isort', 'black'],
            \}

let g:ale_python_black_options = '--line-length=80'

let g:jsx_ext_required = 0
" }}}
" {{{ BufTabLine
map π :call AutoPairsToggle()<CR>
let g:buftabline_numbers = 2
let g:buftabline_indicators = 1
let g:buftabline_separators = 1
hi! link BufTabLineCurrent LightlineLeft_normal_0
hi! link BufTabLineActive TabLineSel

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

hi ALEError cterm=underline ctermfg=red
hi ALEErrorSign ctermbg=18 ctermfg=1
hi ALEWarning cterm=underline ctermfg=yellow
hi ALEWarningSign ctermbg=18 ctermfg=3
hi ColorColumn ctermbg=18
hi CursorLine ctermbg=18
hi CursorLineNr ctermbg=18
hi DiffAdd ctermbg=0
hi DiffChange ctermbg=0
hi DiffDelete ctermbg=0
hi DiffText ctermbg=0
hi FoldColumn ctermbg=18
hi Folded ctermbg=18 ctermfg=21
hi GitGutterAdd ctermbg=18
hi GitGutterChange ctermbg=18
hi GitGutterChangeDelete ctermbg=18
hi GitGutterDelete ctermbg=18
hi LineNr ctermbg=18
hi Pmenu ctermbg=18
hi PmenuSel ctermfg=0 ctermbg=7
hi QuickFixLine ctermbg=19
hi StatusLineNC ctermbg=0
hi TabLine ctermbg=18
hi TabLineFill ctermbg=18 ctermfg=20
hi TabLineSel ctermbg=19
hi VertSplit ctermbg=NONE guibg=NONE
hi VertSplit ctermfg=20
hi Visual ctermbg=19

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" }}}
" {{{ CtrlP
" Mapping meta+p to its special character
nmap <C-p> :Files<CR>
nmap <Leader>s :Buffers<CR>
nmap <Leader>f :FilesFromVimHistory<CR>
" }}}
" {{{ EasyMotion
map s <Plug>(easymotion-s)
" }}}
" {{{ EditorConfig
let g:EditorConfig_core_mode = 'python_external'
" }}}
" {{{ fugitive.vim
nmap <leader>gs :Gstatus<cr>gg<C-n>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gw :Gwrite<cr>
nmap <leader>gr :Gread<cr>
nmap <leader>gcc :Gwrite<cr>:Gcommit<cr>I
" }}}
" {{{ fzf
let g:fzf_files_options =
            \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

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
" {{{ Indentline
let g:indentLine_color_term = 18
let g:indentLine_char = '│'
" }}}
" {{{ jedi
let g:jedi#popup_select_first = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#goto_command = "<C-]>"
let g:jedi#usages_command = ""
let g:jedi#completions_enabled = 0

command! -bang JediUsage  call jedi#usages()
command! -bang JediRename call jedi#rename()
" }}}
" {{{ lightline
let g:lightline = {
            \ 'colorscheme': csunderscores,
            \ }
" }}}
" {{{ NERDCommenter
let g:NERDSpaceDelims=1
" }}}
" {{{ NERDTree
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
" {{{ ncm2 (nvim-completion-manager)
" TODO: Do I need these? Should they go somewhere else?
set completeopt=noinsert,menuone,noselect
set shortmess+=c

autocmd TextChangedI * call ncm2#auto_trigger()
autocmd BufEnter * call ncm2#enable_for_buffer()

inoremap <c-c> <ESC>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"


" This function, paired with the below mapping, make C-n load all high priority
" (priority 9) completions before any characters are typed. The autocmd
" InsertLeave command then returns the popup back to 1 character.
let g:ncm2#complete_length=[[1,3],[7,2],[9,1]]
function! TemporarilySetPopupToZero()
    let g:ncm2#complete_length=[[1,3],[7,2],[9,0]]
    if len(getline('.')) == 0
        execute "normal \"_ddk"
        call feedkeys('o', 'n')
    else
        call feedkeys('a', 'n')
    endif
endfunction
inoremap <C-k> <esc>:call TemporarilySetPopupToZero()<CR>
autocmd InsertLeave * let g:ncm2#complete_length=[[1,3],[7,2],[9,1]]
" }}}
" {{{ nvim-language-client
let g:LanguageClient_serverCommands = {
    \ 'handlebars': ['html-languageserver', '--stdio'],
    \ 'html': ['html-languageserver', '--stdio'],
    \ 'html.handlebars': ['html-languageserver', '--stdio'],
    \ 'scss': ['css-languageserver', '--stdio'],
    \ 'sass': ['css-languageserver', '--stdio'],
    \ 'css': ['css-languageserver', '--stdio'],
    \ 'python': ['pyls'],
    \ }
" }}}
" {{{ nvim-typescript
let g:nvim_typescript#javascript_support = 1
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
let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
nnoremap <Leader>U :UltiSnipsEdit<CR>
" }}}
" {{{ vim-black
let g:black_linelength = 79
" }}}
" {{{ vim-commentary
nnoremap <silent> <leader>c<space> :Commentary<CR>
vnoremap <silent> <leader>c<space> :Commentary<CR>
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

" Filetype/Autoload Settings {{{ ··············································

" {{{ General file settings

" Write filename to history file on open/read
autocmd BufReadPost * call WriteFileToHistory()

" When switching buffers, preserve window view.
autocmd BufLeave * call AutoSaveWinView()
autocmd BufEnter * call AutoRestoreWinView()

" }}}
" {{{ CSS/SCSS

autocmd FileType css,css setlocal foldmethod=syntax

" }}}
" {{{ Go
autocmd FileType go setlocal foldmethod=syntax
" }}}
" {{{ HTML/Handlebars/Mustache
autocmd FileType handlebars,html,html.handlebars setlocal foldmethod=indent
autocmd FileType handlebars,html,html.handlebars imap <buffer> <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" }}}
" {{{ Javascript/JSX
autocmd FileType html.handlebars setlocal foldmethod=indent
autocmd FileType javascript,javascript.jsx,json setlocal foldmethod=syntax
autocmd FileType javascript,javascript.jsx,json map <buffer> <c-]> m':TSDef<CR>
" }}}
" {{{ JSON
autocmd FileType json setlocal foldmethod=syntax
" }}}
" {{{ Python
autocmd FileType python setlocal foldmethod=expr
autocmd FileType python nnoremap <buffer> <leader>b oimport ipdb<CR>ipdb.set_trace()  # XXX BREAKPOINT<esc>k
autocmd FileType python nnoremap <buffer> <leader>B Oimport ipdb<CR>ipdb.set_trace()  # XXX BREAKPOINT<esc>j
" }}}
" {{{ sh
autocmd FileType sh setlocal foldmethod=indent
" }}}
" {{{ Vim
autocmd FileType vim setlocal shiftwidth=4
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim map <buffer> [[ ?{{{<CR>:noh<CR>
autocmd FileType vim map <buffer> ]] ?}}}<CR>:noh<CR>
" }}}
" {{{ YAML
autocmd FileType yaml setlocal foldmethod=indent
" }}}

" }}}

" vim: foldmethod=marker: foldlevel=0
