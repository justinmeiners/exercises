// EXCERCISE
// analyze the complexity of this algorithm

template<typename T>
T remainder_recursive(T a, T b)
{
    if (a - b >= b)
    {
        a = reminder_recursve(a, b + b);
        if (a < b) return a;
    }

    return a - b;
}

// ANALYSIS
//
// 1. How does n change with each call?
//
// Let n be the quotient
// Then a - bn < b
//
// a - 2b(n/2) < b
// But the recursive case only guarentees < 2b
// a - 2b(n/2) + b < b + b
// a - 2b(n/2 - 1/2) < 2b
// a - 2b(n-1)/2 < 2b
//
// So n could be (n-1)/2 or n/2 and satisfy the inequality
//
// 2. Recurrence
//
// Therefore
// T(1) = 1 
// T(n) = 1 + T((n-1)/2)
// T(n) <= 1 + T(n/2) [ I think this is how this works? ]
//
// 3. Closed Form
//
// Hypothesis:
// T(n) = 1 + log(n)
// 
// Base:
// log(1) + 1 = 0 + 1 = 1
//
// Assume T(k) = 1 + log(k) for all k < n
// T(n) = 1 + T(n/2)
//      = 1 + [1 + log(n/2)]
//      = 2 + log(n/2)
//
//     2^T(n) = 2^[2+log(n/2)]
//            = 4(n/2)
//            = 2n
//
//       T(n) = log(2n)
//            = log(2) + log(n)
//            = 1 + log(n)

// NOTES
// One question I am not clear on is what integer
// I should induct on. What constitutes the size of the input?
//
// I think my n should be the quotient, which is unknown at the start.
//
// What should be a unit of work?
// A recursive call.
//
//
// MISTAKE
//
// Hypothesis: 
// T(n) = log(n+1) 
//
// Base: 
// log(1+1) = 1
//
// Assume T(k) = log(k+1) for all k < n
// T(n) = 1 + T(n/2)
//      = 1 + log(n/2 + 1)
//
//      2^T(n) = 2^[1 + log(n/2 + 1)]
//             = 2(n/2) + 1)
//             = n + 2
//          T(n) = log(n+2)
//
//  That did not work out...

