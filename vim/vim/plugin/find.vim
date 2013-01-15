" Find file in current directory and edit it.

"let g:find_excl_path = ['./build', './test', './.git', '.*/Zend', './.sass-cache']
"let g:find_excl_path = []
let g:find_excl_files = ['*.swp', '*~', '*.pyc', '*.so', '*.gif', '*.png']
let g:find_path = '~/workspace/'

function! Find(...)

    let l:expaths = exists('g:find_excl_path') ? " \\( -path " . join(g:find_excl_path, " -o -path ")." \\) -prune -o" : ''
    let l:exfiles = exists('g:find_excl_files')? " -not \\( -iname '".join(g:find_excl_files, "' -o -iname '")."'  \\) " : ''

    "let path=exists('g:find_path') ? g:find_path : "."
    let path="."

    if a:0==0
        echohl WarningMsg | 
        \ echomsg 'Find needs string fragment to look for!' | 
        \ echohl None
        return
    endif

    if a:0==2
      let path=a:2
    endif

    let l:pattern = substitute(a:1,"^\\s\\+\\|\\s\\+$","","g") 

    if strlen(l:pattern)==0
        echohl WarningMsg | 
        \ echomsg 'Find needs string fragment to look for!' | 
        \ echohl None
        return
    endif
	
    let l:cmd="find ".path." ".l:expaths." ".l:exfiles." -iname '*".l:pattern."*' -print | sort "

    echohl WarningMsg | 
    \ echomsg "Searching for ".l:pattern."" |
    \ echohl None

    let l:list=system(l:cmd)
    let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
    
    if l:num < 1
          echohl WarningMsg | 
          \ echomsg "'".a:1."' not found" |
          \ echohl None
      return
    endif

    echohl WarningMsg | 
    \ echomsg 'Searching for "' . a:1 . '" in ' . l:num .' matches.' |
    \ echohl None
	
    if l:num == 1
      exe "open " . substitute(l:list, "\n", "", "g")
    else

		let tmpfile = tempname()
		exe "redir! > " . tmpfile
		silent echon l:list
		redir END
		let old_efm = &efm
		set efm=%f

		if exists(":lgetfile")
			execute "silent! lgetfile " . tmpfile
		else
			execute "silent! lfile " . tmpfile
		endif

		let &efm = old_efm

		" Open the quickfix window below the current window
		botright lopen

		call delete(tmpfile)
	endif
endfunction


command! -nargs=* Find :call Find(<f-args>)
command! -nargs=* F :call Find(<f-args>)
command! -nargs=* Tafs :tabe | :call Find(<f-args>)
command! -nargs=* T :tabe | :call Find(<f-args>)


let g:grope_include = ['*.py', '*.cpp', '*.h', '*.hpp', '*.php','*.js','*.css','*.html','*.scss']
let g:grope_exclude = ['*test*.php', '*.pyc', '*.so', '*.gif', '*.png', '*.jpg']
let g:grope_exclude_dir = ['build', 'test', '\.git']
let g:grope_default_flags = '-rinHn -m 1'
function! Grope(...)

    let l:include_files = exists('g:grope_include') ? ' --include="'.join(g:grope_include, '" --include="').'"' : ''
    let l:exclude_files = exists('g:grope_exclude') ? ' --exclude="'.join(g:grope_exclude, '" --exclude="').'"' : ''
    let l:exclude_dirs  = exists('g:grope_exclude_dir') ? ' --exclude-dir="'.join(g:grope_exclude_dir, '" --exclude-dir="').'"' : ''

    let path="."

    if a:0==0
        echohl WarningMsg | 
        \ echomsg 'Find needs string fragment to look for!' | 
        \ echohl None
        return
    endif

    if a:0==2
      let path=a:2
    endif

    let l:pattern = substitute(a:1,"^\\s\\+\\|\\s\\+$","","g") 

    let cmd_string = "grep ".l:pattern." ".path." ".l:include_files." ".l:exclude_files." ".l:exclude_dirs." ".g:grope_default_flags." | sort"
"    echomsg cmd_string
    let cmd_output=system(cmd_string)

    if cmd_output == ""
        echohl WarningMsg | 
        \ echomsg "Error: Pattern " . a:1 . " not found" | 
        \ echohl None
        return
    endif

    let tmpfile = tempname()

    let old_verbose = &verbose
    set verbose&vim

    exe "redir! > " . tmpfile
    silent echon '[Search results for pattern: ' . a:1 . "]\n"
    silent echon substitute(cmd_output, "", "", "g")
    redir END

    let &verbose = old_verbose

    let old_efm = &efm
    set efm=%f:%\\s%#%l:%m


    if exists(":lgetfile")
        execute "silent! lgetfile " . tmpfile
    else
        execute "silent! lfile " . tmpfile
    endif

    let &efm = old_efm

    " Open the quickfix window below the current window
    botright lopen

    call delete(tmpfile)
endfunction

command! -nargs=* Grope :call Grope(<f-args>)
command! -nargs=* G :call Grope(<f-args>)

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

function! RunFind(...)
  let l:pat = input("Enter file: ")

  if(empty(l:pat)) | return | endif 
  
  if a:0==1
    exec(a:1)
  endif
  
  call Find(l:pat)
endfunction

function! RunGrope()
  let l:pat = input("Enter pattern: ")

  if(empty(l:pat)) | return | endif 

  call Grope(l:pat)
endfunction

nmap <silent> <leader>l :call ToggleLoc()<CR>
nmap <silent> <leader>t :call RunFind('tabe')<CR> 
nmap <silent> <leader>v :call RunFind('vs')<CR> 
nmap <silent> <leader>f :call RunFind()<CR> 
nmap <silent> <leader>g :call RunGrope()<CR> 
