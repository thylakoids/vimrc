"==========================
" Author: Clay
" Version: 1.0
" Email: maze@sjtu.edu.cn
" Referrences:
"   https://github.com/wklken/k-vim/blob/master/vimrc
" Sections:
"   ->Initial Plugin 加载插件
"   ->General settings 基础设置
"   ->Display settings 界面设置
"   ->Themes settings 主题设置
"   ->ShortCuts settings 快捷键设置
"   ->FileType Settings  文件类型设置
"   ->Autocmd 智能的自动命令
"
" Note: Don't put anything in your .vimrc you don't understand!
"==========================


"==========================
"Initial Plugin 加载插件
"==========================
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif


"==========================
"General settings 基础设置
"==========================
autocmd! bufwritepost $HOME/.vimrc source $MYVIMRC             " Automatic reloading of .vimrc
autocmd! bufwritepost $HOME/.vim/vimrc source $MYVIMRC         " Automatic reloading of .vimrc
autocmd! bufwritepost $HOME/.vimrc.bundles source $MYVIMRC     " Automatic reloading of .vimrc
autocmd! bufwritepost $HOME/.vim/vimrc.bundles source $MYVIMRC " Automatic reloading of .vimrc
set encoding=utf-8

fun! Setspellnospell()
    " set spell on these filetypes
    let blacklist = ['markdown', 'txt', 'plaintex', 'latex', 'gitcommit', 'vimwiki']
    if index(blacklist, &ft) < 0
        set nospell
        return
    else
        set spell
    endif
endfun
autocmd FileType * call Setspellnospell()

