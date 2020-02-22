vim 安装
=============
1. 安装vim（注意版本支持）

`sudo apt install vim`


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

3. 安装YouCompleteMe

- 使用`vim-plug`获得源码。
- 在源码目录运行 `git submodule update --init --recursive` 来获取 YouCompleteMe 的相关依赖 (虽然使用 vundle 或 vim-plug 安装时都会下载所有的依赖)。


4. 编译YouCompleteMe

YouCompleteMe 需要手工编译出库文件 ycm_core.so(以及依赖的libclang.so) 才可使用。

假设使用 vim-plug 下载的 YouCompleteMe 源码保存在目录 `~/.vim/plugged/YouCompleteMe`，在该目录下执行 `./install.py --clang-completer` 即可编译具有C族语言的语义补全功能的 YouCompleteMe 插件。
