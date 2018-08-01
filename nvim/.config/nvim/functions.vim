" User functions file for Neovim

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
