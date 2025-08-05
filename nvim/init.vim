" ==================== VIM PLUG ==================

call plug#begin('~/.vim/plugged')

" Python completion
let g:python3_host_prog = '/home/stian/.pyenv/versions/3.12.1/envs/nvim-venv/bin/python'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Search for files
Plug 'slode/vim-fast-find'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

let g:fzf_vim = {}
let g:fzf_vim.preview_window = [] "['hidden,right,50%,<70(up,40%)', 'ctrl-/']
let g:fzf_vim.buffers_jump = 1
let g:fzf_vim.command_prefix = 'Fzf'


" QOL
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

" nerd commenter
Plug 'scrooloose/nerdcommenter'

" airline (powerline)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" colorscheme
Plug 'altercation/vim-colors-solarized'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'

Plug 'kovisoft/slimv'

call plug#end()

lua << EOF
  require('nvim-treesitter.configs').setup {
    ensure_installed = { "python", "c", "lua", "vim", "vimdoc", "query" },
  }
  require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 3, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20, -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
  }
  ---require("dap-python").setup("python3")
  require("trouble").setup {}
  require("mason").setup {}
  require("mason-lspconfig").setup {
    ensure_installed = { "pylsp" }
  }

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, bufopts)
    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, bufopts)
    --vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    --vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    --vim.keymap.set('n', '<leader>wl', function()
    --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, bufopts)
    --vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    --vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    --vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
  end

  -- Set up nvim-cmp.
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--[[
      ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          end
        end, { "i", "s" }
      ),
      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
--]]
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
--      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  require('lspconfig').pylsp.setup {
    capabilities = capabilities,
    on_attach = on_attach,
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
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | silent! checktime | endif
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

nnoremap <leader>x <cmd>Trouble toggle<cr>
nnoremap <leader>w <cmd>Trouble workspace_diagnostics toggle<cr>
nnoremap <leader>d <cmd>Trouble document_diagnostics toggle<cr>
nnoremap <leader>q <cmd>Trouble quickfix toggle<cr>
nnoremap <leader>l <cmd>Trouble loclist toggle<cr>
nnoremap <silent> gr <cmd>Trouble lsp_references toggle<cr>
nnoremap <silent> gd <cmd>Trouble lsp_definitions toggle<cr>

" ================ Visualization ====================

syntax on
set background=dark
colorscheme solarized
" disabled the new termcolors that break my colorschemes
set notermguicolors

" enable 256bit colors - also: override gnome-terminal's settings
"set t_Co=256


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
" keep netrw in history
let g:netrw_keepj=""

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

"set iskeyword=@,48-57,_,192-255,?,-,*,!,+,/,=,<,>,.,:,$

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

let g:airline#extensions#tabline#buffer_idx_mode = 1

" ################ A ################################

 "A - switching between files

 "header / source
"nnoremap <F4> :A<CR>
"inoremap <F4> <ESC>:A<CR>a

 "file under cursor
"nnoremap <F2> :IH<CR>
"inoremap <F2> <ESC>:IH<CR>



" ############### SLIMV/ROS ###################
"
let g:slimv_swank_cmd = "!ros -e '(ql:quickload :swank) (swank:create-server)' wait &"
let g:slimv_lisp = 'ros run'
let g:slimv_impl = 'sbcl'


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

nnoremap <expr> <leader>f (len(system('git rev-parse')) ? ':FzfFiles<cr>' : ':FzfGFiles<cr>')

let g:ffind_open = "Trouble loclist"
