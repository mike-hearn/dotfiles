" Initial load config {{{
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
" Settings {{{

    syntax enable

    set autochdir                   " Autoset working dir to current file's dir
    set autoindent                  " Copy the indentation from the previous line
    set background=dark
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

" }}}
" Plugins {{{
    " Load vim-plug
    call plug#begin('~/.local/share/nvim/plugged')

    " Start with sensible defaults
    Plug 'tpope/vim-sensible'

    " Themes
    let base16colorspace=256
    Plug 'chriskempson/base16-vim'
    Plug 'mike-hearn/base16-vim-lightline'

    " Languages & IDE plugins
    Plug 'sheerun/vim-polyglot'
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    Plug 'python-mode/python-mode', { 'for': 'python' }
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'jceb/vim-orgmode'
    Plug 'tpope/vim-speeddating'  " Required by orgmode
    Plug 'ternjs/tern_for_vim'

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

    " Completion
    function! BuildYCM(info)
        " info is a dictionary with 3 fields
        " - name:   name of the plugin
        " - status: 'installed', 'updated', or 'unchanged'
        " - force:  set on PlugInstall! or PlugUpdate!
        if a:info.status == 'installed' || a:info.force
            !./install.py
        endif
    endfunction

    Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }


    call plug#end()
" }}}
" Mappings {{{
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

    " Global copy/paste
    vmap <leader>y :w! /tmp/vitmp<CR>
    nmap <leader>p :r! cat /tmp/vitmp<CR>
    vmap <leader>p d:r! cat /tmp/vitmp<CR>

    " Buffer management; for additiona mappings, see tinymode PluginSettings()
    noremap <Leader>a <C-^>
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
    vnoremap <leader>za :call functions#FoldAroundSelection()<CR>
    nnoremap <silent> z0 :call functions#UnfoldAndRememberScrollPosition(0)<CR>
    nnoremap <silent> z1 :call functions#UnfoldAndRememberScrollPosition(1)<CR>
    nnoremap <silent> z2 :call functions#UnfoldAndRememberScrollPosition(2)<CR>
    nnoremap <silent> z3 :call functions#UnfoldAndRememberScrollPosition(3)<CR>
    nnoremap <silent> z4 :call functions#UnfoldAndRememberScrollPosition(4)<CR>
    nnoremap <silent> z5 :call functions#UnfoldAndRememberScrollPosition(5)<CR>
    nnoremap <silent> z6 :call functions#UnfoldAndRememberScrollPosition(6)<CR>
    nnoremap <silent> z7 :call functions#UnfoldAndRememberScrollPosition(7)<CR>
    nnoremap <silent> z8 :call functions#UnfoldAndRememberScrollPosition(8)<CR>
    nnoremap <silent> z9 :call functions#UnfoldAndRememberScrollPosition(9)<CR>

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
    nnoremap <leader>V :call functions#SplitAndMaintainPosition()<CR>
    nnoremap <leader>S :call functions#ShiftSplitAndLock()<CR>
    nnoremap <leader>D :call functions#TriShiftSplitAndLock()<CR>

    nnoremap <C-n> :call functions#NumberToggle()<cr>

    " Map <Leader>w to save, because I already do it accidentally
    nnoremap <leader>w :w<CR>
    inoremap <leader>w <Esc>:w<CR>
    nnoremap <leader>W :wa<CR>
    inoremap <leader>W <Esc>:wa<CR>

    " Git / fugitive mappings
    nmap <leader>gs :Gstatus<cr>gg<C-n>
    nmap <leader>gd :Gdiff<cr>
    nmap <leader>gw :Gwrite<cr>
    nmap <leader>gr :Gread<cr>
    nmap <leader>gcc :Gwrite<cr>:Gcommit<cr>I

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
" Filetype/Autoload Settings {{{

    " Write filename to history file on open/read
    autocmd BufReadPost * call functions#WriteFileToHistory()

    " Bash/sh
    let g:is_posix = 1

    " When switching buffers, preserve window view.
    if v:version >= 700
        autocmd BufLeave * call functions#AutoSaveWinView()
        autocmd BufEnter * call functions#AutoRestoreWinView()
    endif

" }}}

