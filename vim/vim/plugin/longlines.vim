" will highlight long lines
augroup vimrc_autocmds
    autocmd BufEnter * highlight OverLength ctermbg=124 guibg=#AA0000
    autocmd BufEnter * highlight SortaOverLength ctermbg=220 guibg=#FFC000
    autocmd BufEnter * match SortaOverLength /\m\%>79v.\%<91v/
    autocmd BufEnter * 2match OverLength /\m\%>90v.\%<140v/
augroup END
