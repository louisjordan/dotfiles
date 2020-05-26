let g:ale_linters = {
\    'javascript': [ 'eslint'],
\    'react': ['eslint']
\}

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'react': ['prettier'],
\   'markdown' ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\}

let g:ale_fix_on_save = 1
