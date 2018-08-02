autocmd Filetype python setlocal foldmethod=expr
autocmd Filetype python nnoremap <leader>b oimport ipdb<CR>ipdb.set_trace()  # XXX BREAKPOINT<esc>
autocmd Filetype python nnoremap <leader>B Oimport ipdb<CR>ipdb.set_trace()  # XXX BREAKPOINT<esc>
