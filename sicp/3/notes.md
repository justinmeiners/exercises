Model the program after the real system.

Two world views of systmes
1. objects
2. streams (flows, processes, etc)

objects - how can objects change and yet maintain identity?
This is a vastly different way to think about state. More philosphical.

> An object is said to have state if its behaviour is influenced by its history.

> The view that a system is composed of separate objects is most useful when teh state variables of the system can be grouped into clsoely coupled subsystems that are only loosely coupled to other subsystems.

Interesting that this book started with pure functional, and then introduced state. Usually the natural progression is state. However, the mathematical analogy is probably more important for MIT students.

Side Note: [LISP Machines](https://en.wikipedia.org/wiki/Lisp_machine")


> The fact that the random-number generator’s insides are leaking out into other parts of the program makes it difficult for us to isolate the Monte Carlo idea so that it can be applied to other tasks.


> An enviornment is a sequence of frames
> Each frame is a table which associate variable names with values
> each frame has a pointer to the enclosing envioronment
> The value of a variable with respect to an environment is the value given by the binding of the variable in the first frame in the environment that contains a binding for that variable.


How are cons cells implemented? Indirection for everything sounds horribly ineffecient on modern hardward.

https://stackoverflow.com/questions/30283253/are-lisp-lists-always-implemented-as-linked-lists-under-the-hood

https://en.wikipedia.org/wiki/CDR_coding

https://en.wikipedia.org/wiki/S-expression

https://www.quicklisp.org/beta/



The method of describing concurrent events as a sequence is interesting.
; process 1 has a schedule of (a, b, c)
; process 1 haS A schedule of (x, y, z)

; how many different ways could these events occur?
; = 20


> As a data abstraction, streams are the same as lists. The difference is the time at which the elements are evaluated. With ordinary lists, both the car and the cdr are evaluated at construction time. With streams, the cdr is evaluated at selection time.


> What we have done is to decouple the actual order of events in the computation from the apparent structure of our procedures. We write procedures as if the streams existed ‘‘all at once’’ when, in reality, the computation is performed incrementally, as in traditional programming styles.


