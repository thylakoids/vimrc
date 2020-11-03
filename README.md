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

使用vim-plug安装vim插件的方法与另外一个著名的vim插件管理器Vundle非常相似，只需要在vim配置文件 ~/.vimrc 增加以 call plug#begin(PLUGIN_DIRECTORY) 开始，并以 plug#end() 结束的配置段即可。

```vim
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '~/my-prototype-plugin'
call plug#end()
```



Vim 配置
------


Vim 学习
------

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

```sh
:syntime on
:syntime report
```



Vim and Tmux
------------

1. Vim Tmux Navigator

1. How to send code from vim to tmux window?(vim-tmux-runner)



[Ultisnips](Https://Vimzijun.Net/2016/10/30/Ultisnip/)
------------------------------------------------------
