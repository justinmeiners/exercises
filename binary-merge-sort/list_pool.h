#ifndef LIST_POOL_H
#define LIST_POOL_H

#include <vector>
#include <iostream>
#include <cstddef>
#include <assert.h>

// Requirements on T: semiregular. 
// Requirements on N: integral
template <typename T, typename N = std::size_t>
class list_pool {
public:
    using list_type = N;

private:
    struct node_t {
        T value; 
        list_type next; 
    };

    std::vector<node_t> pool; 

    node_t& node(list_type x) {
        return pool[x - 1]; 
    }
    const node_t& node(list_type x) const {
        return pool[x - 1]; 
    }

    list_type new_list() {
        pool.push_back(node_t()); 
        return list_type(pool.size());
    }

    list_type free_list;

public:
    using size_type = typename std::vector<node_t>::size_type;

    list_type end() const {
        return list_type(0);
    }

    bool is_end(list_type x) const {
        return x == end();
    }

    bool empty() const { 
        return pool.empty();
    }

    size_type size() const { 
        return pool.size();
    }

    size_type capacity() const {
        return pool.capacity();
    }

    void reserve(size_type n) {
        pool.reserve(n);
    }

    list_pool() {
        free_list = end();
    }

    list_pool(size_type n) {
        free_list = end();
        reserve(n); 
    }

    T& value(list_type x) {
        return node(x).value;
    }

    const T& value(list_type x) const {
        return node(x).value;
    }

    list_type& next(list_type x)  {
        return node(x).next;
    }

    const list_type& next(list_type x) const {
        return node(x).next;
    }

    list_type free(list_type x) {
        list_type cdr = next(x); 
        next(x) = free_list; 
        free_list = x; 
        return cdr; 
    }

    list_type allocate(const T& val, list_type tail) {
        list_type list = free_list; 
        if (is_end(free_list)) {
            list = new_list();
        } else {
            free_list = next(free_list);
        }
        value(list) = val; 
        next(list) = tail;
        return list; 
    }

    list_type allocate(const T& val) {
        return allocate(val, end());
    }
};


template <typename T, typename N, typename F>
void traverse_list(list_pool<T, N>& pool, 
        typename list_pool<T, N>::list_type x,
        F func) 
{
    while (!pool.is_end(x)) {
        func(pool.value(x)); 
        x = pool.next(x);
    }
}

// used to merge two sorted lists like std::merge
// x and y should be sorted and from the same pool
template <typename T, typename N, typename Cmp>
typename list_pool<T, N>::list_type merge_list(list_pool<T, N>& pool,
        typename list_pool<T, N>::list_type x,
        typename list_pool<T, N>::list_type y,
        Cmp cmp)
{
    using list_type = typename list_pool<T, N>::list_type;

    list_type head = y;
    list_type previous = pool.end();

    while (!pool.is_end(x)) {    
        // x > y
        while (!pool.is_end(y) && cmp(pool.value(y), pool.value(x))) {
            previous = y;
            y = pool.next(y);
        }

        // !(y < x) x <= y
        list_type next_item = pool.next(x);
        pool.next(x) = y;

        if (pool.is_end(previous)) {
            head = x;
        } else {
            pool.next(previous) = x;
        }

        y = x; 
        x = next_item;
    }

    return head;
}

#endif
