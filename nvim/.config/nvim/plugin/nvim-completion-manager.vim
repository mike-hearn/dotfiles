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
