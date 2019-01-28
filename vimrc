syntax enable
colorscheme solarized
set number "show line number"
set background=dark
set nowrap "设置不折行"
set tabstop=4 "设置table长度"
set expandtab "用空格代替tab"
set softtabstop=4 "统一缩进为4，方便在开启了et后使用退格(backspace)键，每次退格将删除X个空格"
set cursorline "突出显示当前行"
set autoread "文件被改动时候自动载入"

"enable powerline"
let g:Powerline_symbols = 'fancy'

"""""""""""""""""""""
"Quickly Run
"""""""""""""""""""""
map <F5> :w<CR> :call RunPython()<CR>
function RunPython()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen
    let &makeprg = mp
    let &errorformat = ef
endfunction


""""""""""""""""""
"Vundle.vim
""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'tell-k/vim-autopep8'
Plugin 'scrooloose/nerdcommenter'
call vundle#end()
filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
