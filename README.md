<!-- vim-markdown-toc GFM -->

* [Vim 安装](#vim-安装)
    * [其他相关环境的安装](#其他相关环境的安装)
* [Vim 配置](#vim-配置)
* [Vim 学习](#vim-学习)
    * [VimL](#viml)
    * [快捷键和一些常用命令](#快捷键和一些常用命令)
    * [不为人知的小技巧](#不为人知的小技巧)
* [Vim 优化](#vim-优化)
    * [Improving Startup Time](#improving-startup-time)
    * [Improving Syntax Rendering](#improving-syntax-rendering)
* [Vim and Tmux](#vim-and-tmux)
* [Ultisnips](#ultisnips)
* [Fugitive](#fugitive)
    * [Issues](#issues)
* [Other Plugins Issues](#other-plugins-issues)
    * [Vimwiki](#vimwiki)
    * [vim-system-copy](#vim-system-copy)

<!-- vim-markdown-toc -->

Vim 安装
------

1. 安装vim/neovim（注意版本支持）

```sh
sudo apt install vim
sudo apt install neovim
```


2. 安装依赖软件和库

`sudo apt-get install build-essential cmake python-dev python3-dev`


3. 安装vim-plug
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

使用`vim-plug`安装vim插件的方法与另外一个著名的vim插件管理器`Vundle`非常相似，只需要在vim配置文件
`~/.vimrc` 增加以 `call plug#begin(PLUGIN_DIRECTORY)` 开始，并以 `plug#end()`
结束的配置段即可。例如:

```vim
call plug#begin('~/.vim/bundle')
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do':'pip3 install genson && brew install figlet && brew install fzf'}
Plug 'lifepillar/vim-gruvbox8'
Plug 'SirVer/ultisnips'
call plug#end()
```

### [其他相关环境的安装](./quickEnv/README.md)


Vim 配置
------


Vim 学习
------

### VimL
* [Learn Vimscript the Hard Way](./vimLwiki/vimL.md)
* [VimL 语言编程指北路](./vimLwiki/vimL-advance.md)

### 快捷键和一些常用命令

1. 复制-粘贴-寄存器

    `register` 命令可以查看所有寄存器的内容(`:help register`).

    `"xyy` 复制当前行到寄存器`x`(`:help yank`)

    `"xp` Put the text [from register x] after the cursor.(`:help put`)

1. spell

    `zg` Add word under the cursor as a good word to `spellfile`(`:help spell`)

    `z=` Suggest correctly spelled words

1. `normal!`: Something like the nnoremap version of nmap for normal.

1. `function!`: Will override function with the same name defined before.

1. macro:
    - `qq`: recording, `q` stop. `@q` to repeat.
    - In insert mode, `<ctrl-r> q` to paste the register "q.

1. Format lines

    `gq{motion}`, `gw{motion}`

1. `:g` `:global` `:v` `:g!`
    - `:g/pattern/d`: delete lines that match the pattern globally.
    - `:1,10g/pattern/d`: delete lines range from 1 to 10 which match the pattern.
    - `:v/pattern/d`: delete lines dose NOT match the pattern globally.



### 不为人知的小技巧
1. Convert to html
    ```vim
    :TOhtml
    ```



Vim 优化
------

* `vim -u NONE` 可以不加载vim配置和插件打开vim
* `vim --startuptime vim.log` 可以生成vim启动的log
* 使用`vim-plug`插件管理工具，给插件配置`for` or `on`可以实现插件懒加载
* 设置`foldmethod=syntax`会导致vim插入模式下卡顿


### Improving Startup Time
为了优化vim启动，首先可以做的一点是将插件懒加载，即用到哪个插件再加载哪个插件，通过vim-plug插件管理工具可以非常方便的做到，配置方式如下：

```vim
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
```

`on`表示在某个条件下加载，例如上面的配置表示在输入命令`NERDTreeToggle`的时候加载nerdtree插件，`for`表示该插件针对某一类文件加载，例如vim-jsx插件只有在文件类型为javascript.jsx的时候加载。

这样就可以让vim在启动的时候，不加载不必要的插件。

1. Profiling Vim startup time

    `vim --startuptime vim.log`

2. Profiling using a [plug](https://github.com/hyiltiz/vim-plugins-profile)

```sh
# Perl version as an example:
perl <(curl -sSL https://raw.githubusercontent.com/hyiltiz/vim-plugins-profile/master/vim-plugins-profile.pl)

# or Ruby
ruby <(curl -sSL https://raw.githubusercontent.com/hyiltiz/vim-plugins-profile/master/vim-plugins-profile.rb)

# or Python (add -p flat to plot a bar chart)
python <(curl -sSL https://raw.githubusercontent.com/hyiltiz/vim-plugins-profile/master/vim-plugins-profile.py)

# or R
bash <(curl -sSL https://raw.githubusercontent.com/hyiltiz/vim-plugins-profile/master/vim-plugins-profile.sh)
```

### Improving Syntax Rendering
1. Profiling syntax rendering

    ```sh
    :syntime on
    # move around
    :syntime report
    ```



Vim and Tmux
------------

1. Vim Tmux Navigator

1. How to send code from vim to tmux window?(vim-tmux-runner)



[Ultisnips](https://vimzijun.net/2016/10/30/ultisnip/)
---------------------
1. UltiSnip Snippets

    https://github.com/honza/vim-snippets.git


[Fugitive](https://github.com/tpope/vim-fugitive)
--------
``` vim
Gstatus | Git
Gwrite
Gread
Gdiff
Gedit
Glog
0Glog
```

### Issues
1. when call `Gdiff` twice: `redrawtime exceeded syntax highlighting disabled`


Other Plugins Issues
-------------
### Vimwiki
[Optionally convert whitespace to non-white in visual mode link creation #773](https://github.com/vimwiki/vimwiki/issues/773)

For those who want to make the links compatible with **markor** but not want to install **dev** branch.

* Open the location where `vimwiki` plugin is installed. If you are using `vim-plug`, the location would be `~/.cache/nvim/plugged/vimwiki/`
* In the location, open the file `autoload/vimwiki/markdown_base.vim`
* In the function `s:normalize_link_syntax_v()`, find the line that says

``` vim
let link = s:safesubstitute(vimwiki#vars#get_syntaxlocal('Weblink1Template'),
          \ '__LinkUrl__', visual_selection, '')
```

* Replace the above line with the following 3 lines

``` vim
" Change ALL characters except alphabets, digits, hyphen, underscore or full stop into '-'
let url = substitute(visual_selection, '[^A-Za-z0-9_.]', '-', 'g')
" Change uppercase to lowercase
let url = substitute(url, '[A-Z]', '\L&', 'g')
let link = s:safesubstitute(vimwiki#vars#get_syntaxlocal('Weblink1Template'),
          \ '__LinkUrl__', url, '')  
```

* Restart `vim/nvim`
Code stolen from dev branch

### vim-system-copy
[How does paste work exactly? #37](https://github.com/christoomey/vim-system-copy/issues/37)

``` diff
// system_copy.vim
-    silent exe "normal! `[v`]c" . system(command)
+
+    let [sl, sc] = getpos("'[")[1:2]
+    let [el, ec] = getpos("']")[1:2]
+    " :echom sc
+    " :echom ec
+    if sl ==# el && sc-1 ==# ec
+      silent exe "normal! `]a" . system(command)
+    else
+      silent exe "normal! `[v`]c" . system(command)
+    endif
+
```

