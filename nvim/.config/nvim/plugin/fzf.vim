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
