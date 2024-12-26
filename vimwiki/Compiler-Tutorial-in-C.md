# Compiler Tutorial in C

``` text
term = <input> | variable | literal
expression = term | term + term | ...
rel = term < term | ...
assign = variable = expression
instr = assign | <if> rel <then> instr | <goto> :label | <output> term
label = :label
```

Example:
```
a = input
b = 123
b = 1 + 123
if 1 < 10 then a = 1
:label1
output a
```

The snippet is a grammar for a simple language. The grammar is written in
Backus-Naur Form (BNF). The grammar defines the syntax of the language. The
language has variables, literals, input, output, assignment, if-then, goto, and
labels. The grammar is used to write a compiler for the language. The compiler
translates the source code of the language into machine code. The machine code
is executed by the computer. The compiler is written in C. The tutorial
explains how to write the compiler. The tutorial is a series of articles. The
articles explain the different parts of the compiler. The articles explain the
different phases of the compiler. The phases are lexical analysis, syntax
analysis, semantic analysis, code generation, and optimization.
