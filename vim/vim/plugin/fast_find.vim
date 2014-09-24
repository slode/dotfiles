"let g:fast_find_excl_path = ['./build', './test', './.git', '.*/Zend', './.sass-cache']
"let g:fast_find_excl_path = []
let g:ffind_excl_files = ['*.swp', '*~', '*.pyc', '*.so', '*.gif', '*.png']
let g:ffind_incl_files = ['*.c', '*.hh', 'scons*', '*.py', '*.cpp', '*.h', '*.hpp', '*.php','*.js','*.css','*.html','*.scss']
let g:ffind_path = '.'

function! FFind(...)
    " Timing the search
    let l:start=reltime()

    let l:expaths = exists('g:ffind_excl_path') ? " \\( -path " . join(g:ffind_excl_path, " -o -path ")." \\) -prune -o" : ''
    let l:exfiles = exists('g:ffind_excl_files') ? " -not \\( -iname '".join(g:ffind_excl_files, "' -o -iname '")."'  \\) " : ''

    "let path=exists('g:find_path') ? g:find_path : "."
    let l:path=exists('g:ffind_path') ? g:ffind_path : '.'

    if a:0==0
        echohl WarningMsg | 
        \ echomsg 'Find needs path fragment to look for!' | 
        \ echohl None
        return
    endif

    if a:0==2
      let l:string_pattern=a:2
    endif
    
    if type(a:1) == type([])
      let l:path_pattern=" \\( -iname \"" . join(a:1, "\" -o -iname \"")."\" \\) "
    else
      let l:path_pattern = " -iname \"*" . substitute(a:1, "^\\s\\+\\|\\s\\+$","", "g") . "*\""
    endif

    if strlen(l:path_pattern)==0
        echohl WarningMsg | 
        \ echomsg 'Find needs string fragment to look for!' | 
        \ echohl None
        return
    endif

    let l:find_cmd=" find . " . l:expaths . " " . l:exfiles . " " . l:path_pattern . " -print "
    let l:xargs_cmd=executable("parallel") ? " parallel -j150% -n 1000 " : " xargs "  
    let l:grep_cmd=exists('l:string_pattern') ? " | " . l:xargs_cmd . " grep -inHn -m1 " . l:string_pattern . " \"{}\" " : ""
    let l:sort_cmd=" | sort " 
    
    let l:cmd = l:find_cmd . l:grep_cmd . l:sort_cmd

    if exists('l:string_pattern')
      echohl WarningMsg | echomsg "Searching in " . string(a:1) . " for " .  l:string_pattern . "" | echohl None
    else
      echohl WarningMsg | echomsg "Searching for " . string(a:1) . "" | echohl None
    endif

    let l:list=system(l:cmd)

    if strlen(l:list)==0
        echohl WarningMsg | 
        \ echomsg 'No hits!' | 
        \ echohl None
        return
    endif


    let tmpfile = tempname()
    exe "redir! > " . tmpfile
    silent echon l:list
    redir END

    let old_efm = &efm
    set efm=%f
    if exists('l:string_pattern')
      set efm=%f:%\\s%#%l:%m
    endif
    
    if exists(":lgetfile")
      execute "silent! lgetfile " . tmpfile
    else
      execute "silent! lfile " . tmpfile
    endif

    let &efm = old_efm

    " Open the quickfix window below the current window
    botright lopen

    call delete(tmpfile)
    let l:time=reltimestr(reltime(l:start))
    echo "Execution took " . l:time . " sec."
endfunction


function! RunFFindPattern(...)
  let l:pat = input("Enter pattern: ")

  if(empty(l:pat)) | return | endif 
  
  call FFind(g:ffind_incl_files, l:pat)
endfunction

function! RunFFindFile(...)
  let l:pat = input("Enter file: ")

  if(empty(l:pat)) | return | endif 
  
  call FFind(l:pat)
endfunction

function! RunFFindPatternInFile(...)
  let l:file = input("Enter file pattern: ")
  if(empty(l:file)) | let l:file=g:ffind_incl_files | endif 

  let l:pat = input("Enter pattern: ")
  if(empty(l:pat)) | return | endif 
  
  call FFind(l:file, l:pat)
endfunction

function! ToggleLoc()
  try
    if exists('t:loc_open') && t:loc_open == 0
      exec('botright lopen')
    else
      exec('lclose')
    endif
    let t:loc_open = exists('t:loc_open') ? !t:loc_open : 0
  catch
    echon "No location list"
  endtry
endfunction


nmap <silent> <leader>g :call RunFFindPattern()<CR> 
nmap <silent> <leader>t :call RunFFindFile()<CR> 
nmap <silent> <leader>l :call ToggleLoc()<CR>

" search for word under cursor
nnoremap <F2> :call FFind(g:ffind_incl_files, expand("<cword>"))<CR>
nnoremap <F3> :call FFind(expand("<cword>"))<CR>
command! -nargs=* FF :call FFind(g:ffind_incl_files, <f-args>)
