" [Lightweight and sexy status bar in vim](https://dustri.org/b/lightweight-and-sexy-status-bar-in-vim.html)
" The only fancy features that it comes with are dynamic colouring of the
" current mode and indication of the paste and spellcheck status.
"    - you have to escape spaces with \
"    - everything between %{…} will be evaluated
"    - you can set colours with %#your_colour_name#
"    - everything you need to know is in :help statusline
autocmd! bufwritepost ~/.vim/statusline.vim source $MYVIMRC
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\           " buffer number
set statusline+=%#Visual#       " colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#     " colour
set statusline+=%R                        " readonly flag
set statusline+=%M                        " modified [+] flag
set statusline+=%H                        " help buffer flag
set statusline+=%W                        " preview window flag
set statusline+=%#Cursor#               " colour
set statusline+=%#CursorLine#     " colour
set statusline+=\ %t\                   " short file name
set statusline+=%=                          " right align
set statusline+=%#CursorLine#   " colour
set statusline+=\ %Y\                   " file type
set statusline+=%#CursorIM#     " colour
set statusline+=\ %3l:%-2c\         " line + column
set statusline+=%#Cursor#       " colour
set statusline+=\ %3p%%\                " percentage
