" ==================== VIM PLUG ==================

call plug#begin('~/.vim/plugged')

" Python completion
"let g:python3_host_prog = '/usr/bin/python3'

" Vim Script
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

" Search for files
Plug 'slode/vim-fast-find'
Plug 'slode/nvim-pdb'

" surround vim
"Plug 'tpope/vim-surround'

" nerd commenter
Plug 'scrooloose/nerdcommenter'

" airline (powerline)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" enhanced highlight
Plug 'octol/vim-cpp-enhanced-highlight'

" colorscheme
"Plug 'wombat256mod.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
Plug 'tpope/vim-vividchalk'
Plug 'lokaltog/vim-distinguished'
Plug 'altercation/vim-colors-solarized'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'

" auto-close (for parenthesis)
" TODO: broken, since clang_complete
"Plug 'jiangmiao/auto-pairs'

" ctrlp
" TODO: learn
" Plug 'kien/ctrlp.vim'

" glsl color
"Plug 'tikhomirov/vim-glsl'

" debugger
"Plug 'critiqjo/lldb.nvim'

call plug#end()

lua << EOF
  require'treesitter-context'.setup{}
EOF

" pip install pyright "python-lsp-server[all]"
lua << EOF

  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>p', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, bufopts)
    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, bufopts)
    --vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    --vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    --vim.keymap.set('n', '<leader>wl', function()
    --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }

  require('lspconfig')['pyright'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
  }

  require("nvim-lsp-installer").setup {
    automatic_installation = true
  }

  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" ================ Suggestions ======================

" show wild menu (menu of suggestions) when typing commands in command mode
set path+=**
set wildmenu
set showcmd

set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ File management ==================

" Turn off swap files
set noswapfile
set nobackup
set nowb

" TODO: improve behaviour
" reload files changed outside vim
set autoread
" Trigger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default


" ================ Scrolling =========================

" Start scrolling when we're 8 lines away from margins
set scrolloff=8
set sidescrolloff=2
set sidescroll=1
set ruler

" Don’t reset cursor to start of line when moving around.
set nostartofline

" ================ Encoding =========================

"set encoding to utf8
if &encoding != 'utf-8'
    set encoding=utf-8              "Necessary to show Unicode glyphs
endif


" ================ Keyboard bindings ================

" noremap - no recursive mapping

" set the leader key to comma
let mapleader = ','

" stay in normal mode after inserting a new line
"noremap o o <Bs><Esc>
"noremap O O <Bs><Esc>

" mapping that opens .vimrc in a split for quick editing
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
" mapping that sources the vimrc in the current file
nnoremap <leader>sv :source $MYVIMRC<CR>

" Mapping U to Redo.
"noremap U <c-r>
"noremap <c-r> <NOP>

" ################ LSP/TROUBLE ######################

nnoremap <leader>x <cmd>TroubleToggle<cr>
nnoremap <leader>w <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>d <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>q <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>l <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" ================ Visualization ====================

syntax on
set background=dark
colorscheme solarized

" enable 256bit colors - also: override gnome-terminal's settings
set t_Co=256


" ================ Indentation ======================

set autoindent
set nosmartindent
set shiftwidth=2
set tabstop=2
set smarttab
set expandtab
filetype indent on

" ================ Number column ====================

" numbers
set number " see the line number column
set nuw=6  "Number column width

" Toggle relative numbering, and set to absolute on loss of focus or insert mode
"autocmd InsertEnter * :set nornu
"autocmd InsertLeave * :set rnu
" we don't want to see relative numbering while debugging
" debugger uses its own window, so we can disable rnu when source window loses
" focus
"autocmd BufLeave * :set nornu
"autocmd BufEnter * call SetRNU()
function! SetRNU()
    if(mode()!='i')
        set rnu
    endif
endfunction


" ================ Searching ========================

" Ignorecase when searching
set ignorecase

" incremental search - Vim starts searching when we start typing
set incsearch

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" toggle search highlighting
nnoremap <F3> :set hlsearch!<CR>

"End searches on quit
au VimEnter * nohls

" ================ Performance ======================

" fix slow scrolling that occurs when using mouse and relative numbers
set lazyredraw
" vim timeout (forgot why I need this or if I do at all)
set ttyfast
set ttimeoutlen=10

" ================ Abbreviations ====================

iab wiht with
iab whit with
iab ture true
iab flase false
iab wieght weight
iab hieght height
iab tihs this
iab mian main

" ============ File explorer  =======================

