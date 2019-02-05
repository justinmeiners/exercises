> From this perspective, our evaluator is seen to be a universal machine. It mimics other machines when these are described as Lisp programs. This is striking. Try to imagine an analogous evaluator for electrical circuits. This would be a circuit that takes as input a signal encoding the plans for some other circuit, such as a filter. Given this input, the circuit evaluator would then behave like a filter with the same description. Such a universal electrical circuit is almost unimaginably complex. It is remarkable that the program evaluator is a rather simple program.

This analysis step is interesting.. I wonder if this sort of cache is as important on modern computers. I know that in C, having the compiled checks is way faster than having some dynamic data that has to be interpreted.

> Most programming languages are strongly biased toward unidirectional computations (computations with well-defined inputs and outputs). There are, however, radically different programming languages that relax this bias. 



> We will find it convenient to describe the language in terms of the same general framework we have been using all along: as a collection of primitive elements, together with means of combination that enable us to combine simple elements to create more complex elements and means of abstraction that enable us to regard complex elements as single conceptual units.

Means of combination + primitive elements = abstraction
