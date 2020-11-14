Set Up Linux Environment
========================

<!-- vim-markdown-toc GFM -->

* [Proxy](#proxy)
* [Change Apt Source(optional)](#change-apt-sourceoptional)
* [Install Python3](#install-python3)
* [Install Git](#install-git)
* [Install Zsh/Oh-My-Zsh](#install-zshoh-my-zsh)
* [Install Nvm Npm Node](#install-nvm-npm-node)
* [Install Neovim](#install-neovim)
* [Install Tmux](#install-tmux)
* [Other Useful Tools](#other-useful-tools)

<!-- vim-markdown-toc -->

Proxy
-----

```sh
export http_proxy="http://192.168.0.102:1087"
export https_proxy=$https_proxy
```


Change Apt Source(optional)
-----------------

1. Goto [mirrors.tuna.tsinghua.edu.cn](https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/), choose right os, and copy all the links to clipboard.

2. Backup sources.list

    ```sh
    sudo cp /etc/apt/sources.list /etc/apt/sources.list_back
    ```

1. Paste contents to `sources.list`

    ```sh
    sudo vim /etc/apt/sources.list
    ```

4. Update

    ```sh
    sudo apt-get update
    ```

5. Add ppa repository

    ```sh
    sudo add-apt-repository ppa:user/ppa-name
    sudo apt update
    ```

1. Remove ppa repository

    ```sh
    cd /etc/apt/sources.list.d/
    sudo rm xxx.list
    sudo apt update

    # or
    sudo add-apt-repository --remove ppa:ppa-name
    ```



Install Python3
---------------

1. Install python and pip

    ```sh
    sudo apt install python3
    sudo apt install python3-pip
    # or
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    ```

2. `pip.conf`

    ```config
    [global]
    index-url = https://mirrors.aliyun.com/pypi/simple
    /* index-url = https://pypi.tuna.tsinghua.edu.cn/simple */
    ```


Install Git
-----------
1. install
    ```sh
    sudo apt install git-all
    ```
2. Config
    ```config
    [user]
        email = xx@xx.com
        name = yourname
    [push]
        default = simple
    [alias]
        unstage = reset HEAD --
        last = log -1 HEAD
        map = log --graph --oneline
        ck=checkout
    [http]
        proxy = http://192.168.0.102:1087
        postBuffer = 2000000000

    [https]
        proxy = http://192.168.0.102:1087
    ```

    or copy your local `.gitconfig`
    ```sh
    scp ~/.gitconfig remote:~/.
    ```



Install Zsh/Oh-My-Zsh
---------------------

1. Install zsh
    ```sh
    sudo apt install zsh
    ```
1. Verify installation by running `zsh --version`.

1. Make it your default shell: `chsh -s $(which zsh)`

1. Test with `echo $SHELL`

2. Install oh-my-zsh
    ```sh
    sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    ```

3. copy your local `.zshrc`

    ```sh
    scp ~/.zshrc remote:~/.
    ```

4. copy local `custom` folder

    ```sh
    scp -r ~/.oh-my-zsh/custom remote:~/.oh-my-zsh/
    ```



Install Nvm Npm Node
--------------------

1. Install nvm

    ```sh
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
    ```

2. zshrc

    ```sh
    export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
    ```

3. `nvm install node`

2. After install `npm` and `node`

    ```sh
    npm config edit
    ```

    Add the following line.

   `registry=http://registry.npm.taobao.org/`


Install Neovim
--------------

1. install


2. clone .vim

    ```sh
    git clone git@github.com:thylakoids/vimrc.git
    mv vimrc ~/.vim

    ln -s ~/.vim/vimrc .vimrc
    ln -s ~/.vim/vimrc.bundles .vimrc.bundles
    mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
    ln -s ~/.vim $XDG_CONFIG_HOME/nvim
    ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
    ```



Install Tmux
------------

1. Installing Tmux(>2.6) on Ubuntu

    ```sh
    sudo apt install tmux
    ```

2. Install `[oh-my-tmux](https://github.com/gpakosz/.tmux)`

    ```sh
    cd
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
    ```

    Then proceed to customize your ~/.tmux.conf.local copy.

3.  Add `export EDITOR=vim` to `~/.zshrc` to active vim mode.

2. Install `tmp`, and plugins.

    ```sh
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```

    Appendent following code to `~/.tmux.conf.local`

    ```conf
    set -g mouse on
    #####################
    #  List of plugins  #
    #####################

    set -g @tpm_plugins '          \
      tmux-plugins/tpm             \
      tmux-plugins/tmux-sensible   \
      tmux-plugins/tmux-resurrect  \
      tmux-plugins/tmux-continuum  \
      christoomey/vim-tmux-navigator \
      tmux-plugins/tmux-yank       \
    '
    ########################
    #  Config for plugins  #
    ########################
    # tmux-continuum {{{
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '15'
    # }}}

    # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    run '~/.tmux/plugins/tpm/tpm'
    ```

    Then `<prefix> + r` to source tmux config, and press `<prefix> + I` to install plugins.

Other Useful Tools
------------------

* linuxbrew
* fzf
* tldr
