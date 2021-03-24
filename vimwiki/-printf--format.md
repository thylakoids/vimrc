`Printf` Format Cheat Sheet
===========================

A Summary of `printf` Format Specifiers
-------------------------------------
placeholder | explain
:-----------|:--
%c          | character
%d          | decimal(integer) number (base 10)
%e          | exponential floating-point number
%f          | floating-point number
%i          | interger(base 10)
%o          | octal number(base 8)
%s          | a string of characters
%u          | unsigned decimal(integer) number
%x          | number in hexadecimal(base 16)
%%          | print a percent sign
\%          | print a percent sign


Controlling Integer Width With `printf`
---------------------------------------

minimum width of three spaces:
``` c
printf("%3d", 0)
printf("%3d", 12345678)
```

left-justifying:
``` c
printf("%-3d", -10)
```

zero-fill:
``` c
printf("%03d", -10)
```

