[Learn Vimscript The Hard Way](https://learnvimscriptthehardway.stevelosh.com/chapters/12.html)
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
    1. [Basics](#basics)
    1. [Registers As Variables](#registers-as-variables)
    1. [Variable Scoping](#variable-scoping)
    1. [Conditionals](#conditionals)
    1. [Functions](#functions)
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
### Basics

    :let foo="bar"
    :echo foo

Options as Variables

    :echo &textwidth
    :echo &wrap

We can set options as variables using the `let`

    :let &textwidth=100
    :let &textwidth=&textwidth+10
    :set textwidth+=10

Local Options

    :let &l:number=1
    :let &l:number=0

### Registers As Variables

    :let @a="hello!"

    :echo @a

Select a word in your file and yank it with `y`, then run this command:

    :echo @"

The `"` register is the "unnamed" register, which is where text you yank
without specifying a destination will go.

Perform a search in your file with `/someword`, then run the following command:

    :echo @/

### Variable Scoping

    :let b:hello = "world"    "b   buffer variable
    :help internal-variables

### Conditionals

Multiple-Line Statements

    :echom "foo" | echom "bar"

**Basic If**

    :if 1
    :    echom "ONE"
    :endif

Vim does not necessarily treat a non-empty string as "truthy", so it will not
display anything!

    :if "something"
    :     echom "INDEED"
    :endif

Run these commands:

    :if "9024"
    :    echom "WHAT?"
    :endif

This time Vim dose display the text!
Run the following commands:

    :echom "hello"+10
    :echom "10hello"+10
    :echom "hello10"+10

**Else and Elseif**

    :if 0
    :    echom "if"
    :elseif "nope!"
    :    echom "elseif"
    :else
    :    echom "finally!"
    :endif

**Comparisons**

```vim
    :set ignorecase
    :if "foo" == "FOO"
    :    echom "no, it couldn't be"
    :elseif "foo" == "foo"
    :    echom "this must be the one"
    :endif
```

This means you can never trust the `==` comparison. Instead using this:

    case-insensitive: `==?`
    case-sensitive: `==#`

### Functions

Define A Function:

    :function Meow()
    :    echom "Meow!"
    :    return "Meow str!"
    :endfunction

Calling Functions, vim function implicitly return 0.

    :call Meow()

**varrags**

`a:` Function argument (only inside a function)

Vim can't reassign argument variables.

see :help internal-variables

    :function Varg(...)
    :  echom a:0
    :  echom a:1
    :  echom a:2
    :  echo a:000
    :endfunction

    :call Varg("a", "b")

Motions
------
The right way to use Vim is to get out of insert mode as soon as you can and use normal mode to move around.

1. **''** ,**``**

    To the position before latest jump, or where the last "m'" or "m`" command was given.


2. **g_**, **^**

    Quick moving to the none-blank beginning or end of the current line.
