" Use shellcheck for `sh` linting.

" With this variable we are able to pass extra arguments for shellcheck for
" shellcheck invocation.
"
" Optional checks should be enabled user-wide on `~/.config/shellcheckrc`.
"
" From `man 1 shellcheck`
" -a, --check-sourced
"     Emit warnings in sourced files.  Normally, shellcheck will only warn
"     about issues  in  the  specified  files.  With this option, any issues
"     in sourced files will also be reported.
" -S SEVERITY, --severity=severity
"     Specify  minimum  severity of errors to consider.  Valid values in order
"     of severity are error, warning, info and style.  The default is style.
" -x, --external-sources
"     Follow  'source'  statements  even when the file is not specified as
"     input.  By default, shellcheck will only follow files specified on the
"     command line (plus  /dev/null).   This  option  allows following any
"     file the script may source.
let g:ale_sh_shellcheck_options = '-a -S style -x'
