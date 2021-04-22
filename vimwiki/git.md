Git Often Used Command
----------------------

1. Discard changes in working directory, i.e. working directory --> stage

    ```shell
    git checkout <file>
    ```

2. Modify git commit message.

    ```shell
    git commmit --amend -m "new messge"
    ```

3. Add file to last commit.

    ```shell
    git add <newfile>
    git commmit --amend
    ```

`git commit --amend` will change the git history, so do not use this in public repository.

4. Make commit to the wrong branch.

    Suppose you have tow branch, master and dev. You make a commit to master,
    while you really mean to make that commit to dev, than `cherry-pic` to the
    rescue.

    `git cherry-pick` creates a new commit based on original commit.

    ```shell
    (master)# git commmit -m 'changes should make to dev'
    (master)# git check dev
    (dev)# git cherry-pick 1b8183d
    ```

    This way we bring that master commit to dev, but `cherry-pick` dose not
    delete the original commit in master.

    To get rid of that commit in master, using `git reset`.

    There are three different type of `git reset` you should know about:
    ```
    git reset --soft 2r98j            # commit --> stage
    git reset --mix  2r98j            # (default) commit --> working directory
    git reset --hard  2r98j           # delete commit (reset the tracted file,
                                      # leave the untracked file alone, you can use `git clean -df` to delete the
                                      # untracked file)
    ```

    ```shell
    (dev)# git check master
    (master)# git reset --hard 2r98j
    (master)# git clean -df
    ```

[如何使用Git Rebase](https://segmentfault.com/a/1190000019455172)
-------------------------

### using in merge
1. 和远程仓库同步当前分支的时候使用 `pull --rebase` 的方式。
2. 合并分支的使用 feature rebase on master，master merge feature 的方式。




Git **submodule**
-------------

## Git submodule add example

Locally
```shell
git submodule add ./subdir
```

Github
```shell
git clone https://github.com/username/repository.git
git submodule init
git submodule update
```



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


`:Gdiff` on a conflicted file opens 3-way doff

2             | 1            | 3
:-------------|:-------------|:--
target branch | working copy | merge branch

`:diffget 2` `:diffget 3`
