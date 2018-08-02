" Writes current full file path to ~/.vim_history unless it is part of a
" plugin (hence the check for ///, e.g. fugitive:///...)
function! functions#WriteFileToHistory()
    if expand('%:p') !~ "\/\/\/"
        call system('touch ~/.vim_history')
        call system('echo '.shellescape(expand('%:p')).' >> ~/.vim_history')
    endif
endfunction


" Save current view settings on a per-window, per-buffer basis.
function! functions#AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction


" Restore current view settings.
function! functions#AutoRestoreWinView()
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


function! functions#FoldAroundSelection()
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


function! functions#RemoveAllFoldsAndResetFoldmethod()
    if exists("b:originalfoldmethod")
        let &foldmethod = b:originalfoldmethod
    endif
    normal zRzz
endfunction


function! functions#UnfoldAndRememberScrollPosition(foldlevel)
    " Grab initial line & curs position
    let l:originalpos = getpos('.')
    let l:originalline = l:originalpos[1]
    let l:originalcurs = l:originalpos[2]

    " Grab original winline, i.e. position from the top of the vim window
    let l:winline = winline()

    " Unfold based on foldlevel
    if a:foldlevel == 0
        :call functions#RemoveAllFoldsAndResetFoldmethod()
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

function! functions#SplitAndMaintainPosition()
    only
    let l:winview = winsaveview()
    :vsp %
    call winrestview(l:winview)
endfunc

function! functions#ShiftSplitAndLock()
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

function! functions#TriShiftSplitAndLock()
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
function! functions#NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
