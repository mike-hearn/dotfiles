let g:ale_sign_error = '✖'
let g:ale_sign_warning = '·'

" ALELint settings
let g:ale_linters = {
            \   'go': ['go build'],
            \   'css': ['stylelint'],
            \   'scss': ['stylelint'],
            \}

" ALEFix settings
let g:ale_fixers = {
            \   'javascript': ['eslint', 'prettier'],
            \   'css': ['stylelint', 'prettier'],
            \   'scss': ['stylelint', 'prettier', 'remove_trailing_lines'],
            \   'python': ['isort', 'black'],
            \}

let g:ale_python_black_options = '--line-length=80'

let g:jsx_ext_required = 0
