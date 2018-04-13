if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Centralize backups, swapfiles and undo history
if !isdirectory($HOME."/.vim/backups")
    call mkdir($HOME."/.vim/backups", "p")
endif
set backupdir=~/.vim/backups
if !isdirectory($HOME."/.vim/swaps")
    call mkdir($HOME."/.vim/swaps", "p")
endif
set directory=~/.vim/swaps
if exists("&undodir")
  if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p")
  endif
  set undodir=~/.vim/undo
endif
" Disable filetype for proper plugin loading
filetype off 
" Add plugins
call plug#begin('~/.vim/plugged')
  Plug 'mattn/emmet-vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'Shougo/deoplete.nvim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'Shougo/neosnippet.vim'
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'rakr/vim-one'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'w0rp/ale'
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-surround'
call plug#end()
" Enable filetype
filetype plugin indent on
" Colors
if (has("termguicolors"))
 set termguicolors
endif
set background=dark
colorscheme one
" Performance boost
set lazyredraw
" Esc delay gone
set timeoutlen=1000 ttimeoutlen=0
" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildchar=<Tab> wildmenu wildmode=full
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Don’t add empty newlines at the end of files
set binary
set noeol
" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*
" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set relativenumber
set number
set numberwidth=1
" Enable syntax highlighting
syntax on
" Make tabs as wide as two spaces
set tabstop=2
set shiftwidth=2
set expandtab
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noeb vb t_vb=
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Only blink cursor on insert
set guicursor+=n-v-c:blinkon0
let &t_SI.="\e[5 q"
let &t_EI.="\e[0 q"
" Allow hidden buffers
set hidden
" Disable signbar
set signcolumn=no
" Autocompletion settings
let g:deoplete#sources#ternjs#include_keywords = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#auto_completion_start_length = 1
let g:tern_show_signature_in_pum = 1
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" Linting and formatting
let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_fixers = {'javascript': ['prettier'], 'json': ['prettier'], 'css': ['prettier'], 'markdown': ['prettier'], 'typescript': ['prettier']}
let g:ale_linters = {'javascript': ['eslint'], 'typescript': ['eslint']}
let g:ale_fix_on_save = 1
" Netrw settings
let g:netrw_liststyle=0
let g:netrw_banner=0
let g:netrw_preview=1
let g:user_emmet_leader_key='<c-z>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
" Autocommands
if has('autocmd')
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/149210
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
  autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
endif
" Key Mappings
let mapleader = "\<space>" 
" Quick command
map , <Plug>(easymotion-s)
" Escape clears highlights
nnoremap <leader><space> :let @/=""<CR>
" Buffers
nnoremap <leader>b :buffers<cr>:b<space>
" Comment react
nmap <leader>c yss*yss/yss}
nmap <leader>C ds/ds}
" Delete buffer without closing window
nnoremap <leader>d :bp<cr>:bd#<cr>
" Toggle netrw
nnoremap <leader>e :call ExToggle()<cr>
" Quick format
nnoremap <leader>f :ALEFix<cr>
" Toggle spelling
nnoremap <leader>s :set spell!<cr>
" Tab through buffers
nnoremap <s-tab> :bprev <cr>
nnoremap <tab> :bnext <cr>
" Navigate lines
nnoremap j gj
nnoremap k gk
" Use magic search
noremap / /\v
vnoremap / /\v
" Snippet expansion
imap <c-k> <Plug>(neosnippet_expand_or_jump)
smap <c-k> <Plug>(neosnippet_expand_or_jump)
xmap <c-k> <Plug>(neosnippet_expand_target)
imap <expr><tab>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"

smap <expr><tab> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
" Toggle netrw
fun! ExToggle()
  let l:buf_nr = bufnr("%")
  if exists("t:ex_buf_nr")
    if (l:buf_nr == t:ex_buf_nr)
      execute "b" . t:prev_buf_nr
      execute "bd" . t:ex_buf_nr
      unlet t:prev_buf_nr
      unlet t:ex_buf_nr
      return
    endif
  endif
  let t:prev_buf_nr = l:buf_nr
  execute "Explore"
  let t:ex_buf_nr = bufnr("%")
endf