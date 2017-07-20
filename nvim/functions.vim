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
