"==========================
" Author: Clay
" Version: 1.0
" Email: maze@sjtu.edu.cn
" referrences:
"   https://github.com/wklken/k-vim/blob/master/vimrc
"   https://github.com/wklken/k-vim/blob/master/vimrc
" Sections:
"   ->Initial Plugin 加载插件
"	->General settings 基础设置
"   ->Display settings 界面设置
"   ->Themes settings 主题设置
"   ->ShortCuts settings 快捷键设置
" 	->FileType Settings  文件类型设置
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
autocmd! bufwritepost $HOME/.vimrc source $HOME/.vimrc	" Automatic reloading of .vimrc
autocmd! bufwritepost $HOME/.vimrc.bundles source $HOME/.vimrc	" Automatic reloading of .vimrc
set encoding=utf-8
" autocmd Filetype markdown,tex,python set spell
set spelllang=en,cjk
" set complete+=kspell                            " todo
set complete-=i                                 " Limit the files searched for auto-completes. [tex:\cite{]todo
filetype on										" 检测文件类型
filetype indent on								" 针对不同的文件类型采用不同的缩进格式
filetype plugin on								" 允许插件
filetype plugin indent on						" 启动自动补全
set autoread									" 文件修改之后自动载入
au CursorHold * checktime                       "Generally autoread will only trigger after executing an external command.
set clipboard=unnamedplus                       " 系统剪切板
set nobackup                                    " no backup files
set noswapfile                                  " no swap files
set nowritebackup                               " only in case you don't want a backup file while editing
set noundofile                                  " no undo files

let mapleader = ","   	                		" let 语句
let g:mapleader = ","                   		" 设置 vim 参数
set timeoutlen=600

set ttymouse=xterm2                             " using mouse within tmux
set mouse=a                                     " 允许鼠标（点击）， a 代表所有模式
set nocompatible                                " 关闭兼容模式
set updatetime=100                              " gitgutter 刷新更快(default=400)
set backspace=eol,start,indent                  " Configure backspace so it acts as it should act
set conceallevel=2								" 隐藏markdown 中的[]** 等

"==========================
"Display settings 界面设置
"==========================


syntax on               " 开启语法高亮
set number              " 显示行号
set ruler               " 显示当前行号列号
set relativenumber
" set cursorcolumn      " 突出显示当前列
" set cursorline        " 突出显示当前行,注意突出显示,会让vim重新绘制,影响流畅性
set showmode            " 左下角显示当前vim模式
set nowrap              " 取消换行
set showcmd             " 显示现有命令（在右下角）
set scrolloff=7         " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set showmatch           " 括号配对情况, 跳转并高亮一下匹配的括号
set matchtime=1         " How many tenths of a second to blink when matching brackets
set tw=79
set fo-=t               " don't automatically wrap text when typing
set colorcolumn=80

" performance
set lazyredraw          " Don’t update screen during macro and script execution.

" 设置文内智能搜索提示
set hlsearch            " 高亮search命中的文本
set incsearch           " 打开增量搜索模式,随着键入即时搜索
set ignorecase          " 搜索时忽略大小写
set smartcase           " 有一个或以上大写字母时仍大小写敏感
set wildmenu            " vim 自身命令行模式智能补全

" tab相关变更
set tabstop=4           " 设置Tab键的宽度 [等同的空格个数]
set shiftwidth=4        " 每一次缩进对应的空格数
set softtabstop=4       " 按退格键时可以一次删掉 4 个空格
set smarttab            " injjjjjjjjjjjjsert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab           " 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set shiftround          " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'

" 缩进配置
set smartindent
set autoindent

" 窗口布局，窗口切换
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 代码折叠
set foldmethod=indent
set foldlevel=99
" nnoremap <space> za         "Enable folding with the spacebar

" 光标形状 cursor shape
" For iterm2 on Mac
" Also, see jszakmeister/vim-togglecursor
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"    "SI = INSERT mode (vertical bar)
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"    "SR = REPLACE mode (under line)
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"    "EI = NORMAL mode (ELSE) (block)
" autocmd VimLeave * let &t_me="\<Esc>]50;CursorShape=1\x7"
"==========================
"Themes setting 主题设置
"==========================
colorscheme monokai
set background=dark
highlight clear LineNr
highlight clear SignColumn
highlight GitGutterAdd ctermfg=white
highlight GitGutterChange ctermfg=LightGreen
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=LightGreen

"==========================
"ShortCuts settings 快捷键设置
"==========================
"Quick saving
noremap <leader>s :update<CR>
vnoremap <leader>s <C-O>:update<CR>
inoremap <leader>s <C-O>:update<CR><Esc>
"Quick quit
noremap <leader>q :quit<CR>
noremap <leader>Q :qa!<CR>
"Easier moving between tabs
map <leader>n <esc>:tabprevious<CR>
map <leader>m <esc>:tabnext<CR>
"Easier moving code blocks
vnoremap > >gv
vnoremap < <gv
"Put breakpoint before current line
map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>
"==========================================
" FileType Settings  文件类型设置
"==========================================
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby,javascript,html,css,xml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd
autocmd BufRead,BufNewFile *.part set filetype=html
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai

" 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|todo\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(DEBUG\|INFO\)')
  endif
endif


