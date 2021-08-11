VM Translator
=============

<!-- vim-markdown-toc GFM -->

* [VM Abstraction: the Stack](#vm-abstraction-the-stack)
	* [Arithmetic / Logical Commands](#arithmetic--logical-commands)
* [VM Abstraction: Memory Segments](#vm-abstraction-memory-segments)
* [VM Implementation: the Stack](#vm-implementation-the-stack)
	* [Pointer Manipulation](#pointer-manipulation)
	* [VM Translator Perspective](#vm-translator-perspective)
* [VM Implementation: Memory Segments](#vm-implementation-memory-segments)
	* [**Implementing**  constant](#implementing--constant)
	* [**Implementing**  static](#implementing--static)
	* [**Implementing**  temp](#implementing--temp)
	* [**Implementing**  pointer](#implementing--pointer)

<!-- vim-markdown-toc -->
registers:
![registers](./image/registers.png "registers")
hack code:
![hack code](./image/hack-code.png "hack-code")

VM Abstraction: the Stack
-------------------------

high-level:
``` python
x = 17 + 19
```

compile to:

lower-level:
``` VM
push 17
push 19
add
pop x
```

Stack machine, manipulated by:
* Arithmetic / logical commands
* Memory segment commands
* Branching commands
* Function commands


### Arithmetic / Logical Commands
![arithmetic](./image/arithmetic.png "arithmetic")


VM Abstraction: Memory Segments
-------------------------------
![memory-segments](./image/memory-segments.png "memory segments")

VM Implementation: the Stack
-----------------------------
### Pointer Manipulation
Logic:
``` c
*sp = 17
sp++
```

Hack assembly:
``` c
@17 // D=17
D=A

@sp // *sp=D
A=M
M=D

@sp //sp++
M=M+1
```
### VM Translator Perspective
VM code:
``` c
push constant i
```

**VM Translator**

Assembly code:
```
*sp = i, sp++
```

VM Implementation: Memory Segments
----------------------------------


VM code:
``` c
push segment i
pop segment i
```

**VM Translator**

Assembly code:
``` c
addr = segmentPointer + i, *SP=*addr, SP++
addr = segmentPointer + i, SP--, *addr=*SP
```

### **Implementing**  constant
`push constant i` --> `*SP=i, SP++`

### **Implementing**  static
``` c
...
pop static 5
...
pip static 2
...
```

--> 

``` c
...
@Foo.5
M=D

...
@Foo.2
M=D
...
```

* Have the VM translator translate each VM reference static i(in file Foo.vm)
  into an assembly reference Foo.i
 
### **Implementing**  temp
``` c
push temp i
pop temp i
```
-->

``` c
addr = 5 + i, *SP=*addr, SP++
addr = 5 + i, *SP--, *addr=*SP
```

* Mapped on RAM locations 5 to 12
* [SP, LCL, ARG, THIS, THAT] [temp segment(5:12)] [pointer]
 
### **Implementing**  pointer
``` c
push pointer 0/1 // 0:THIS, 1:THAT
pop pointer 0/1
```

-->

``` c
*SP=THIS/THAT, SP++
SP--, THIS/THAT=*SP
```

