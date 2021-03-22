[Configure Coc.Nvim for C/C++ Development](https://ianding.io/2019/07/29/configure-coc-nvim-for-c-c++-development/)
========================================

Setting up CCLS
---------------
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

Setting up your C/C++ Project
-----------------------------
### Generate `.CCLS`

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

### Putting .Ccls in the Project Root.

