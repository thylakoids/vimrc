The Factory Pattern
===================

It is used to create different types of objects using only one API and using
subclasses for defining which object will be created.

``` mermaid
classDiagram
CsvRow <|-- UserRow
CsvRow <|-- CarRow

CsvRow: print()
```

