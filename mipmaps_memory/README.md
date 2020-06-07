How much memory does a full mipmap chain use?

Let's draw a picture:

![nested squares](square.gif)

And write that as a sum:

![sum1](sum1.gif)

Use a trick to solve for the sum:

![sum2](sum2.gif)

But wait, a mipmap chain isn't an infinite series. It has finite number of terms since it stops at 1. So the 1/3 is actually an upper bound.

To get the exact:

![formula](formula.gif)

Alternatively you could solve it with a recurrence:

![recurrence](recurrence.gif)


