/* Created By: Justin Meiners (2017) 

I helped a friend with a homework project, and made my own in C++.
It needs a standard plaintext dictionary file, with one word per line.

Here is one:
https://github.com/dwyl/english-words/blob/master/words_alpha.txt
*/

#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include <map>
#include <assert.h>
#include <iostream>

using group_map = std::map<std::string, std::vector<std::string> >;

std::string build_group_key(const std::string& word, const std::vector<char>& guesses)
{
    std::stringstream key_stream;

    for (char c : word)
    {
        if (std::find(guesses.begin(), guesses.end(), c) != guesses.end())
        {
            key_stream << c;
        }
        else
        {
            key_stream << '_';
        }
    }

    return key_stream.str();
}

std::vector<std::string> read_canidates(int word_length)
{
    std::vector<std::string> canidates;
    std::ifstream stream("dictionary.txt");

    std::string line;
    while (std::getline(stream, line))
    {
        // trimming
        line.erase(line.begin(), std::find_if(line.begin(), line.end(), [](int ch) {
            return !std::isspace(ch);
        }));

        line.erase(std::find_if(line.rbegin(), line.rend(), [](int ch) {
            return !std::isspace(ch);
        }).base(), line.end());


        if (line.size() == word_length)
            canidates.push_back(line);
    }

    return canidates;
}

std::string find_largest_group(const group_map& groups, const std::vector<char>& guesses, int word_length)
{
    int most_words = 0;
    std::vector<std::string> largest;

    for (auto& pair : groups)
    {
        if (pair.second.size() > most_words)
        {
            largest.clear();
            most_words = pair.second.size();
        }

        if (pair.second.size() == most_words)
            largest.push_back(pair.first);
    }

    // Choose the largest if there is only one
    if (largest.size() == 1) return largest[0];

    int fewest_letters = word_length;
    std::vector<std::string> fewest;

    for (std::string& key : largest)
    {
        int letters = word_length - std::count(key.begin(), key.end(), '_');

        // 1. Choose the group in which the letter does not appear at all.
        if (letters == 0) return key;

        if (letters < fewest_letters)
        {
            fewest.clear();
            fewest_letters = letters;
        }

        if (letters == fewest_letters)
            fewest.push_back(key);
    }

    // 2. If each group has the guessed letter, choose the one with the fewest letters.
    if (fewest.size() == 1) return fewest[0];

    // 3. If this still has not resolved the issue, choose the one with the rightmost guessed letter.  
    std::vector<std::string> right_most;

    int index = word_length - 1; 
    while (right_most.size() < 1)
    {
        assert(index >= 0);
        for (auto& pair : groups)
        {
            const std::string& key = pair.first;

            if (key[index] != '_')
                right_most.push_back(key);
        }

        --index;
    }

    // 4.  If there is still more than one group, choose the one with the next 
    //  rightmost letter. Repeat this step (step 4) until a group is chosen.    
    index = word_length - 1;
    while (index >= 0 && right_most.size() > 1)
    {
        // if we found one here, this letter becomes a deal breaker
        bool found_one = false;

        for (std::string& word : right_most)
        {
            if (word[index] != '_')
            {
                found_one = true;
                break;
            }
        }
        
        if (found_one)
        {
            // find which words made the cut
            std::vector<std::string> to_save;

            for (std::string& word : right_most)
            {
                if (word[index] != '_')
                    to_save.push_back(word);
            }

            right_most = to_save;
        }

        --index;
    }

    assert(right_most.size() > 0);
    return right_most[0];
}

int main(int argc, const char* argv[])
{
    int word_length = 0;
    int bad_attempts = 10;

    std::cout << "Welcome to Cheating Hangman\n" << std::endl;
    std::cout << "Enter the length of word to play: ";
    std::cin >> word_length;

    std::vector<char> guesses;
    std::vector<std::string> dictionary = read_canidates(word_length);

    if (word_length < 2)
    {
        std::cout << "Done\n" << std::endl;
        return 0;
    }

    bool done = false;

    while (!done)
    {
        std::cout << std::endl;
        std::cout << "Your guesses:";
        
        for (char c : guesses)
            std::cout << " " << c;

        std::cout << std::endl;

        std::cout << "You have: " << bad_attempts << " guesses" << std::endl;
        std::cout << "Enter a guess for a letter: ";

        char guess;
        std::cin >> guess;

        if (!isalpha(guess))
        {
            done = true;
            break;
        }

        if (std::find(guesses.begin(), guesses.end(), guess) == guesses.end())
        {
            guesses.push_back(guess);
            std::sort(guesses.begin(), guesses.end());
        }

        group_map word_groups;

        for (std::string& word : dictionary)
        {
            std::string key = build_group_key(word, guesses);
            word_groups[key].push_back(word);
        }

        std::string largest_key = find_largest_group(word_groups, guesses, word_length);
        dictionary = word_groups[largest_key];

        int found_count = std::count(largest_key.begin(), largest_key.end(), guess);

        if (found_count > 0)
        {
            std::cout << "Yes, the word has " << found_count << " " << guess << "'s" << std::endl;
        }
        else
        {
            --bad_attempts;
            std::cout << "No " << guess << "'s" << std::endl;

            if (bad_attempts < 1)
            {
                std::cout << "You lose" << std::endl;

                int index = word_groups[largest_key].size() / 2;
                std::cout << "The word was: " << word_groups[largest_key][index] << std::endl;;
                done = true;
            }
        }

        if (std::find(largest_key.begin(), largest_key.end(), '_') == largest_key.end())
        {
            std::cout << "You win!" << std::endl;
            done = true;
        }

        std::cout << "word: " << largest_key << std::endl;
    }

    std::cout << "done" << std::endl;

    return 1;
}
