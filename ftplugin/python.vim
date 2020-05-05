let g:ultisnips_python_quoting_style = 'single'
let g:ultisnips_python_style = 'numpy'

let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=0
let g:SimpylFold_fold_import=0

" Ale Settings:

" Use poetry whenever possible.
let g:ale_python_auto_poetry=1
" And use dev tools installed within poetry when available.
let g:ale_python_bandit_auto_poetry=1
let g:ale_python_black_auto_poetry=1
let g:ale_python_flake8_auto_poetry=1
let g:ale_python_mypy_auto_poetry=1
let g:ale_python_prospector_auto_poetry=1
let g:ale_python_pycodestyle_auto_poetry=1
let g:ale_python_pydocstyle_auto_poetry=1
let g:ale_python_pyflakes_auto_poetry=1
let g:ale_python_pylama_auto_poetry=1
let g:ale_python_pylint_auto_poetry=1
let g:ale_python_pyls_auto_poetry=1
let g:ale_python_pyre_auto_poetry=1
