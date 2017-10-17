" Settings {{{

    set hidden                      " Allows changing buffers w/o outright closing them
    set autoindent                  " Copy the indentation from the previous line
    set relativenumber number       " Show line numbers, make 'em relative to the current line
    set tw=79                       " Width of document (used by gd)
    set nowrap                      " Don't automatically wrap on load
    set fo-=t                       " Don't wrap at 80 characters when typing
    set colorcolumn=80              " Visually mark col 80
    set undofile                    " Undo history maintained across sessions
    set undolevels=1000             " Save last 1000 changes"
    set undoreload=10000            " Load last 10,000 changes?
    set undodir=~/.vim/tmp/undo/    " Dir for saving file changes
    set ignorecase                  " Ignore case when searching
    set smartcase                   " Ignore case if search pattern is lowercase
    set showmatch                   " Highlight matching paren, brace, bracket
    set matchtime=3                 " Time in tenths of seconds to show match
    set tabstop=4                   " Specifies width of tab character
    set shiftwidth=4                " Amount of whitespace to insert
    set softtabstop=4               " Fine-tunes amount of insert whitespace
    set shiftround                  " Rounds your tabs if you're on a weird interval, like 3 spaces in, will move it to 4 (instead of 7)
    set autochdir                   " Autoset working dir to current file's dir
    set wildmenu                    " Visual autocomplete for command menu
    set spellsuggest=best,10        " Spelling
    set mouse=a                     " Mouse support in iTerm et al
    set nostartofline               " Cursor maintains position when switching buffers
    set noshowmode                  " Hides --INSERT-- because lightline handles it
	set nofoldenable

" }}}
" Directories {{{

    set backupdir=~/.vim/tmp/backup/
    set directory=~/.vim/tmp/swap/
    set backup
    set noswapfile

" }}}
" Plugins {{{
    " Load vim-plug
    call plug#begin('~/.local/share/nvim/plugged')

    " Start with sensible defaults
    Plug 'tpope/vim-sensible'

    " Themes
    Plug 'chriskempson/base16-vim'
    Plug 'mike-hearn/base16-vim-lightline'

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
    Plug 'mike-hearn/fountain.vim'
    Plug 'chr4/nginx.vim'
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'elixir-lang/vim-elixir'
    Plug 'chase/vim-ansible-yaml'
    Plug 'joukevandermaas/vim-ember-hbs'
    Plug 'evidens/vim-twig'
    Plug 'leafgarland/typescript-vim'
    Plug 'cespare/vim-toml'
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'slashmili/alchemist.vim'
    Plug 'tomlion/vim-solidity'

    " IDE & Productivity Features
    Plug 'itchyny/lightline.vim'
    Plug 'ap/vim-buftabline'
    Plug 'Lokaltog/vim-easymotion'
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tpope/vim-fugitive'    " Git management within vim
    Plug 'tpope/vim-unimpaired'  " Key bindings for vim-fugitive
    Plug 'tpope/vim-repeat'      " Repeatable events from pugins
    " Plug 'davidhalter/jedi-vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-scripts/tinymode.vim'
    Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
    Plug 'vim-scripts/BufOnly.vim' " Close all buffers except open
    Plug 'airblade/vim-rooter' " Sets the pwd to git root (and makes me hit enter a lot)
    Plug 'teranex/jk-jumps.vim' " Adds a 'jump' when using, eg, 10j to move
    Plug 'mike-hearn/vim-buffer-history' " Keeps track of buffer history
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
    Plug 'junegunn/fzf.vim'
    " Plug 'ervandew/supertab' " Tab completion super-fied
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
    Plug 'majutsushi/tagbar'
	Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'junegunn/vim-slash' " Un-highlights text if you navigate away from word
	Plug 'ludovicchabant/vim-gutentags'

    " Completion
	Plug 'roxma/nvim-completion-manager'

    call plug#end()
" }}}
" Colorscheme {{{

    syntax enable
    set background=dark
    colorscheme $COLORSCHEMEVIM

    " base16 overrides
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
    hi QuickFixLine ctermbg=19
    hi StatusLineNC ctermbg=0
    hi TabLine ctermbg=18
    hi TabLineFill ctermbg=18 ctermfg=20
    hi TabLineSel ctermbg=19
    hi VertSplit ctermfg=20
    hi Visual ctermbg=19

    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" }}}
" {{{ Functions

    source ~/.config/nvim/functions.vim

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

    " When switching buffers, preserve window view.
    if v:version >= 700
        autocmd BufLeave * call AutoSaveWinView()
        autocmd BufEnter * call AutoRestoreWinView()
    endif

