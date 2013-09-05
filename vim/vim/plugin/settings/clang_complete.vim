"========================================
"	  clang_complete settings
"========================================

let g:clang_snippets = 1
"let g:clang_snippets_engine = 'snipmate'
let g:clang_snippets_engine = 'clang_complete'
" Complete options (disable preview scratch window)

"set completeopt = menu,menuone,longest
" Limit popup menu height
"set pumheight = 15

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto = 0

" Show clang errors in the quickfix window
let g:clang_complete_copen = 1
