# Rabble

An implementation of a Forth-like language in Perl 6.

## Usage

```
rabble [--debug|-d] <file>
rabble [--expression|-e] [--debug|-d] <expr>
```

### Examples
```
\\ Multipy
5 2 * . \\= 10

\\ Dip below last value to apply quotation
5 10 2 [ * ] dip .S \\= [50 2]>

\\ Apply quotation
7 6 [2 3 + + +] apply . \\= 18
```

## Plan

To build a decently well-featured Forth in Perl 6, learn more about Perl 6 and Forth in the process, and explore ideas in all aspects.

### Status

Supports some basic words, anonymous blocks, and named functions.

### Upcoming

* Add more words
* Implement a return stack
* Tests
* Debugger
* REPL
* Documentation
