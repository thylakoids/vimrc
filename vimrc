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
filetype on										" 检测文件类型
filetype indent on								" 针对不同的文件类型采用不同的缩进格式
filetype plugin on								" 允许插件
filetype plugin indent on						" 启动自动补全
set autoread									" 文件修改之后自动载入

let mapleader = ","   	                		" let 语句
let g:mapleader = ","                   		" 设置 vim 参数

set mouse=a                                     " 允许鼠标（点击）， a 代表所有模式
set nocompatible                                " 关闭兼容模式
set updatetime=100                              " gitgutter 刷新更快(default=400)
set backspace=eol,start,indent                  " Configure backspace so it acts as it should act
set conceallevel=2								" 隐藏markdown 中的[]** 等

"==========================
"Display settings 界面设置
"==========================


syntax on           " 开启语法高亮
set number          " 显示行号
set ruler           " 显示当前行号列号
" set cursorcolumn  " 突出显示当前列
set cursorline      " 突出显示当前行
set showmode        " 左下角显示当前vim模式
set nowrap          " 取消换行
set showcmd         " 显示现有命令（在右下角）
set scrolloff=5     " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set showmatch       " 括号配对情况, 跳转并高亮一下匹配的括号
set matchtime=1     " How many tenths of a second to blink when matching brackets

" 设置文内智能搜索提示
set hlsearch        " 高亮search命中的文本
set incsearch       " 打开增量搜索模式,随着键入即时搜索
set ignorecase      " 搜索时忽略大小写
set smartcase       " 有一个或以上大写字母时仍大小写敏感
set wildmenu        " vim 自身命令行模式智能补全

" tab相关变更
set tabstop=4       " 设置Tab键的宽度 [等同的空格个数]
set shiftwidth=4    " 每一次缩进对应的空格数
set softtabstop=4   " 按退格键时可以一次删掉 4 个空格
set smarttab        " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab       " 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set shiftround      " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'

" 缩进配置
set smartindent
set autoindent


"==========================
"Themes setting 主题设置
"==========================
colorscheme solarized
highlight clear LineNr
highlight clear SignColumn
highlight GitGutterAdd ctermfg=white
highlight GitGutterChange ctermfg=LightGreen
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=LightGreen

"==========================
"ShortCuts settings 快捷键设置
"==========================
vnoremap <leader>y "+y      " 复制选中区到系统剪切板中
vnoremap <leader>p "+p      " 粘贴选中区到系统剪切板中

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
