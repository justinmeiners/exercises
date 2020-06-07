/* Created by: Justin Meiners (2017) */
#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>
#include <string>
#include <tuple>
#include <sstream>

void add_frequency(std::string text, int* frequency_table)
{
    for (auto i = text.begin(); i != text.end(); ++i)
    {
        unsigned char char_index = static_cast<unsigned char>(*i);
        frequency_table[char_index] += 1;
    }
}

template <typename X, typename Y>
struct compare_second
{
    bool operator()(const std::pair<X, Y>& a, const std::pair<X, Y>& b) const
    {
        return a.second < b.second;
    }
};

struct huff_tree
{
    typedef short index_type;

    struct node
    {
        node() : key('\0'), left(-1), right(-1) {}
        node(unsigned char key) : key(key), left(-1), right(-1) {}

        unsigned char key;
        index_type left;
        index_type right;
    };

    short head;
    std::vector<node> nodes;
    std::vector<std::string> lookup_table;

    huff_tree() : head(-1) {}

    static void build_lookup_table(huff_tree& t, int node_index, const std::string& prefix)
    {
        const node& n = t.nodes[node_index];
        if (n.left == -1 && n.right == -1)
        {
            t.lookup_table[n.key] = prefix;
        } 
        else
        {
            build_lookup_table(t, n.left, prefix + '0'); 
            build_lookup_table(t, n.right, prefix + '1');
        }
    }

    static huff_tree build(const int* frequency_table)
    {
        huff_tree t;
        auto cmp = compare_second<index_type, int>();
        std::vector< std::pair<index_type, int> > heap;

        for (int i = 0; i < 255; ++i)
        {
            if (frequency_table[i] == 0)
                continue;

            index_type index = static_cast<index_type>(t.nodes.size());
            heap.push_back(std::make_pair(index, frequency_table[i]));

            unsigned char character = static_cast<unsigned char>(i);
            t.nodes.push_back(node(character)); 
        }

        std::make_heap(heap.begin(), heap.end(), cmp);

        while (heap.size() > 1)
        { 
            node new_node;
            auto x = std::min_element(heap.begin(), heap.end(), cmp);
            int sum = (*x).second;
            new_node.left = (*x).first;
            heap.erase(x);
           
            auto y = std::min_element(heap.begin(), heap.end(), cmp);
            sum += (*y).second;
            new_node.right = (*y).first;
            heap.erase(y);
 
            index_type new_node_index = static_cast<index_type>(t.nodes.size());
            t.nodes.push_back(new_node);

            heap.push_back(std::make_pair(new_node_index, sum));
            std::push_heap(heap.begin(), heap.end(), cmp); 
        }

        t.head = heap.front().first;
        t.lookup_table.resize(255);
        build_lookup_table(t, t.head, std::string());

        return t;
    }

    void print_node(index_type node_index, int indent) const
    {
        const auto& n = nodes[node_index];
        std::cout << std::setw(indent);
        std::cout << n.key << std::endl;

        if (n.left != -1)
            print_node(n.left, indent);

        if (n.right != -1)
            print_node(n.right, indent + 2); 
    }

    void print() const
    {
        print_node(head, 0);
    }
};


void simple_test()
{

    int frequency_table[255];
    memset(frequency_table, 0, sizeof(frequency_table));

    frequency_table['A'] = 5;
    frequency_table['B'] = 2;
    frequency_table['C'] = 3;
    frequency_table['D'] = 4;
    frequency_table['E'] = 10;
    frequency_table['F'] = 1;
 
    auto tree = huff_tree::build(frequency_table);
    tree.print();
}

int main(int argc, const char* argv[])
{
    int line_count = 0;
    int frequency_table[255];
    memset(frequency_table, 0, sizeof(frequency_table));
    
    std::string line;
    while (std::getline(std::cin, line))
    {
        add_frequency(line, frequency_table);
        ++line_count;
    }

    auto tree = huff_tree::build(frequency_table);

    for (int i = 0; i < 255; ++i)
    {
        if (tree.lookup_table[i].size() == 0)
            continue;
        std::cout << static_cast<unsigned char>(i) << ": ";
        std::cout << tree.lookup_table[i] << std::endl;
    }

    return 1;
}
