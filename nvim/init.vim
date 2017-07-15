" Settings {{{
    set nocompatible

    set encoding=utf-8
    set hidden
    set autoindent
    set smartindent

    set relativenumber number              " Show line numbers
    set tw=79                       " Width of document (used by gd)
    set nowrap                      " Don't automatically wrap on load
    set fo-=t                       " Don't automatically wrap text when typing
    set colorcolumn=80

    set undofile                    " Undo history maintained across sessions
    set undolevels=1000
    set undoreload=10000
    set undodir=~/.vim/tmp/undo/

    set incsearch                   " Starts searching when you type the first char
    set hlsearch                    " Highlights search terms
    set ignorecase                  " Ignore case when searching
    set smartcase                   " Ignore case if search pattern is lowercase

    set showmatch                   " Highlight matching [{()}]
    set matchtime=3

    set expandtab                   " Convert tabs to spaces
    set tabstop=4                   " Specifies width of tab character
    set shiftwidth=4                " Amount of whitespace to insert
    set softtabstop=4               " Fine-tunes amount of insert whitespace
    set shiftround

    set autochdir                   " Autoset working dir to current file's dir
    set laststatus=2
    set guifont=InputMonoNerdFont-Regular:h14
    set guioptions-=L

    set wildmenu                    " Visual autocomplete for command menu
    set spellsuggest=best,10        " Spelling
    set backspace=indent,eol,start  " Let backspace erase chars in insert mode
    set modelines=1                 " Modelines (last line of this file) work
    set mouse=a                     " Mouse support in iTerm et al

    set autoread                    " Check if buffer was modified
    set nostartofline               " Cursor maintains position when switching buffers

    " Trailing white space
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    au InsertLeave * match ExtraWhitespace /\s\+$/
" }}}
" Directories {{{
    set backupdir=~/.vim/tmp/backup/
    set directory=~/.vim/tmp/swap/
    set backup
    set noswapfile
" }}}
" Folding {{{
    set foldmethod=indent
    set foldnestmax=2
    set foldlevel=100
    nnoremap z0 :filetype detect<CR>zR
    nnoremap z) :set foldnestmax=2<CR>zA
    nnoremap z1 :set foldnestmax=2<CR>zM
    nnoremap z2 :set foldnestmax=2<CR>zMzr
    nnoremap z3 :set foldnestmax=3<CR>zMzrzr
    nnoremap z4 :set foldnestmax=4<CR>zMzrzrzr
    nnoremap z5 :set foldnestmax=5<CR>zMzrzrzrzr
    nnoremap z6 :set foldnestmax=6<CR>zMzrzrzrzrzr
    nnoremap z7 :set foldnestmax=7<CR>zMzrzrzrzrzrzr
    nnoremap z8 :set foldnestmax=8<CR>zMzrzrzrzrzrzrzr
    nnoremap z9 :set foldnestmax=9<CR>zMzrzrzrzrzrzrzrzr
" }}}
" Plugins {{{
    " Load vim-plug
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        silent !mkdir -p ~/.vim/tmp/backup
        silent !mkdir -p ~/.vim/tmp/swap
        silent !mkdir -p ~/.vim/tmp/undo
        autocmd VimEnter * PlugInstall
    endif
    call plug#begin('~/.local/share/nvim/plugged')

    " Themes
    Plug 'vim-airline/vim-airline-themes'
    Plug 'chriskempson/base16-vim'
    Plug 'tomasr/molokai'
    Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
    Plug 'joshdick/onedark.vim'
    Plug 'rakr/vim-one'

    " Syntax
    Plug 'elzr/vim-json', { 'for': 'json' }
    Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
    Plug 'pangloss/vim-javascript'
    Plug 'othree/html5.vim', { 'for': 'html' }
    Plug 'sophacles/vim-bundle-mako', { 'for': 'html' }
    Plug 'tpope/vim-haml', { 'for': 'haml' }
    Plug 'ekalinin/Dockerfile.vim'
    Plug 'toyamarinyon/vim-swift'
    Plug 'vim-scripts/mako.vim', { 'for': 'html' }
    Plug 'mxw/vim-jsx', { 'for': [ 'javascript.jsx' ]}
    Plug 'vim-scripts/fountain.vim'
    Plug 'evanmiller/nginx-vim-syntax'
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'elixir-lang/vim-elixir'
    Plug 'chase/vim-ansible-yaml'
    Plug 'joukevandermaas/vim-ember-hbs'
    Plug 'evidens/vim-twig'
    Plug 'leafgarland/typescript-vim'

    " IDE & Productivity Features
    Plug 'bling/vim-airline'
    Plug 'Lokaltog/vim-easymotion'
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-unimpaired'  " Key bindings for vim-fugitive
    Plug 'davidhalter/jedi-vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-scripts/tinymode.vim'
    Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
    Plug 'vim-scripts/BufOnly.vim' " Close all buffers except open
    Plug 'airblade/vim-rooter' " Sets the pwd to git root (and makes me hit enter a lot)
    Plug 'teranex/jk-jumps.vim' " Adds a 'jump' when using, eg, 10j to move
    Plug 'mike-hearn/vim-buffer-history' " Keeps track of buffer history
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
    Plug 'junegunn/fzf.vim'
    Plug 'ervandew/supertab' " Tab completion super-fied
    Plug 'tpope/vim-obsession' " Remember vim session state
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'jiangmiao/auto-pairs'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tmux-plugins/vim-tmux-focus-events' " For auto-reloading on focus
    Plug 'mattn/emmet-vim'
    Plug 'Chiel92/vim-autoformat' " Integrate yapf & other autoformatters
    Plug 'fisadev/vim-isort' " Autosort python imports
    Plug 'python-mode/python-mode' " Better vim python handling
    Plug 'nathanaelkane/vim-indent-guides' " Show indent guides
    Plug 'w0rp/ale'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'tpope/vim-surround'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'luochen1990/rainbow'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'romainl/vim-cool' " Un-highlights text if you navigate away from word

    " Completion
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'carlitux/deoplete-ternjs'
    Plug 'zchee/deoplete-jedi'
    Plug 'slashmili/alchemist.vim'
    Plug 'zchee/deoplete-go'



    call plug#end()
