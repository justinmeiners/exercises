#include <algorithm>
#include <iostream>
#include <functional>
#include <random>
#include <cstddef>
#include "binary_combiner.h"
#include "list_pool.h"

#define SHOW_STEPS true

// this is necessary because the combiner only expects a binary operation
// this handles the comparison function for us and keeps track of the pool
template<typename T, typename N>
struct merge_op
{
    using pool_type = list_pool<T, N>;
    using list_type = typename pool_type::list_type;

    pool_type& pool;

    merge_op(pool_type& pool) : pool(pool) {}
    list_type operator()(list_type a, list_type b)
    {
        return merge_list(pool, a, b, std::less<T>());
    }
};

template<typename N, typename I, typename Cmp>
void merge_sort(I first, I last, Cmp cmp)
{
    // we don't want to keep typing these out
    using T = typename std::iterator_traits<I>::value_type;
    using Op = merge_op<T, N>;
    using Combiner = binary_combiner<Op, typename list_pool<T, N>::list_type>;

    // setup
    auto pool = list_pool<T, N>();
    auto op = Op(pool);
    auto acc = Combiner(Op(pool), pool.end());

    // add to the combiner one element at a time
    for (auto it = first; it != last; ++it) {
        // create a new list for each element
        auto elem = pool.allocate(*it);
        acc.add(elem);

        if (SHOW_STEPS) {
            // for debug/learning
            for (auto i = acc.elements.begin(); i != acc.elements.end(); ++i) {
                std::cout << "{";
                bool separator = false;
                traverse_list(pool, *i, [&separator](const T& x) {  
                    if (separator) {
                        std::cout << ", ";
                    } else {
                        separator = true;
                    }
                    std::cout << x;
                });  
                std::cout << "}\t";
            }
            std::cout << std::endl;
        } 
    }

    // reduce the counter for final merge
    auto final_list = acc.reduce();

    // copy results from list back into iterators
    traverse_list(pool, final_list, [&first](const T& x) { 
        *first++ = x;
    });
}

template <typename N=std::size_t, typename I>
void merge_sort(I first, I last) {
    using T = typename std::iterator_traits<I>::value_type;
    merge_sort<N>(first, last, std::less<T>());
}

int main(int argc, const char* argv[]) {
    // generate a list by shuffling 32 natural numbers
    std::vector<int> v(16); 
    std::iota(v.begin(), v.end(), 1);

    std::random_device rd;
    std::mt19937 g(rd());

    std::shuffle(v.begin(), v.end(), g);

    // the list before it is sorted
    std::cout << "unsorted: ";
    std::for_each(v.begin(), v.end(), [](int x) { 
            std::cout << x << ", "; 
    });

    std::cout << std::endl << std::endl;

    // the int here is not the data type and is optional.
    // it is the integral type used for the list_pool indicies.
    // if ints are 32 bit than each list node can fit inside a 64 bit word.
    // of course short data with a short pointer could also fit inside a 32 bit word
    merge_sort<int>(v.begin(), v.end());

    // output the result
    std::cout << std::endl << "sorted: ";
    std::for_each(v.begin(), v.end(), [](int x) { 
            std::cout << x << ", "; 
    });

    std::cout << std::endl;     

    return 1;
}
