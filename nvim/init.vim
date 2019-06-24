" ==================== VIM PLUG ==================

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes ''

" autocomplete - deoplete
"Plug 'Rip-Rip/clang_complete'

" SuperTab
"Plug 'ervandew/supertab'

" autocompletion (also a linter - diagnostics)
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

" UltiSnips
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


" Search for files
Plug 'slode/vim-fast-find'

" autocomplete - roxma
"Plug 'roxma/nvim-completion-manager'
"Plug 'roxma/ncm-clang'

" ale - linter / autocompletion / formatter
Plug 'w0rp/ale'

" auto formatter
Plug 'rhysd/vim-clang-format'

" nerd tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" surround vim
Plug 'tpope/vim-surround'

" nerd commenter
Plug 'scrooloose/nerdcommenter'

" airline (powerline)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" enhanced highlight
Plug 'octol/vim-cpp-enhanced-highlight'

" ctags indexer
"Plug 'vim-scripts/DfrankUtil'
"Plug 'vim-scripts/vimprj'
"Plug 'vim-scripts/indexer.tar.gz'

" easy motion
Plug 'easymotion/vim-easymotion'

" A - for switching between source and header files
Plug 'vim-scripts/a.vim'

" colorscheme
"Plug 'wombat256mod.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
Plug 'tpope/vim-vividchalk'
Plug 'lokaltog/vim-distinguished'
Plug 'altercation/vim-colors-solarized'

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

" x clipboard
" copy
noremap <leader>y "*y
" cut
noremap <leader>d "*d
" paste
noremap <leader>p "*p

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
" open a gnome-terminal with a shortcut
"noremap <leader><CR> :silent !gnome-terminal<CR>

"disable preview window
set completeopt-=preview


" ================ Term ==========================

command! -nargs=* R set splitright | vs | vertical resize 50 | term <args>

" ================ Plugins ==========================

noremap <leader>uu :%s/[-[:xdigit:]]\{36}/\=substitute(system('uuidgen'), "\n", "", "")/<CR>

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


" ################ NERDTree #########################

" shift+i (show hidden files)

" ctrl+n open/closes nerd tree
noremap <C-e> :NERDTreeToggle<CR>

" quit nerd tree on file open
let g:NERDTreeQuitOnOpen = 1

" show nerd tree always on the right instead on the left
"let g:NERDTreeWinPos = "right"


" ################ Clang complete ###################

"let g:clang_use_library = 1
"let g:clang_library_path='/usr/lib/llvm-5.0/lib/libclang.so.1'
"let g:clang_periodic_quickfix=1
"let g:clang_auto_select = 1

"let g:clang_snippets = 1
"let g:clang_snippets_engine = 'ultisnips'

" I don't know how to change the keybindings to navigate
" the 'completion suggestions menu' with ctrl+k and ctrl+l
"inoremap <C-k> <Down>
"inoremap <C-l> <Up>


" ################ YouCompleteMe ####################

let g:ycm_show_diagnostics_ui = 0

"let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
let g:SuperTabDefaulCompletionType = '<tab>'

" disable annoying ycm confirmation
let g:ycm_confirm_extra_conf = 0

" add path to ycm_extra_conf.py (you could also copy the file in the home folder)
" delete '...98' argument from .ycm_extra_conf.py, otherwise syntastic does
" not work properly
let g:ycm_global_ycm_extra_conf = '/home/stian/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

" ################ UltiSnips ########################

" make a dir Ultisnips in: '~/.config/nvim/UltiSnips/'
" and put your snippets in there
" eg. cpp.snippets

let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsUsePythonVersion = 3

" ################ Ale ##############################

" autocompletion
let g:ale_completion_enabled = 1

let g:ale_cpp_clang_executable = 'clang++-5.0'

" linter
 let g:ale_linters = {
            \   'cpp': ['clang']
            \}
let g:ale_cpp_clang_options = '-std=c++1z -O0 -Wextra -Wall -Wpedantic -I /usr/include/eigen3'
"let g:ale_cpp_clangtidy_options = '-checks="cppcoreguidelines-*"'
"let g:ale_cpp_cpplint_options = ''
"let g:ale_cpp_gcc_options = ''
"let g:ale_cpp_clangcheck_options = ''
"let g:ale_cpp_cppcheck_options = ''


" ################ Clang format #####################

" Clang format - auto formatting

let g:clang_format#command = 'clang-format-3.8'
let g:clang_format#style_options = {
            \ "BreakBeforeBraces" : "Attach",
            \ "UseTab" : "Never",
            \ "IndentWidth" : 4,
            \ "ColumnLimit" : 100,
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AllowShortFunctionsOnASingleLine" : "false",
            \}

" shortcuts for autoformatting the entire file: Ctrl+j
inoremap <C-j> <Esc>:ClangFormat<CR>a
nnoremap <C-j> <Esc>:ClangFormat<CR>


" ################ A ################################

" A - switching between files

" header / source
nnoremap <F4> :A<CR>
inoremap <F4> <ESC>:A<CR>a

" file under cursor
nnoremap <F2> :IH<CR>
inoremap <F2> <ESC>:IH<CR>


" ################ Easymotion #######################

map <leader><leader>h <Plug>(easymotion-linebackward)
map <leader><leader>j <Plug>(easymotion-j)
map <leader><leader>k <Plug>(easymotion-k)
map <leader><leader>l <Plug>(easymotion-lineforward)


" ################ CTAGS ############################

" TODO: learn more about this plugin and improve it

" change the stack pop to a more comfortable mapping
nnoremap <C-e> <C-]>

" CTAGS indexer
"let g:indexer_disableCtagsWarning = 1


" TODO: add (cmake) project support
" TODO: add debugger support

