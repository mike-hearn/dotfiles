" User functions file for Neovim

function! FoldAroundSelection()
    if !exists("b:originafoldmethod")
        let b:originalfoldmethod = &foldmethod
        let &foldmethod = "manual"
    endif

    normal 
    normal `<k
    normal zfgg
    normal `>j
    normal zfG
    normal `<
endfunction

