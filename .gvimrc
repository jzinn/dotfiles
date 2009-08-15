set columns=115
set lines=110

set clipboard+=unnamed
set mousehide		" Hide the mouse when typing text
set guioptions-=T       " No toolbar

if has("gui_win32")
  " no tearoff menu entries
  let &guioptions = substitute(&guioptions, "t", "", "g")
endif

" no blinking cursor
let &guicursor = &guicursor . ",a:blinkon0"

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

endif