" }}}
" Mappings {{{
    let g:mapleader = ","

    " Easy escaping
    inoremap jj <ESC>
    inoremap kj <ESC>
    inoremap jk <ESC>

    " Sane regex
    nnoremap / /\v
    vnoremap / /\v

    " Sensible traversal using j/k
    nnoremap j gj
    nnoremap k gk

    " Easier jumping to beginning & end
    noremap H ^
    noremap L g_

    " Get to console easier
    nnoremap ; :

    " Quick delete entire line
    nnoremap D 0C<Esc>

    " Global copy/paste
    vmap <leader>y :w! /tmp/vitmp<CR>
    nmap <leader>p :r! cat /tmp/vitmp<CR>

    " Buffer management; for additiona mappings, see tinymode PluginSettings()
    noremap <Leader>a <C-^>
    noremap <C-Tab> <C-^>
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

    " Window switching
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Toggle NERDTree
    map <D-\> :NERDTreeToggle<CR>
    map <C-\> :NERDTreeToggle<CR>
    nnoremap <Leader>F :NERDTreeFind<CR>

    " Center paragraph jumps
    nmap { {zz
    nmap } }zz

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

    " Toggle between standard and relative line numbers
    function! NumberToggle()
        if(&relativenumber == 1)
            set norelativenumber
            set number
        else
            set relativenumber
        endif
    endfunc
    nnoremap <C-n> :call NumberToggle()<cr>

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
" }}}
" Plugin Settings {{{
    " Airline Settings
    let g:airline_powerline_fonts = 1
    let g:airline_extensions = ['tabline', 'whitespace']
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9

    " CtrlP
    nmap <C-p> :Files<CR>
    nmap <Leader>s :Buffers<CR>
    nmap <Leader>f :History<CR>

    " Deoplete
    let g:deoplete#enable_at_startup = 1

    " FZF
    let g:fzf_files_options =
        \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

    autocmd VimEnter * command! -bang -nargs=* Ag
        \ call fzf#vim#grep(
        \   'rg --column --hidden --max-columns=500 --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0
        \)

    " NERDTree
    let NERDTreeIgnore = ['node_modules']

    " jedi-vim
    let g:jedi#usages_command = "<leader>z"
    let g:jedi#popup_on_dot = 0
    let g:jedi#popup_select_first = 0
    let g:jedi#use_tabs_not_buffers = 0
    map <Leader>b oimport ipdb<CR>ipdb.set_trace()  # BREAKPOINT<C-c>
    map <Leader>B Oimport ipdb<CR>ipdb.set_trace()  # BREAKPOINT<C-c>

    " Easymotion
    map s <Plug>(easymotion-s)

    " vim-gitgutter
    let g:gitgutter_max_signs = 1500

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

    " NERDCommenter
    let g:NERDSpaceDelims=1

    " python-mode
    let g:pymode_warnings = 0
    let g:pymode_lint = 0
    let g:pymode_rope = 0

    " vim-rooter
    let g:rooter_silent_chdir = 1

    " vim-tmux-navigator
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

    " Ultisnips.vim
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    nnoremap <Leader>U :UltiSnipsEdit<CR>

" }}}
" Filetype Settings {{{
    filetype indent on

    autocmd FileType json setlocal ts=2 foldnestmax=5
    autocmd Filetype python setlocal foldnestmax=2 ts=4 sts=4 sw=4
    autocmd Filetype html setlocal ts=2 sts=2 sw=2 foldnestmax=5
    autocmd Filetype handlebars setlocal ts=2 sts=2 sw=2 foldnestmax=5
    autocmd Filetype css setlocal ts=2 sts=2 sw=2
    autocmd Filetype scss setlocal ts=2 sts=2 sw=2
    autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 foldnestmax=15 foldmethod=syntax
    " autocmd Filetype javascript.jsx setlocal ts=2 sts=2 sw=2

    " Bash will properly handle $
    autocmd Filetype sh,bash set ts=4 sts=4 sw=4 expandtab
    let g:is_posix = 1

    au BufNewFile,BufRead *.md setf markdown
    au BufNewFile,BufRead *.fountain setf fountain

    au FocusGained * checktime
" }}}
" Colorscheme {{{
    syntax enable
    set background=dark
    colorscheme base16-oceanicnext
    let g:airline_theme="base16"
    filetype plugin indent on

" }}}

" let g:rainbow_active = 1

highlight clear ALEErrorSign
highlight clear ALEWarningSign

set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE

if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif


" call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])
vnoremap // y/<C-R>"<CR>


" vim: foldmethod=marker: foldlevel=0
