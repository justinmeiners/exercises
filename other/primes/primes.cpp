// A C++ idiomatic Sieve of Eratosthenes
// Published on Rosetta Code
// https://rosettacode.org/wiki/Sieve_of_Eratosthenes#Standard_Library

#include <iostream>
#include <algorithm>
#include <vector>

template <typename ForwardIterator>
size_t prime_sieve(ForwardIterator start, ForwardIterator end)
{
    // clear the buffer with 0
    std::fill(start, end, 0);
    // mark composites with 1
    for (ForwardIterator prime_it = start + 1; prime_it != end; ++prime_it)
    {
        if (*prime_it == 1) continue;
        // number at this point
        size_t stride = (prime_it - start) + 1;
        ForwardIterator mark_it = prime_it;
        while ((end - mark_it) > stride)
        {
            std::advance(mark_it, stride);
            *it = 1;
        }
    }
    // copy marked primes into buffer
    ForwardIterator out_it = start;
    for (ForwardIterator it = start; it != end; ++it)
    {
        if (*it == 0)
        {
            *out_it = (it - start) + 1;
            ++out_it;
        }
    }
    return out_it - start;
}

int main(int argc, const char* argv[])
{
    std::vector<int> primes(100);
    size_t count = prime_sieve(primes.begin(), primes.end());
    // display the primes
    for (size_t i = 0; i < count; ++i)
        std::cout << primes[i] << " ";
    std::cout << std::endl;
    return 1;
}
