
rational numbers are a good example of the need for structures, and for operations defined on them so that they can become "regular" types, just like primitives.

C++ is the only language I know of that accomplishes this (python to some extent). Lets find out what Lisp has...

Bleh it turned into a horrible table mess in chapter 2.3.

cons can be defined without any data structures.
It just returns a function which returns a or b depending on an index.

```
(define (cons x y)
    (define (dispatch i)
        (cond ((= m 0) x)
              ((= m 1) y)
              (else (error "Argument not 0 or 1")))
        displatch))

(define (car z) (z 0))
(define (cdr z) (z 1))

```

Obviously, the real thing uses a data structure for memory and performance.


cons just creates pairs. Lists are created by combining pairs
"pairs of pairs"

```
(list a b c d) = (cons a (cons b (cons c (cons d nil))))
```

[Pronunciation Guide for Lisp](https://people.eecs.berkeley.edu/~bh/pronounce.scm)