" }}}
" Mappings {{{
    let g:mapleader = ","

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

    " Get to console easier
    nnoremap ; :

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
    vnoremap <leader>za :call FoldAroundSelection()<CR>
    nnoremap z0 :call RemoveAllFoldsAndResetFoldmethod()<CR>
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
    nnoremap <leader>V zzmt:vsp %<CR>'tzz

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
" Plugin Settings {{{

    " Ale ---------------------------------------------------------------------
    highlight ALEErrorSign ctermbg=Red ctermfg=18
    highlight ALEWarningSign ctermbg=Yellow ctermfg=18

    let g:ale_sign_error = 'x'
    let g:ale_sign_warning = '?'

	let g:ale_linters = {
	\   'go': ['go build'],
	\}

	" Buftabline --------------------------------------------------------------
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

    " CtrlP -------------------------------------------------------------------
    nmap <C-p> :Files<CR>
    nmap <Leader>s :Buffers<CR>
    nmap <Leader>f :FilesFromVimHistory<CR>

    " Editorconfig ------------------------------------------------------------
    let g:EditorConfig_core_mode = 'python_external'

    " FZF ---------------------------------------------------------------------
    let g:fzf_files_options =
        \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

    autocmd VimEnter * command! -bang -nargs=* Ag
        \ call fzf#vim#grep(
        \   'rg --smart-case --column --hidden --max-columns=500  --glob=\!".git" --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
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

    " Easymotion --------------------------------------------------------------
    map s <Plug>(easymotion-s)

    " gitgutter ---------------------------------------------------------------
    let g:gitgutter_max_signs = 1500

	" gutentags ---------------------------------------------------------------
	let g:gutentags_cache_dir = '.git'

    " jedi-vim ----------------------------------------------------------------
    let g:jedi#usages_command = "<leader>z"
    let g:jedi#popup_on_dot = 0
    let g:jedi#popup_select_first = 0
    let g:jedi#use_tabs_not_buffers = 0
    map <Leader>b oimport ipdb<CR>ipdb.set_trace()  # BREAKPOINT<C-c>
    map <Leader>B Oimport ipdb<CR>ipdb.set_trace()  # BREAKPOINT<C-c>

	" Lightline ---------------------------------------------------------------
    let g:lightline = {
      \ 'colorscheme': $COLORSCHEMELIGHTLINE,
      \ }

    " NERDCommenter -----------------------------------------------------------
    let g:NERDSpaceDelims=1

    " NERDTree ----------------------------------------------------------------
    let NERDTreeIgnore = ['node_modules']

    " python-mode -------------------------------------------------------------
    let g:pymode_warnings = 0
    let g:pymode_lint = 0
    let g:pymode_rope = 0
    let g:pymode_motion = 0

	" Rainbow Parentheses -----------------------------------------------------
	let g:rainbow_active = 0

    " tinymode.vim - Buffer mappings ------------------------------------------
    call tinymode#EnterMap("bufferchange", "<Leader>m", "m")
    call tinymode#EnterMap("bufferchange", "<Leader>n", "n")
    call tinymode#Map("bufferchange", "m", "bn")
    call tinymode#Map("bufferchange", "n", "bp")

    " tinymode.vim - Tab mappings ---------------------------------------------
    call tinymode#EnterMap("tabchange", "<Leader>M", "M")
    call tinymode#EnterMap("tabchange", "<Leader>N", "N")
    call tinymode#EnterMap("tabchange", "<M", "M")
    call tinymode#EnterMap("tabchange", "<N", "N")
    call tinymode#Map("tabchange", "M", "tabnext")
    call tinymode#Map("tabchange", "N", "tabprevious")

    " tinymode.vimm - Window size mappings ------------------------------------
    call tinymode#EnterMap("winsize", "<C-W>+", "+")
    call tinymode#EnterMap("winsize", "<C-W>-", "-")
    call tinymode#Map("winsize", "+", "3wincmd +")
    call tinymode#Map("winsize", "-", "3wincmd -")
    call tinymode#EnterMap("winsize", "<C-W>>", ">")
    call tinymode#EnterMap("winsize", "<C-W><", "<")
    call tinymode#Map("winsize", ">", "3wincmd >")
    call tinymode#Map("winsize", "<", "3wincmd <")

    " vim-rooter --------------------------------------------------------------
    let g:rooter_silent_chdir = 1

    " vim-tmux-navigator ------------------------------------------------------
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

    " Ultisnips.vim -----------------------------------------------------------
	let g:UltiSnipsExpandTrigger="<c-t>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    nnoremap <Leader>U :UltiSnipsEdit<CR>

" }}}
" Filetype/Autoload Settings {{{

    " Write filename to history file on open/read
    autocmd BufReadPost * call WriteFileToHistory()

    " Bash/sh
    let g:is_posix = 1

    " Foldmethods
    autocmd FileType json setlocal foldmethod=syntax
    autocmd Filetype python setlocal foldmethod=expr foldlevel=4
    autocmd Filetype html setlocal foldmethod=indent
    autocmd Filetype scss setlocal foldmethod=indent foldlevel=4
    autocmd Filetype handlebars setlocal foldmethod=indent foldlevel=20
    autocmd Filetype javascript setlocal foldmethod=syntax foldlevel=4
    autocmd Filetype javascript.jsx setlocal foldmethod=syntax foldlevel=4

" }}}
" {{{ Finishing Touches

    set fillchars+=vert:│           " Sleeker split character between panes
    hi VertSplit ctermbg=NONE guibg=NONE

" }}}


set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" vim: foldmethod=marker: foldlevel=0