" omit banner
let g:netrw_banner = 0
" tree-style view
let g:netrw_liststyle = 3
" open files in old window
let g:netrw_browse_split = 0
" open in split
let g:netrw_altv=1

let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent sp .
    endif
endfunction

noremap <silent> <Leader>e : call ToggleNetrw()<cr>

" ================ Misc =============================

set mouse=a

set whichwrap=<,>,[,]

" Show the filename in the window titlebar
set title

" Don’t show the intro message when starting Vim
set shortmess=atI

" Always show status line
set laststatus=2

"Open new buffers in new tab, or, if already open, move to tab
set switchbuf+=usetab,newtab

" highlight matching braces
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=0

" When the last window will have a status line (2 = always)
set laststatus=2

" disable wrapping of long lines into multiple lines
set nowrap

" history
set history=1000

" on some systems the backspace does not work as expected.
" this fixes the problem
set backspace=indent,eol,start

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" to avoid hitting:
" 'press ENTER or type command to continue'
" add 'silent' keyword before the command
"

"disable preview window
set completeopt-=preview

" ================ Term ==========================

"set termguicolors

command! -nargs=* R set splitright | vs | vertical resize 50 | term <args>
command! -nargs=* L vs | vertical resize 50 | term <args>

" ================ Plugins ==========================
" split window
noremap <silent> <Leader>ef :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr> :set scb<cr>
" asterix-search with quickfix window
noremap <leader>* :cexpr []<CR> :%g/\<<C-r><C-w>\>/caddexpr expand("%") . ":" . line(".") . ":" . getline(".")<CR>:cw<CR>
" makes asterix-search not skip to the next match
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>
" makes g-asterix-search (partial) not skip to the next match
nnoremap <silent> g* :let @/=expand('<cword>') <bar> set hls <cr>
" strips trailing whitespace
noremap <silent> <leader>fs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" formats json
noremap <silent> <leader>fj :%!json_pp . <cr>

" ################ Airline ##########################
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


" ################ A ################################

 "A - switching between files

 "header / source
"nnoremap <F4> :A<CR>
"inoremap <F4> <ESC>:A<CR>a

 "file under cursor
"nnoremap <F2> :IH<CR>
"inoremap <F2> <ESC>:IH<CR>



" ############### MONKEY TERMINAL ###################
" With this function you can reuse the same terminal in neovim.
" You can toggle the terminal and also send a command to the same terminal.

let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1
let s:monkey_terminal_window_size = -1

function! MonkeyTerminalOpen()
  " Check if buffer exists, if not create a window and a buffer
  if !bufexists(s:monkey_terminal_buffer)
    " Creates a window call monkey_terminal
    new monkey_terminal
    " Moves the window to the bottom
    wincmd J
    resize 15
    let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })

     " Change the name of the buffer to "Terminal 1"
     silent file Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
     let s:monkey_terminal_buffer = bufnr('%')

    " The buffer of the terminal won't appear in the list of the buffers
    " when calling :buffers command
    set nobuflisted
    set modifiable
  else
    if !win_gotoid(s:monkey_terminal_window)
    sp
    " Moves to the window below the current one
    wincmd J   
    execute "resize " . s:monkey_terminal_window_size 
    buffer Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
    endif
  endif
endfunction

function! MonkeyTerminalToggle()
  if win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalClose()
  else
    call MonkeyTerminalOpen()
  endif
endfunction

function! MonkeyTerminalClose()
  if win_gotoid(s:monkey_terminal_window)
    let s:monkey_terminal_window_size = winheight(s:monkey_terminal_window) 
    " close the current window
    hide
  endif
endfunction

function! MonkeyTerminalExec(cmd)
  if !win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalOpen()
  endif

  " clear current input
  call jobsend(s:monkey_terminal_job_id, "clear\n")

  " run cmd
  call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
  normal! G
  wincmd p
endfunction

" With this maps you can now toggle the terminal
nnoremap <F7> :call MonkeyTerminalToggle()<cr>
tnoremap <F7> <C-\><C-n>:call MonkeyTerminalToggle()<cr>
tnoremap <leader><Esc> <C-\><c-n>

autocmd filetype c,cc,cpp nnoremap <F5> :call MonkeyTerminalExec('make ' . expand('%<') . " && ./" . expand('%<'))<CR>
autocmd filetype python nnoremap <F5> :call MonkeyTerminalExec('python3 ' . expand('%'))<CR>

let g:ffind_open = "Trouble loclist"
