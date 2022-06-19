Learn Makefiles
===============

Variables
---------
Reference variables using either `$()` or `${}`
``` sh
x := dude

all:
	echo $(x)
	echo ${x}

	# Bad practice, but works
	echo $x 
```



Reference
---------
* [Learn Makefiles With the tastiest examples](https://makefiletutorial.com/#getting-started)
* [GNU Make manual](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables)
