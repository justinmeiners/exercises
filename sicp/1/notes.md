
Substitution Model

Applicative order:
> "Evaluate arguments and then apply"
> To apply a compound procedure to arguments, evaluate the body of the procedure with each formal pramater replaced by the corresponding argument.


Normal Order:
> "Fully expand and then reduce"
> first substitute operand expressiosn for paramaters until it obtained an expression involving only primitive operators, and then perform the evaluation.



> The contrast between function and procedure is a reflection of the general distinction between describing properties of things and describing how to do things.

Declarative vs imperative knowledge.

Math: declarative. CS: imperative.



Bound and free variables, as in formal logic.

Block structure allows nested definitions of procedure. Sub procedures have access to parent parameters.


linear iterative vs linear recursive

for (...) vs fact(fact(fact(fact... 

tail-recursive: iterative process which is decscribed by a recursive procedure.


lambda's truly are nameless procedures:

```
(define (plus4 x) (+ x 4)) 
; equivalent
(define plus 4 (lamda (x) (+ x 4)))

```

let's are really lambdas


>  No new mechanism is required in the interpreter in order to provide local vairables. A let expression is simply syntactic sugar for the underlying lambda application.