set spelllang=en,cjk
" set complete-=i                                 " Limit the files searched for auto-completes. [tex:\cite{]todo
set complete=.
set complete+=kspell                            " match dictionary words
set autochdir
filetype on                                     " 检测文件类型
filetype indent on                              " 针对不同的文件类型采用不同的缩进格式
filetype plugin on                              " 允许插件
filetype plugin indent on                       " 启动自动补全
"Generally autoread will only trigger after executing an external command.
"所以需要cursorhold
"checktime 会导致打开cmdline-window错误, 所以判断是不是cmdline-window
set autoread                                    " 文件修改之后自动载入
au CursorHold * if !bufexists("[Command Line]") | checktime | endif
set nobackup                                    " no backup files
set noswapfile                                  " no swap files
set nowritebackup                               " only in case you don't want a backup file while editing
set noundofile                                  " no undo files

let mapleader = ","                             " let 语句
let g:mapleader = ","                           " 设置 vim 参数
set timeoutlen=800

if !has('nvim')
    set ttymouse=xterm2                         " using mouse within tmux
endif
set mouse=a                                     " 允许鼠标（点击）， a 代表所有模式
set nocompatible                                " 关闭兼容模式
set updatetime=100                              " gitgutter 刷新更快(default=400)
set backspace=eol,start,indent                  " Configure backspace so it acts as it should act
set conceallevel=0                              " 隐藏markdown 中的[]** 等, debug:notworking
set listchars=eol:¬,tab:▸·,trail:.,extends:>,precedes:<           "效果		   	end
set list

"==========================
"Display settings 界面设置
"==========================


"what bug?(https://lotabout.me/2018/true-color-for-tmux-and-vim/)
if has("termguicolors")
  " fix bug for vim
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum

  " enable true color
  set termguicolors
endif

syntax on               " 开启语法高亮
set number              " 显示行号
" set ruler               " 显示当前行号列号

" function! g:ColorcolumnPlus() abort
"     if winwidth(winnr()) > 100
"         set colorcolumn=80
"     else
"         set colorcolumn=
"     endif
" endfunction
" autocmd WinEnter,BufWinEnter,VimResized * call ColorcolumnPlus()
" autocmd WinLeave * set colorcolumn=
" call g:ColorcolumnPlus()
" match Colorcolumn /\%81v/
call matchadd('Colorcolumn', '\%80v', 100)

set relativenumber
set nowrap              " 取消换行
set showcmd             " 显示现有命令（在右下角）
set scrolloff=1         " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set sidescrolloff=2
set laststatus=2        " always show status line
set showmatch           " 括号配对情况, 跳转并高亮一下匹配的括号
set matchtime=1         " How many tenths of a second to blink when matching brackets
let g:matchparen_timeout = 20 "Highlighting matching parens, if file is too large, matchparen would make vim slow
let g:matchparen_insert_timeout = 2
set tw=79
set fo-=t               " don't automatically wrap text when typing

" performance
set lazyredraw          " Don’t update screen during macro and script execution.
" set synmaxcol=3000

" 设置文内智能搜索提示
set hlsearch            " 高亮search命中的文本
set incsearch           " 打开增量搜索模式,随着键入即时搜索
if has('nvim')
  set inccommand=nosplit
endif
set ignorecase          " 搜索时忽略大小写
set smartcase           " 有一个或以上大写字母时仍大小写敏感
set wildmenu            " vim 自身命令行模式智能补全

" tab相关变更
set tabstop=4           " 设置Tab键的宽度 [等同的空格个数]
set shiftwidth=4        " 每一次缩进对应的空格数
set softtabstop=4       " 按退格键时可以一次删掉 4 个空格
set smarttab            " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab           " 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set shiftround          " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'

" 缩进配置
" set smartindent
" set autoindent
" 窗口布局，窗口切换
set splitbelow
set splitright
nnoremap <up> <C-W>-
nnoremap <down> <C-W>+
nnoremap <right> <C-W><
nnoremap <left> <C-W>>

" 代码折叠
autocmd FileType vim setlocal foldmethod=marker
" autocmd FileType python setlocal foldmethod=indent
" autocmd FileType javascript setlocal foldmethod=syntax
" set foldlevel=20
set foldmethod=manual

" 光标形状 cursor shape
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
      \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
      \,sm:block-blinkwait175-blinkoff150-blinkon175
augroup RestoreCursorShapeOnExit
  autocmd!
  autocmd VimLeave * set guicursor=a:ver25-blinkon0
augroup END

" statusline and tabline:lightweight and sexy status bar in vim
" if filereadable(expand("~/.vim/statusline.vim"))
"     source ~/.vim/statusline.vim
" endif
"==========================
"Themes setting 主题设置
"==========================
function! g:Colorschemeplus()
  " colorscheme solarized8
  " highlight clear LineNr
  " highlight clear SignColumn

  colorscheme gruvbox8
  set background=dark
  " highlight Normal ctermbg=NONE guibg=NONE
  highlight! link SignColumn LineNr
  highlight GruvboxGreenSign ctermbg=NONE guibg=NONE
  highlight GruvboxredSign ctermbg=NONE guibg=NONE
  highlight GruvboxAquaSign ctermbg=NONE guibg=NONE
  highlight GruvboxYellowSign ctermbg=NONE guibg=NONE
  highlight GruvboxOrangeSign ctermbg=NONE guibg=NONE
  highlight GruvboxBlueSign ctermbg=NONE guibg=NONE
endfunction
call g:Colorschemeplus() 

" press f10 to show hlgroup
function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
map <F10> :call SynGroup()<CR>
"==========================
"ShortCuts settings 快捷键设置
"==========================
"Quick <esc>
inoremap jk <esc>

nnoremap J <nul>

noremap k gk
noremap j gj
"Keep search pattern at the center of the screen."
" nnoremap <silent> n nzz
" nnoremap <silent> N Nzz
" nnoremap <silent> * *zz
" nnoremap <silent> # #zz
" nnoremap <silent> g* g*zz
"Quick saving
" noremap <leader>s :update<CR>
" vnoremap <leader>s <C-O>:update<CR>
" inoremap <leader>s <C-O>:update<CR><Esc>
"Easier moving between tabs
map <leader>n <esc>:tabprevious<CR>
map <leader>m <esc>:tabnext<CR>
"Easier moving code blocks
vnoremap > >gv
vnoremap < <gv
"Put breakpoint before current line
aug addbreakpoint
  autocmd!
  autocmd FileType python noremap <silent> <buffer> <leader>b :<c-u>normal! Oimport ipdb; ipdb.set_trace()<cr>
  autocmd FileType javascript noremap <silent> <buffer> <leader>b :<c-u>normal! Odebugger<cr>
aug END
"markdown heading u1, u2, u3
aug mdheading
  autocmd!
  autocmd FileType markdown nmap <buffer> <leader>u1 <Plug>TitlecaseLine:normal! mmyypVr=`m<CR>
  autocmd FileType markdown nmap <buffer> <leader>u2 <Plug>TitlecaseLine:normal! mmyypVr-`m<CR>
  autocmd FileType markdown nmap <buffer> <leader>u3 <Plug>TitlecaseLine:normal! mmI### <esc>`m4l
aug END
"GoogleSearch{{{
"todo: ""
function! GoogleSearch()
   let searchterm = getreg("g")
   if g:os == 'Darwin'
      silent! exec "!open \"http://google.com/search?q=" . searchterm . "\" &"
   elseif g:os == 'Linux'
      silent! exec "!xdg-open \"http://google.com/search?q=" . searchterm . "\" &"
   endif
endfunction
if g:os == 'Darwin'
  nnoremap <leader>g :!open "https://google.com/search?q=
elseif g:os == 'Linux'
  nnoremap <leader>g :!xdg-open "https://google.com/search?q=
endif
vnoremap <leader>g "gy<Esc>:call GoogleSearch()<CR>
"}}}
"Quick quoting
" todo: how to make this to an operator
nnoremap <leader>' viw<esc>`>a'<esc>bi'<esc>lel
nnoremap <leader>" viw<esc>`>a"<esc>bi"<esc>lel
nnoremap <leader>` viw<esc>`>a`<esc>bi`<esc>lel
vnoremap <leader>' <esc>`>a'<esc>bi'<esc>lel
vnoremap <leader>" <esc>`>a"<esc>bi"<esc>lel
vnoremap <leader>` <esc>`>a`<esc>bi`<esc>lel
" todo: how to do this:
" :autocmd BufNewFile * :write
"          ^          ^ ^
"          |          | |
"          |          | The command to run.
"          |          |
"          |          A "pattern" to filter the event.
"          |
"          The "event" to watch for.
" Quick open .vimrc
nnoremap <leader>ev :sp $MYVIMRC<cr>
nnoremap <leader>es :UltiSnipsEdit<cr>
"为字典添加引号, 比如从浏览器复制的数据转换为字典
vnoremap <leader>aq :s/\t/": "/g<cr>:'<,'>s/\n/",\r"/g<cr>x'<i"<esc>:noh<cr>
"查找visual高亮
nnoremap <space><space> :keepjumps normal! mi*`i<CR>
vnoremap <space><space> miy/<c-r>"<cr>`i
nnoremap <leader><space> :noh<CR>
" ctrl+s to save file
nnoremap F :update<CR>

" 正确处理中文: 修改json.tool源码(module.__file__), 添加ensure_ascii=False
" nnoremap <Leader>jf :%!python -m json.tool<cr>

noremap [<space> <C-^>



" =====================
" 设置可以高亮的关键字
"======================
" :h group-name, 显示可用的group
aug highligth_keyword
    " Highlight TODO, FIXME, NOTE, etc.
    au!
    autocmd Syntax * call matchadd('Todo',  '\<\(TODO\|todo\)\>')
    autocmd Syntax * call matchadd('Debug', '\<\(DEBUG\|INFO\|debug\|issue\)\>')
    autocmd Syntax * call matchadd('SpecialComment', '\<\(deprecated\|DEPRECATED\)\>')
aug END

"==========================
"Autocmd 智能的自动命令
"==========================
" autosave file when lose focus
autocmd BufLeave,FocusLost * call  WriteFile()
function WriteFile()
      let blacklist = [ '', 'terminal', 'nerdtree', 'qf', 'help', 'floaterm', 'leaderf', 'coc-explorer']
      if index(blacklist, &ft) < 0 && (expand("%:r") > "") && (&readonly==0)
         update
      endif
endfunction

" close vim, if quickfix is the last window
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

" augroup vimrc-incsearch-highlight
"     autocmd!
"     autocmd CmdlineEnter /,\? :set hlsearch
"     autocmd CmdlineLeave /,\? :set nohlsearch
" augroup END

" autoresize{{{
" From https://github.com/knubie/dotfiles/blob/fe7967f875945e54d49fc672f575c47691a1e4cc/.vimrc#L136
function! ResizeSplits()
    let blacklist = ['nerdtree', 'qf', 'help', 'floaterm', 'leaderf', 'coc-explorer']
    if index(blacklist, &ft) < 0
        set winwidth=100
        setlocal relativenumber
    endif
endfunction
function! ResizeSplitsUnfocus()
    setlocal norelativenumber
endfunction
augroup ReduceNoise
    autocmd!
    " Automatically resize active split to 100 width
    autocmd BufWinEnter * :call ResizeSplits()
    autocmd WinEnter * :call ResizeSplits()
    autocmd WinLeave * :call ResizeSplitsUnfocus()
augroup END
set wmw=10
" }}}

autocmd Bufread * if getfsize(expand(@%))> 1024*200 | syntax clear | endif

" resume
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif

" firstline
function! HappyPython()
    call setline(1, '#! /usr/bin/env python3')
endfun
autocmd bufnewfile *.py call HappyPython()
function! HappyJS()
    call setline(1, '#!/usr/bin/env node')
endfun
autocmd bufnewfile *.js call HappyJS()

"""""""""""""""""
"  wired stuff  "
"""""""""""""""""

" Call figlet
noremap tf :r !figlet 

" run shell command in current line
noremap Q !!$SHELL<CR>

" ========================================
" FileType Settings  文件类型设置
"==========================================
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby,html,css,xml,javascript set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd
autocmd BufRead,BufNewFile .gitignore set filetype=config
" autocmd BufRead,BufNewFile * autocmd FileType vimwiki set filetype=markdown.mkd
" autocmd BufRead,BufNewFile *.part set filetype=html
" autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
