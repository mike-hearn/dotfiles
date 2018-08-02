let g:jedi#popup_select_first = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#goto_command = "<C-]>"
let g:jedi#usages_command = ""
let g:jedi#completions_enabled = 0

command! -bang JediUsage  call jedi#usages()
command! -bang JediRename call jedi#rename()
