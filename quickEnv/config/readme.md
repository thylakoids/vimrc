Homebrew
--------

替换为中科大源

替换brew.git：

```shell
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
```

替换homebrew-core.git:

```
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
```

重置源

重置brew.git

```shell
cd "$(brew --repo)"
git remote set-url origin https://github.com/Homebrew/brew.git
```

重置homebrew-core：

```shell
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://github.com/Homebrew/homebrew-core.git
```

pip.conf
--------

```
[global]
index-url = https://mirrors.aliyun.com/pypi/simple
/* index-url = https://pypi.tuna.tsinghua.edu.cn/simple */
```

