#ifndef BINARY_COMBINER_H
#define BINARY_COMBINER_H

#include <vector>

template <typename Op, typename T = typename Op::argument_type>
struct binary_combiner
{
    std::vector<T> elements;
    Op op;
    T nil;

    binary_combiner(const Op& op, const T& nil) :
        op(op), nil(nil) {}

    void reserve(size_t n) { elements.reserve(n); }

    void add(T x) {
        auto first = elements.begin();
        auto last = elements.end();

        T winner(x);

        while (first != last)
        {
            if (*first == nil) {
                *first = winner;
                return;
            }

            winner = op(*first, winner);
            *first = nil;
            ++first;
        }

        elements.push_back(winner);
    }

    T reduce()
    {
        auto first = elements.begin();
        auto last = elements.end();

        while (first != last && *first != nil)
            ++first;

        if (first == last) return nil;

        auto winner = *first;

        while (++first != last)
        {
            if (*first != nil)
            {
                winner = op(*first, winner);
            }
        }

        return winner;
    }
};


#endif
