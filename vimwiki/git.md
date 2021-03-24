[如何使用Git Rebase](https://segmentfault.com/a/1190000019455172)
-------------------------

1. 和远程仓库同步当前分支的时候使用 `pull --rebase` 的方式。
2. 合并分支的使用 feature rebase on master，master merge feature 的方式。



Vim fugitive
------------
### `Gstatus` `Glog` `Gdiff` `Gsplit`

### `Git`/`Gstatus` window

command | affect
:-------|:--
-       | add/reset file (works in visual mode too)
\<Enter> | open current file in the window below
p       | run `git add –patch` for current file
C       | invoke :**Gcommit**

### `Gedit :path/to/file`



### `Gdiffsplit master:%`

Open file in other branches in a split window.

`:edit %:h`: allows you to open the parent tree.


### reconciliation

`diffget` `diffput` `diffupdate` `do`(diff obtain) `dp`


`:Gdiff` on a conflicted file opens 3-way diff

2             | 1            | 3
:-------------|:-------------|:--
target branch | working copy | merge branch

`:diffget 2` `:diffget 3`
