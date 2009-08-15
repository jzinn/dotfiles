set nocompatible " must be first

"
" Settings
"

" set autochdir
set autoindent
set autoread
" set autowriteall
set backspace=indent,eol,start
set background=dark
set browsedir=current
" set cinoptions=>5n-3f0^-2{2
set comments=b:#,:%,fb:-,n:),n:> fo=cqrt
" set completeopt=menu,longest
set noerrorbells
set expandtab
set nofoldenable " don't fold by default
set gdefault " :%s/from/to/g
set history=1000
set hidden
set hlsearch
set ignorecase
set incsearch
set infercase
set linebreak
set list " show tabs and trailing blanks
" set listchars=tab:>-,trail:·,eol:$
set listchars=tab:▷⋅,trail:·,nbsp:·
if has('mouse')
  set mouse=a
endif
set mousehide
set ruler
set scrolloff=3
set shiftround
set shiftwidth=2
set shortmess+=I
set showcmd
set showmatch
set smartcase
set smartindent
set smarttab
set softtabstop=2
" set splitright
set tabstop=2
set title
set viminfo='1000,<500,s10,h
set virtualedit=all
set wildignore=*.o,*.jpg,*.gif,*.png
set wildmenu
set wildmode=list:longest
" set wildmode=longest,list

let mapleader=","
" let g:mapleader=","

" colorscheme needs to come after 'set background=dark' and before 'syntax on'.
" otherwise, the colorscheme won't be on in terminal vim.
colorscheme vividchalk 

if &t_Co > 2 || has("gui_running")
  syntax on
endif

"
" Mappings
"

nmap <silent> <leader>n :silent :nohlsearch<CR>
" nmap <silent> <C-n> :silent :nohlsearch<CR>
nmap <silent> <leader>s :set nolist!<CR>
nnoremap <silent> <leader>d :NERDTreeToggle<cr>
nmap <silent> <leader>t :FuzzyFinderFile<CR>
" nnoremap <C-p> :FuzzyFinderFile <C-r>=fnamemodify(getcwd(), ':p')<CR><CR>
" nmap <silent> <Leader>f :FilesystemExplorer<CR>
" nmap <silent> <Leader>b :BufferExplorer<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" by default, S = cc and Y = yy
map S c$
map Y y$

" map <Up> gk
" map <Down> gj

" Buffer management
" nmap <C-h> :bp<CR>
" nmap <C-l> :bn<CR>
" "nmap <TAB> :b#<CR>
" "nmap <C-q> :bd<CR>
" nmap <C-d> :bw<CR>
" vmap <C-d> :bw<CR>

" Window movement
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" very magic
nnoremap / /\v
nnoremap ? ?\v

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

"
" Automatic commands
"

filetype plugin indent on

" vim:ts=8:sw=3:sts=8:noexpandtab:cino=>5n-3f0^-2{2

" Temporary reportbug files.
" augroup filetype
"   autocmd BufRead reportbug.* set ft=mail
"   autocmd BufRead reportbug-* set ft=mail
" augroup end

augroup myvimrc
  autocmd!

  " autocmd BufNewFile,BufRead muttng-*-\w\+,muttng\w\{6\},ae\d setf mail

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd FileType c,h setlocal ai et sw=4 ts=4 noexpandtab cindent omnifunc=ccomplete#Complete
  " no line numbers in mail
  autocmd FileType mail setlocal nonu fo=tcrqw
  autocmd FileType make setlocal noexpandtab
  autocmd FileType python setlocal noexpandtab
  " autocmd Filetype lisp,ruby,xml,html setlocal ts=8 shiftwidth=2 expandtab
  autocmd FileType text setlocal textwidth=78

  " autocmd FocusLost * wall
augroup end

"
" Commands
"

" diff buffer with the file from whence the buffer came
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif
