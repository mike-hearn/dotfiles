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
