Learn Vimscript The Hard Way
============================

<!-- vim-markdown-toc GFM -->

1. [Echoing Messages](#echoing-messages)
1. [Setting options](#setting-options)
1. [Mapping](#mapping)
    1. [Basic Mapping](#basic-mapping)
    1. [Special Characters](#special-characters)
    1. [Modal Mapping](#modal-mapping)
    1. [Strict Mapping](#strict-mapping)
    1. [Special Arguments](#special-arguments)
    1. [leader and local leader](#leader-and-local-leader)
    1. [abbreviations](#abbreviations)
    1. [Check Mapping](#check-mapping)
1. [Autocommands](#autocommands)
    1. [Autocommand Structure](#autocommand-structure)
    1. [Autocommand Groups](#autocommand-groups)
    1. [Clearing Groups](#clearing-groups)
    1. [Filetype Events](#filetype-events)
1. [Normal And Execute](#normal-and-execute)
1. [Status Lines](#status-lines)
    1. [Basic Commands](#basic-commands)
    1. [Width And Padding](#width-and-padding)
    1. [General Format](#general-format)
    1. [Splitting](#splitting)
1. [Variables](#variables)
1. [Motions](#motions)

<!-- vim-markdown-toc -->
Echoing Messages
----------------

`echo "hello world"`

Persistent Echoing:

`echom "hello again, world!"`

Using :`echom` will save the output and let you run `:messages` to view it later.

Setting options
---------------
Setting Options
```vim
:set <name>
:set no<name>
:set <name>! "toggling
:set <name>=value
:set <name1> <name2>=value
```
Checking Options
```vim
:set <name>
:set <name>?
```
Mapping
-------
### Basic Mapping
```vim
:map- x
```

### Special Characters
```vim
:map <space> viw
:map <c-d> dd
```
How to solve the commenting problem?
```vim
:map <space> viw " Select word
```

### Modal Mapping
You can be more specific about when you want mappings to apply by using `nmap`, `vmap`, and `imap`. These tell Vim to only use the mapping in normal, visual, or insert mode respectively.
```vim
:imap <c-d> <esc>ddi
```
### Strict Mapping
```vim
:nmap - dd
:nmap \ -
:nunmap -
:nunmap \
:nmap dd O<esc>jddk    " recursion
:nunmap dd

:nmap x dd
:nnoremap \ x          " nonrecursive mapping
```
### Special Arguments
If the first argument to one of these commands is buffer the mapping will
be effective in the current buffer only.  Example: >

	:map <buffer>  ,w  /[.,;]<CR>
### leader and local leader
```vim
:let mapleader = ","
" prefix for mappings that only take effect for certain types of files, like python files or html files.
:let maplocalleader="\\"
```
### abbreviations
```vim
:iabbrev adn and
```
### Check Mapping
```vim
:map
:map <F5>
:verbose map <F5>
:unmap <key>
```
Autocommands
------------

### Autocommand Structure

    :autocmd BufNewFile,BufRead *.html setlocal nowrap

    :autocmd BufNewFile * :write
             ^          ^ ^
             |          | |
             |          | The command to run.
             |          |
             |          A "pattern" to filter the event.
             |
             The "event" to watch for.
### Autocommand Groups

    :augroup testgroup
    :    autocmd BufWrite * :echom "Foo"
    :    autocmd BufWrite * :echom "Bar"
    :augroup END

When you use augroup multiple times Vim will combine the groups each time.

### Clearing Groups

If you want to clear a group you can use `autocmd!` inside the group.

    :augroup testgroup
    :    autocmd!
    :    autocmd BufWrite * :echom "Cats"
    :augroup END
When the [group] argument is not given, Vim uses the current group (as defined
with ":augroup"); otherwise, Vim uses the group defined with [group].
### Filetype Events

    :autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
    :autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>
Normal And Execute
------------------

    :onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
Status Lines
------------
### Basic Commands
    :set statusline=%f\ -\ FileType:\ %y
    :set statusline=%f         " path to the file
    :set statusline+=\ -\      " separator
    :set statusline+=filetype: " label
    :set statusline+=%y        " Filetype of the file

    :set statusline=%l    " current line
    :set statusline+=/    " separator
    :set statusline+=%L   " Total lines
### Width And Padding
Minimal and maximum width

    :set statusline=[%4l]
    :set statusline=%.20F

Padding direction and characters

    :set statusline=Current:\ %4l\ Total:\ %4L
    :set statusline=Current:\ %-4l\ Total:\ %-4L
    :set statusline=%04l

### General Format
See `:help statusline`

    %-0{minwid}.{maxwid}{item}
### Splitting
    :set statusline=%f         " path to the file
    :set statusline+=%=        " switch to the right side
    :set statusline+=%l        " current line
    :set statusline+=/         " separator
    :set statusline+=%L        " Total lines
Variables
---------
Motions
------
The right way to use Vim is to get out of insert mode as soon as you can and use normal mode to move around.

1. **''** ,**``**

    To the position before latest jump, or where the last "m'" or "m`" command was given.


2. **g_**, **^**

    Quick moving to the none-blank beginning or end of the current line.
