#include <iostream>
#include <algorithm>
#include <chrono>
#include <map>
#include <random>
#include <string>
#include <unordered_map>
#include <vector>
#include <cctype>

#define MODE_MAP_MAP 0
#define MODE_MAP_PAIR 1
#define MODE_HASH_MAP 2
#define MODE_HASH_PAIR 3


// defined by GCC
//#define TEST_MODE MODE_MAP_MAP

using highres_clock = std::chrono::high_resolution_clock;
using time_point = std::chrono::time_point<highres_clock>;

double deltaMs(time_point start, time_point end)
{
    auto delta = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    return delta.count() / 1000.0;
}

struct pair_hash {
    template <class T1, class T2>
        std::size_t operator () (const std::pair<T1,T2> &p) const {
            auto h1 = std::hash<T1>{}(p.first);
            auto h2 = std::hash<T2>{}(p.second);

            return h1 ^ h2;  
        }
};

int main(int argc, const char* argv[])
{

    std::cout << TEST_MODE << std::endl;
    // collects all words size_to memory
    // normally I wouldn't do that
    // but I want to be able to track
    // the construction time independent
    // of this mess
    std::vector<std::string> words;
    std::string line;
    while (std::getline(std::cin, line)) 
    {
        auto front = line.begin();
        auto back = front;
        while (back != line.end())
        {
            front = std::find_if(back, line.end(), isalpha);
            back = std::find_if_not(front, line.end(), isalpha);

            if (front != back) 
            {
                std::string word = std::string(front, back);
                std::transform(word.begin(), word.end(), word.begin(), tolower);
                words.push_back(word);
            }
        }
    }

    std::random_device rd;
    std::uniform_int_distribution<size_t> dist(0, words.size());


    // benchmark time
    time_point start, end;

    start = highres_clock::now();

#if TEST_MODE == MODE_MAP_MAP
    std::map<size_t, std::map<std::string, size_t>> histogram;
#elif TEST_MODE == MODE_MAP_PAIR
    std::map<std::pair<size_t, std::string>, size_t> histogram;
#elif TEST_MODE == MODE_HASH_MAP
    std::unordered_map<size_t, std::map<std::string, size_t>> histogram;
#elif TEST_MODE == MODE_HASH_PAIR
    std::unordered_map<std::pair<size_t, std::string>, size_t, pair_hash> histogram;
#endif


    for (const auto &word : words)
    {
#if TEST_MODE == MODE_MAP_MAP || TEST_MODE == MODE_HASH_MAP
        ++histogram[word.size()][word];
#elif TEST_MODE == MODE_MAP_PAIR || TEST_MODE == MODE_HASH_PAIR
        ++histogram[std::make_pair(word.size(), word)];
#endif
    }


    end = highres_clock::now();
    std::cout << "build time: " << deltaMs(start, end) << " ms" << std::endl;

    start = highres_clock::now();

    size_t total_occurrences;
    const size_t N = 30000;
    for (size_t i = 0; i < N; ++i)
    {
        size_t index = dist(rd);
        auto& to_lookup = words[index];

#if TEST_MODE == MODE_MAP_MAP || TEST_MODE == MODE_HASH_MAP
        size_t occurrences = histogram[to_lookup.size()][to_lookup];
#elif TEST_MODE == MODE_MAP_PAIR || TEST_MODE == MODE_HASH_PAIR
        size_t occurrences = histogram[std::make_pair(to_lookup.size(), to_lookup)];
#endif

        // fake task to hopefully keep the 
        // optimizations away
        total_occurrences += occurrences;
    }

    end = highres_clock::now();
    std::cout << "occurrences: " << total_occurrences << std::endl;
    std::cout << "search time: " << deltaMs(start, end) << " ms" << std::endl;


    /*
    for (const auto &pair : histogram)
    {
        std::cout << pair.first << std::endl;
    }
    */
}
