let base16theme = $BASE16_THEME
try
    execute "colorscheme ".base16theme
    let csunderscores = substitute(base16theme, '-', '_', 'g')
catch
    execute "colorscheme base16-".base16theme
    let csunderscores = "base16_".substitute(base16theme, '-', '_', 'g')
endtry

hi ALEError cterm=underline ctermfg=red
hi ALEErrorSign ctermbg=18 ctermfg=1
hi ALEWarning cterm=underline ctermfg=yellow
hi ALEWarningSign ctermbg=18 ctermfg=3
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
hi PmenuSel ctermfg=0 ctermbg=7
hi QuickFixLine ctermbg=19
hi StatusLineNC ctermbg=0
hi TabLine ctermbg=18
hi TabLineFill ctermbg=18 ctermfg=20
hi TabLineSel ctermbg=19
hi VertSplit ctermbg=NONE guibg=NONE
hi VertSplit ctermfg=20
hi Visual ctermbg=19

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
