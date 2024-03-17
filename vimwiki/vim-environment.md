[Configure Coc.Nvim for C/C++ Development](https://ianding.io/2019/07/29/configure-coc-nvim-for-c-c++-development/)
========================================
CCLS
----
### 1. Setting Up Ccls
``` shell
brew update
brew install ccls
```

In Vim, run `:CocConfig`, or edit `~/.vim/coc-settings.json`
``` vim
{
    "languageserver": {
        "ccls": {
            "command": "ccls",
            "filetypes": [
                "c",
                "cpp",
                "objc",
                "objcpp"
            ],
            "rootPatterns": [
                ".ccls",
                "compile_commands.json",
                ".vim/",
                ".git/",
                ".hg/"
            ],
            "initializationOptions": {
                "cache": {
                    "directory": "/tmp/ccls"
                }
            }
        }
    }
}
```

### 2. Setting Up Your C/C++ Project
#### Generate `.CCLS`

Run `g++ -E -x c++ - -v < /dev/null` in your terminal and you’ll see a list of
include paths that the compiler searches. They are between `#include <...>
search starts here:` and `End of search list..` Now put them into your `.ccls` file
as `-isystem` options (unlike -I, the errors and warnings in the header files
found in `-isystem` paths are ignored by the syntax checker).

After manually adding these system header paths, the `.ccls` file might look like this:
```
-isystem
/Library/Developer/CommandLineTools/usr/bin/../include/c++/v1
-isystem
/Library/Developer/CommandLineTools/usr/lib/clang/12.0.0/include
-isystem
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include
-isystem
/Library/Developer/CommandLineTools/usr/include
-isystem
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks (framework directory)
-I
../include
-I
../vendor/include
-std=c++14
-stdlib=libc++
-fPIC
```

#### 3. Putting .Ccls in the Project Root.

[coc-cland](https://github.com/clangd/coc-clangd)
---------
I choose `coc-clangd` because its easy to config.

### 1. Install coc-clanged
In vim, run `:CocInstall coc-clangd`
### 2. Generate `compile_flags.txt`
Run `pkg-config --libs --cflags fmt` to check the path.
```
-I/home/linuxbrew/.linuxbrew/Cellar/fmt/10.2.1/include
```

Package manager: `Homebrew` or `linuxbrew`
--------------------------------------
Add these to `.bashrc`, so that your compiler can find the correct library
installed by `Homebrew`.
```
export CPLUS_INCLUDE_PATH="/home/linuxbrew/.linuxbrew/include"
export C_INCLUDE_PATH="/home/linuxbrew/.linuxbrew/include"
```


Issues
------
1. I need to manually install `fmt` because of version compatibility issues.


Reference
----------
[G++ Cheatsheet](https://bytes.usc.edu/cs104/wiki/gcc)
